;******* Pep/8 Jeu de roche-papier-ciseaux, 2021/02/25
;
; Cette classe represente un programme avec lequel deux joueurs humains 
; peuvent jouer au jeu de roche-papier-ciseaux entre eux. 
; Regle du jeu: Chaque joueur choisit l'un des trois objets et on determine 
; qui gagne la manche en comparant leur choix. 
; Roche (r) gagne contre ciseaux (c), ciseaux (c) gagne contre papier (p) et 
; papier (p) gagne contre roche (r). 
; 
; Author: XRF
;         SCA
;
;******* Debut du programme
main:            LDA         0,i          
                 STRO        msgTiret,d   ; Afficher message de bienvenue 
                 STRO        msgWelc,d    
                 STRO        msgTiret,d   
                 STRO        msgLine,d
                 STRO        msgTour,d    ; Demander le nombre de manches a jouer
                 DECI        nbrTour,d    ; Stocker le nombre saisi par l'utilisateur dans nbrTour
                 STRO        msgLines,d                
                 LDA         nbrTour,d
                 CPA         0,i          ; Comparer nbrTour avec 0, fin du programme s'il s'agit d'un nombre negatif
                 BRLT        endError     ; Si nbrTour >= 0 
                 LDA         0,i          ; Reinitialiser A a 0 avant de brancher parite 
                 BR          parite
;                
;******* Verifier si le nombre de manches saisi par l'utilisateur est pair ou impair                 
parite:          CPA         nbrTour,d    
                 BREQ        pair         ; Si A != nbrTour
                 ADDA        1,i          ; A = A + 1
                 CPA         nbrTour,d    
                 BREQ        impair       ; Si A != nbrTour
                 ADDA        1,i          ; A = A + 1
                 BR          parite
pair:            LDA         nbrTour,d 
                 ADDA        1,i          ; A = nbrTour + 1
                 STA         nbrTour,d    ; Stocker A dans nbrTour
                 STA         nbrLeft,d    ; Stocker A dans nbrLeft
                 BR          findMin 
impair:          STA         nbrLeft,d    ; Stocker A dans nbrLeft
                 BR          findMin 
;
;******* Determiner le score minimal necessaire pour atteindre la victoire
findMin:         LDA         scoreWin,d   ; scoreWin est initialise a 1
                 ADDA        scoreWin,d   ; A = scoreWin + scoreWin
                 CPA         nbrTour,d    
                 BRGE        tourJ1       ; Si A <= nbrTour
                 LDA         scoreWin,d 
                 ADDA        1,i          ; A = scoreWin + 1
                 STA         scoreWin,d   ; Stocker A dans scoreWin
                 BR          findMin                
;
;******* Jouer le jeu 
tourJ1:          LDA         0,i
                 LDA         scoreWin,d 
                 CPA         scoreJ1,d     
                 BRLE        winnerJ1     ; Si scoreWin > scoreJ1, joueur 1 n'a pas encore gagne, on continue le jeu
                 CPA         scoreJ2,d     
                 BRLE        winnerJ2     ; Si scoreWin > scoreJ2, joueur 2 n'a pas encore gagne, on continue le jeu  
                 STRO        msgReste,d   ; Afficher le nombre de manches restant 
                 DECO        nbrLeft,d    
                 STRO        msgTours,d 
                 STRO        msgJ1,d      ; Demander au joueur 1 d'entrer son choix (r, p ou c) 
                 STRO        msgChoix,d   
                 CHARI       choixJ1,d    ; Stocker le 1er char saisi par joueur 1 dans choixJ1
                 CHARI       charIn,d     ; Stocker le 2e char saisi par joueur 1 dans charIn 
                 LDA         0,i
                 LDBYTEA     choixJ1,d    ; Load choixJ1 dans A avant de brancher checkRPC
                 BR          checkRPC
tourJ2:          LDA         0,i
                 STRO        msgJ2,d      ; Demander au joueur 2 d'entrer son choix (r, p ou c) 
                 STRO        msgChoix,d   
                 CHARI       choixJ2,d    ; Stocker le 1er char saisi par joueur 2 dans choixJ2
                 CHARI       charIn,d     ; Stocker le 2e char saisi par joueur 2 dans charIn
                 LDA         0,i
                 LDBYTEA     choixJ2,d    ; Load choixJ2 dans A avant de brancher checkRPC
                 BR          checkRPC  
