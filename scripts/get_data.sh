#!/usr/bin/env bash
set -euo pipefail

# Concept DOI: punta sempre all'ultima versione
CONCEPT_DOI="10.5281/zenodo.18299619"

OUTDIR="data"
mkdir -p "$OUTDIR"

# Nomi esatti dei file su Zenodo (devono combaciare)
FILES_JSON='["st1.fastq","st2.fastq","Ref122.fasta"]'

echo "Concept DOI: $CONCEPT_DOI"
echo "Output:      $OUTDIR"
echo

# 1) Risolvi il DOI e trova l'URL finale Zenodo (latest)
FINAL_URL="$(curl -Ls -o /dev/null -w '%{url_effective}' "https://doi.org/${CONCEPT_DOI}")"
if [[ -z "$FINAL_URL" ]]; then
  echo "ERRORE: non riesco a risolvere il DOI ${CONCEPT_DOI}" >&2
  exit 2
fi

echo "DOI risolto a: $FINAL_URL"

# 2) Estrai l'ID record dall'URL finale (…/records/<id>)
RECORD_ID="$(echo "$FINAL_URL" | sed -n 's#.*zenodo\.org/records/\([0-9]\+\).*#\1#p')"
if [[ -z "$RECORD_ID" ]]; then
  echo "ERRORE: non riesco a estrarre RECORD_ID da: $FINAL_URL" >&2
  echo "Atteso un URL tipo: https://zenodo.org/records/<ID>" >&2
  exit 3
fi

echo "Record ID:   $RECORD_ID"
echo

# 3) Scarica i file usando Zenodo API
RECORD_ID="$RECORD_ID" OUTDIR="$OUTDIR" FILES_JSON="$FILES_JSON" python3 - <<'PY'
import json, os, sys, urllib.request
from urllib.error import HTTPError, URLError

record_id = os.environ["RECORD_ID"]
outdir = os.environ["OUTDIR"]
files_needed = json.loads(os.environ["FILES_JSON"])

api = f"https://zenodo.org/api/records/{record_id}"

def die(msg, code=2):
    print(msg, file=sys.stderr)
    sys.exit(code)

try:
    with urllib.request.urlopen(api) as r:
        data = json.loads(r.read().decode("utf-8"))
except HTTPError as e:
    die(f"ERRORE: Zenodo API ha risposto {e.code} su {api}.")
except URLError as e:
    die(f"ERRORE: non riesco a contattare Zenodo ({e}).")
except Exception as e:
    die(f"ERRORE: risposta Zenodo non leggibile ({e}).")

files = data.get("files") or []
if not files:
    die("ERRORE: nessun file trovato nel record (campo 'files' vuoto).")

m = {}
for f in files:
    key = f.get("key")
    links = f.get("links") or {}
    dl = links.get("download") or (links.get("self") + "?download=1" if links.get("self") else None)
    if key and dl:
        m[key] = dl

missing = [x for x in files_needed if x not in m]
if missing:
    die("ERRORE: questi file non risultano nel record Zenodo:\n  - " + "\n  - ".join(missing) +
        "\nControlla i nomi su Zenodo (maiuscole/minuscole contano).", 4)

print("Trovati i link. Download in corso...\n")
os.makedirs(outdir, exist_ok=True)

for name in files_needed:
    url = m[name]
    outpath = os.path.join(outdir, name)
    print(f"- {name}  ->  {outpath}")
    try:
        with urllib.request.urlopen(url) as resp, open(outpath, "wb") as out:
            while True:
                chunk = resp.read(1024 * 1024)  # 1MB
                if not chunk:
                    break
                out.write(chunk)
    except Exception as e:
        die(f"ERRORE durante il download di {name}: {e}", 5)

print("\nOK. File scaricati in:", outdir)
PY

echo
echo "Elenco file in $OUTDIR:"
ls -lh "$OUTDIR"
