# bioinfo-terminal-lab

## Link del laboratorio (Gitpod / Ona)
Apri:
https://app.gitpod.io/#https://github.com/albertoacquadro/bioinfo-terminal-lab

---

## Primo avvio in assoluto (account + possibile verifica carta)
1) Accedi con **GitHub** (o crea l’account GitHub se non lo hai).
2) Gitpod/Ona potrebbe chiederti una **verifica del metodo di pagamento** (anche solo per attivare l’account o sbloccare risorse).
   - Se compare, usa **un metodo di pagamento personale** (non del docente).
   - Se appare “Your card was declined”, prova più tardi o usa un altro metodo (spesso è un blocco banca/antifrode).

> Suggerimento: fai questo passaggio **prima** della lezione, così in aula non perdi tempo.

---

## Prima volta nel laboratorio (creazione environment)
Dopo aver aperto il link:

### Se ti trovi nella Home di Ona
- clicca **New Environment**
- scegli/incolla il repository: `albertoacquadro/bioinfo-terminal-lab`
- conferma e attendi (cloning + avvio container)

### Se entri direttamente nel laboratorio
Attendi che finisca il setup automatico.

---

## Come aprire il Terminale (passo più importante)
Per chi è alle prime armi: il terminale non sempre è visibile subito.

### Metodo A (consigliato): menu in alto
1) In alto a sinistra clicca **☰** (menu) se non vedi la barra dei menu.
2) Poi vai su **Terminal → New Terminal**.

### Metodo B: scorciatoia
- **Ctrl + Shift + C** (apre un nuovo terminale)

> Se non funziona, riprova con Metodo A.

---

## Verifica software
Nel terminale esegui:
```bash
./scripts/check_env.sh
