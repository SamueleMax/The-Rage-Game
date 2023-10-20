# The Rage Game
### Creato da Samuele Max
*Il gioco è stato testato su Linux e su Windows, ma non su Mac*

## Cloning
1. Scaricare Godot 3 (non 4)
2. Clonare questo repo
3. Aprire Godot e importare il file chiamato "project.godot"

## Gerarchia cartelle
- **assets:** contiene le immagini, gli audio ecc.
- **enemies:** contiene le scene per i nemici
- **hud:** contiene le scene per l'heads-up-display (in alto a sinistra le informazioni su tempo rimasto, quanti nemici uccisi ecc.)
- **items:** contiene le scene per i checkpoint e per la frutta
- **levels:** contiene le scene per i livelli
- **menus:** contiene le scene per i menu
- **players:** contiene le scene per i giocatori
- **scripts:** contiene gli script per le varie scene
- **public:** contiene degli script generali che vanno di continuo
- **themes:** contiene i temi per i pulsanti
- **tilemaps:** contiene le scene per le tilemap
- **traps:** contiene le scene per le trappole
- **Exported:** contiene i file esportati per Windows, Mac, e Linux

## Come giocare
- Nelle impostazioni si può abilitare la modalità a schermo intero e si può scegliere un player (cambia solo l'aspetto, quando viene cliccata una skin nel menu non viene dato alcun feedback ma è stata selezionata)
- Cliccando su "Play" si inizia dal primo livello. Il giocatore si può controllare usando WAD o le freccette (W oppure freccia su per saltare)
- In alto a sinistra viene visualizzato il numero di frutta preso, i nemici uccisi, e il tempo; anche se finisce il tempo non si muore, ma si perde un punto
- Alla fine di ogni livello vengono calcolati i punti: se tutte le mele sono state prese, +1; se tutti i nemici sono stati uccisi, +1; se si è completato in tempo, +1. In realtà questi punti non servono a niente
- Per ricominciare il livello da capo si può premere "r", per scendere dal pollo "ctrl" (non mentre si è in volo), per uscire premere "esc", apparirà un messaggio di conferma
- Siccome il gioco è molto difficile (l'ho fatto apposta, per quello si chiama The Rage Game), ci sono dei cheat, che si abilitano finendo il gioco. Se si vogliono abilitare prima, basta creare un file senza estensione chiamato "game_finished" nella stessa cartella dell'eseguibile del gioco, riavviare il gioco, andare in impostazioni, secret settings, enable cheats
- I cheat disponibili sono:
    - Premere F per volare (poi si può ripremere F per disattivare il volo)
    - Premere I per essere invincibili (non prendi danno dai nemici e se cadi nel vuoto ti teletrasporta su e attiva la fly)
    - Premere G, digitare un numero e invio per andare a quel livello (ci sono 10 livelli totali)

## Crediti
Il gioco è stato creato e programmato interamente da me, usando il game engine open source [Godot Engine](https://godotengine.org/). La grafica non l'ho fatta io, ma ho usato [Pixel Adventure 1](https://pixelfrog-assets.itch.io/pixel-adventure-1) e [Pixel Adventure 2](https://pixelfrog-assets.itch.io/pixel-adventure-2). Il font utilizzato non mi ricordo come si chiama ma era libero da utilizzare.
