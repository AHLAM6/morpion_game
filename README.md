# morpion_game
jeu de morpion en bash




Dans votre teminal de la machine linux  executer le fichier morpion.sh 
N'oubliez pas de modifier les droits 
Un fichier game_results.txt contenant les grilles des diffrents tours du jeu sera générer dans le répoirtoir courant( vous pouvez le changer dans le code )
La fonction principale est game start()
   1- On affiche le banner.
   2- Initiliser la grille avant de l'afficher 
  Le jeu commence : 
  turn =1       Player = X ou Player = O
   3- On appelle la fonctoin turn()
        1- afficher la grille()
        2- On lit Play du terminal ( Playe étanat la position à jouer )
     Tant que toutes les cases sont pas toutes remplies . 
     X a commencé le tour est à O et on check-Victory ( 8 conditions = 8 check-line)
     on mets le résultat  dans un fichier dans le répertoire courant 
     
  
