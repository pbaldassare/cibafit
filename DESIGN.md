# Design di CibaFit: Cedro

App da usare, non da ammirare: la struttura è familiare, l'identità sta in colori, tipografia e un solo gesto.

- **Colori:** verde profondo `#0B3B3C` per barre e struttura, sfondo `#F4F6EF`, cedro `#D9E021` solo per ciò che è attivo o per l'azione principale. Il cedro non regge testo su sfondo chiaro.
- **Font:** Bricolage Grotesque per i titoli, Hanken Grotesk per tutto il resto. I numeri nutrizionali usano `tabular-nums`.
- **Marchio:** piatto aperto a forma di C con il punto cedro, in `src/components/BrandLogo.tsx`.
- **Superfici:** liste con righe separate, niente card annidate, niente sfumature o vetro.
- **Icone:** lucide, tratto 1.75. Niente emoji come icone nelle schermate nuove.
- **Token:** in `src/index.css`. Non scrivere colori a mano nei componenti.

Da completare: le schermate più vecchie contengono ancora emoji e alcuni colori scritti a mano.