;
;******* Verifier si l'entree du joueur est valide
checkRPC:        CPA         'r',i
                 BREQ        enterKey     ; Si choixJ1 != 'r' 
                 CPA         'p',i
                 BREQ        enterKey     ; Si choixJ1 != 'p'
                 CPA         'c',i
                 BREQ        enterKey     ; Si choixJ1 != 'c'
                 BR          endError         
;
;******* Verifier si le 2e caractere saisi par les joueurs est bien un retour de chariot        
enterKey:        LDA         0,i
                 LDBYTEA     charIn,d 
                 CPA         '\n',i
                 BRNE        endError     ; Si charIn == '\n' 
                 LDA         0,i
                 LDA         nbrPlyed,d   
                 ADDA        1,i          ; A = nbrPlyed + 1 (tout est verifie pour ce joueur, on incremente nbrPlyed de 1)
                 STA         nbrPlyed,d   ; Stocker A dans nbrPlyed
                 BR          count
;                   
;******* Verifier qui a joue
count:           LDA         0,i
                 LDA         nbrPlyed,d   
                 CPA         1,i          ; Si nbrPlyed == 1, c'est a joueur 2 de jouer
                 BREQ        tourJ2       ; Si nbrPlyed != 1
                 CPA         2,i          ; Si nbrPlyed == 2, toutes les entrees des deux joueurs sont validees, brancher rpcJ1
                 BREQ        rpcJ1        ; Si nbrPlyed != 2 
;                
;******* Comparer le choix des deux joueurs 
rpcJ1:           LDA         0,i
                 LDBYTEA     choixJ1,d
                 CPA         'r',i
                 BREQ        rocheJ1      ; Si choixJ1 != 'r'
                 CPA         'p',i
                 BREQ        papierJ1     ; Si choixJ1 != 'p'
                 CPA         'c',i
                 BREQ        ciseauJ1     ; Si (choixJ1 != 'r') && (choixJ1 != 'p'), il est certain que choixJ1 == 'c'       
rocheJ1:         LDA         0,i
                 LDBYTEA     choixJ2,d
                 CPA         'r',i
                 BREQ        nulle        ; Si choixJ2 != 'r'
                 CPA         'p',i
                 BREQ        calculJ2     ; Si choixJ2 != 'p'
                 CPA         'c',i
                 BREQ        calculJ1     ; Si (choixJ2 != 'r') && (choixJ2 != 'p'), il est certain que choixJ2 == 'c'
papierJ1:        LDA         0,i
                 LDBYTEA     choixJ2,d
                 CPA         'r',i
                 BREQ        calculJ1     
                 CPA         'p',i
                 BREQ        nulle        
                 CPA         'c',i
                 BREQ        calculJ2    
ciseauJ1:        LDA         0,i
                 LDBYTEA     choixJ2,d
                 CPA         'r',i        
                 BREQ        calculJ2
                 CPA         'p',i
                 BREQ        calculJ1
                 CPA         'c',i
                 BREQ        nulle
nulle:           STRO        msgNulle,d   ; Afficher le message de manche nulle    
                 STRO        msgLine,d 
                 LDA         0,i
                 LDA         nbrPlyed,d   
                 SUBA        2,i          ; A = nbrPlyed - 2 (pour recommencer a compter le tour de chacun a partir de 0)
                 STA         nbrPlyed,d   ; Stocker A dans nbrPlyed
                 BR          tourJ1 
