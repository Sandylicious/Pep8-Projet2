/**
 * Cette classe represente un programme avec lequel deux joueurs humains peuvent jouer au jeu de roche-papier-ciseau entre eux.
 * Regle du jeu: Chaque joueur choisit un des trois objets et on determine qui gagne la manche en comparant leur choix (roche gagne contre ciseaux, ciseaux
 * gagne contre papier et papier gagne contre roche).
 *
 * @author SCA
 * @author XRF
 *
 * @version 2021-02-09
 */
public class main {

    // Constantes
    public static final String MSG_BIENVENUE = "--- Bienvenue au jeu de roche-papier-ciseau ---\n";
    public static final String MSG_TIRETS =  "-----------------------------------------------\n";
    public static final String MSG_MANCHES_A_JOUER = "Combien de manches voulez-vous jouer?\n";
    public static final String MSG_RESTE = "Il reste ";
    public static final String MSG_MANCHES = " manche(s) a jouer.\n";
    public static final String MSG_JOUEUR1 = "JOUEUR 1";
    public static final String MSG_JOUEUR2 = "JOUEUR 2";
    public static final String MSG_CHOIX = ", quel est votre choix? [r/p/c]\n";
    public static final String MSG_MANCHE_VICTOIRE = " a gagne cette manche! Score: ";
    public static final String MSG_NULLE = "Manche nulle...\n";
    public static final String MSG_MATCH_VICTOIRE = " A GAGNE LE MATCH! FELICITATIONS!\n";
    public static final String MSG_SCORE_FINAL = "SCORE FINAL: ";
    public static final String MSG_ERREUR = "Erreur d'entree! Programme termine.\n";


    public static void main(String[] args) {

        // Variables

        // Variables pour stocker les caracteres en entree
        char choixJoueur1;
        char choixJoueur2;
        char entree;

        // Score des joueurs 1 et 2, score pour atteindre la victoire
        int score1 = 0;
        int score2 = 0;
        int scoreDeVictoire = 1;

        // Nombres de manches maximal a jouer, parite, nombre restant a jouer
        int manchesAJouer;
        boolean estPair = true;
        int manchesRestantes;

        // Debut du programme
        Pep8.stro(MSG_TIRETS);
        Pep8.stro(MSG_BIENVENUE);
        Pep8.stro(MSG_TIRETS);
        Pep8.stro("\n");
        Pep8.stro(MSG_MANCHES_A_JOUER);

        // Entrer le nombre de manches a jouer
        manchesAJouer = Pep8.deci();
        Pep8.chari();
        Pep8.stro("\n\n");

        // Verifier que le nombre de manches a jouer est positif
        if (manchesAJouer < 0) {
            Pep8.stro(MSG_ERREUR);
            Pep8.stop();
        }

        // Verifier si c'est un nombre pair ou impair
        for (int i = 1; i <= manchesAJouer; i++)
            estPair = !estPair;

        // Si c'est pair ou 0, incrementer le nombre de manches de 1.
        if (estPair)
            manchesAJouer++;

        manchesRestantes = manchesAJouer;

        // Determiner score de victoire
        for (int k = 1; k + k < manchesAJouer; k++)
                scoreDeVictoire = k + 1;

        // Jouer jusqu'a ce qu'un joueur atteigne le score de victoire
        while (score1 != scoreDeVictoire && score2 != scoreDeVictoire) {

            // Afficher les nombre de manches restantes a jouer et demander au
            // joueur 1 de faire son choix
            Pep8.stro(MSG_RESTE);
            Pep8.deco(manchesAJouer);
            Pep8.stro(MSG_MANCHES);

            Pep8.stro(MSG_JOUEUR1);
            Pep8.stro(MSG_CHOIX);

            // Valider le choix du joueur 1 (arreter le programme si invalide)
            choixJoueur1 = Pep8.chari();
            if (choixJoueur1 != 'r' && choixJoueur1 != 'p'
                    && choixJoueur1 != 'c') {
                Pep8.stro(MSG_ERREUR);
                Pep8.stop();
            }

            // S'assurer que le joueur 2 touche <Entree> apres son choix
            entree = Pep8.chari();
            if (entree != '\n') {
                Pep8.stro(MSG_ERREUR);
                Pep8.stop();
            }

            // Demander et valider le choix du joueur 2
            // Arreter le programme si invalide
            Pep8.stro(MSG_JOUEUR2);
            Pep8.stro(MSG_CHOIX);
            choixJoueur2 = Pep8.chari();
            if (choixJoueur2 != 'r' && choixJoueur2 != 'p'
                    && choixJoueur2 != 'c') {
                Pep8.stro(MSG_ERREUR);
                Pep8.stop();
            }

            // S'assurer que le joueur 2 touche <Entree> apres son choix
            entree = Pep8.chari();
            if (entree != '\n') {
                Pep8.stro(MSG_ERREUR);
                Pep8.stop();
            }

            // Comparer le choix des joueurs, annoncer le gagnant de la manche
            // ou si c'est une manche nulle
            if (choixJoueur1 == 'r' && choixJoueur2 == 'c'
                    || choixJoueur1 == 'c' && choixJoueur2 == 'p'
                    || choixJoueur1 == 'p' && choixJoueur2 == 'r') {
                score1++;
                manchesAJouer--;

                Pep8.stro(MSG_JOUEUR1);
                Pep8.stro(MSG_MANCHE_VICTOIRE);
                Pep8.deco(score1);
                Pep8.charo('-');
                Pep8.deco(score2);
                Pep8.charo('\n');

            } else if (choixJoueur2 == 'r' && choixJoueur1 == 'c'
                    || choixJoueur2 == 'c' && choixJoueur1 == 'p'
                    || choixJoueur2 == 'p' && choixJoueur1 == 'r') {
                score2++;
                manchesAJouer--;
                Pep8.stro(MSG_JOUEUR2);
                Pep8.stro(MSG_MANCHE_VICTOIRE);
                Pep8.deco(score1);
                Pep8.charo('-');
                Pep8.deco(score2);
                Pep8.charo('\n');
            } else
                Pep8.stro(MSG_NULLE);
            Pep8.charo('\n');
        }

        // Afficher le gagnant du match et le score final
        if (score1 == scoreDeVictoire) {
            Pep8.stro(MSG_JOUEUR1);
            Pep8.stro(MSG_MATCH_VICTOIRE);
        }
        if (score2 == scoreDeVictoire) {
            Pep8.stro(MSG_JOUEUR2);
            Pep8.stro(MSG_MATCH_VICTOIRE);
        }

        Pep8.stro(MSG_SCORE_FINAL);
        Pep8.deco(score1);
        Pep8.charo('-');
        Pep8.deco(score2);
        Pep8.charo('\n');

        // Terminer le programme
        Pep8.stop();
    }
}