;      
;******* Le joueur 1 a gagne la manche
calculJ1:        LDA         0,i
                 LDA         scoreJ1,d 
                 ADDA        1,i          ; A = ScoreJ1 + 1
                 STA         scoreJ1,d    ; Stocker A dans scoreJ1
                 STRO        msgJ1,d      ; Afficher le message pour annoncer le gagnant de la manche
                 STRO        msgWin,d
                 DECO        scoreJ1,d    ; Afficher le score des deux joueurs
                 STRO        msgWin2,d
                 LDA         0,i
                 DECO        scoreJ2,d
                 STRO        msgLines,d 
                 LDA         nbrLeft,d    
                 SUBA        1,i          ; A = nbrLeft - 1 (une manche completee, le nombre de manches restant diminue de 1)
                 STA         nbrLeft,d    ; Stocker A dans nbrLeft
                 LDA         0,i
                 LDA         nbrPlyed,d 
                 SUBA        2,i          ; A = nbrPlyed - 2 (pour recommencer a compter le tour de chacun a partir de 0)
                 STA         nbrPlyed,d   ; Stocker A dans nbrPlyed
                 BR          tourJ1
;
;******* Le joueur 2 a gagne la manche
calculJ2:        LDA         0,i
                 LDA         scoreJ2,d
                 ADDA        1,i
                 STA         scoreJ2,d
                 STRO        msgJ2,d
                 STRO        msgWin,d
                 DECO        scoreJ1,d
                 STRO        msgWin2,d
                 LDA         0,i
                 DECO        scoreJ2,d
                 STRO        msgLines,d
                 LDA         nbrLeft,d
                 SUBA        1,i
                 STA         nbrLeft,d
                 LDA         0,i
                 LDA         nbrPlyed,d 
                 SUBA        2,i
                 STA         nbrPlyed,d
                 BR          tourJ1
;
;******* Annoncer le gagnant du jeu
winnerJ1:        STRO        msgJ1,d     
                 STRO        msgCongr,d 
                 BR          endWin 
winnerJ2:        STRO        msgJ2,d 
                 STRO        msgCongr,d 
                 BR          endWin 
;
; Afficher le message d'erreur si l'entree est invalide
endError:        STRO        msgError,d 
                 STOP          
;
;******* Afficher le score final 
endWin:          STRO        msgScore,d   
                 DECO        scoreJ1,d    
                 STRO        msgWin2,d
                 DECO        scoreJ2,d      
                 STOP        
;
;******* Variables numeriques
nbrTour:         .WORD       0            ; Nombre de manches entre par l'utilisateur (manches à jouer)
nbrLeft:         .WORD       0            ; Nombre de manches restant
nbrPlyed:        .WORD       0            ; Si nbrPlyed == 0, c'est a joueur 1 de jouer; Si nbrPlyed == 1, c'est a joueur 2 de jouer; Si nbrPlyed == 2, tous les deux ont joue, on peut commencer a comparer leur choix 
scoreWin:        .WORD       1            ; Score minimal pour atteindre la victoire
scoreJ1:         .WORD       0            ; Score du joueur 1 
scoreJ2:         .WORD       0            ; Score du joueur 2
;
;******* Variables char
choixJ1:         .BYTE       ' '          ; Choix du joueur 1    
choixJ2:         .BYTE       ' '          ; Choix du joueur 2 
charIn:          .BYTE       ' '          ; Le 2e caratere saisi par les joueurs       
;
;******* Constantes (chaines de caracteres)
msgTiret:        .ASCII      "-----------------------------------------------\n\x00"
msgWelc:         .ASCII      "--- Bienvenue au jeu de roche-papier-ciseau ---\n\x00"
msgTour:         .ASCII      "Combien de manches voulez-vous jouer?\n\x00"
msgReste:        .ASCII      "Il reste \x00"
msgTours:        .ASCII      " manche(s) a jouer.\n\x00"
msgJ1:           .ASCII      "JOUEUR 1\x00"
msgJ2:           .ASCII      "JOUEUR 2\x00"
msgChoix:        .ASCII      ", quel est votre choix? [r/p/c]\n\x00"
msgWin:          .ASCII      " a gagne cette manche! Score: \x00"
msgWin2:         .ASCII     "-\x00"
msgNulle:        .ASCII      "Manche nulle...\n\x00"
msgCongr:        .ASCII      " A GAGNE LE MATCH! FELICITATIONS!\n\x00"
msgScore:        .ASCII      "SCORE FINAL: \x00"
msgError:        .ASCII      "Erreur d'entree! Programme termine.\n\x00"
msgLine:         .ASCII      "\n\x00"
msgLines:        .ASCII      "\n\n\x00"
;                 
                 .END
