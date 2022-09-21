#!/bin/bash
#Le morpion est un jeu de réflexion se pratiquant à deux joueurs
#au tour par tour et dont le but est de créer le premier un alignement sur une grille
#Le premier joueur est appelé X le deuxième est appelé O 
function afficher_banner(){
BANNER="
 ___ ___   ___   ____   ____  ____  ___   ____        ____   ____  ___ ___    ___
|   T   T /   \ |    \ |    \l    j/   \ |    \      /    T /    T|   T   T  /  _]
| _   _ |Y     Y|  D  )|  o  )|  TY     Y|  _  Y    Y   __jY  o  || _   _ | /  [_ 
|  \_/  ||  O  ||    / |   _/ |  ||  O  ||  |  |    |  T  ||     ||  \_/  |Y    _]
|   |   ||     ||    \ |  |   |  ||     ||  |  |    |  l_ ||  _  ||   |   ||   [_ 
|   |   |l     !|  .  Y|  |   j  ll     !|  |  |    |     ||  |  ||   |   ||     T
l___j___j \___/ l__j\_jl__j  |____j\___/ l__j__j    l___,_jl__j__jl___j___jl_____j
                                                                                  "
echo "$BANNER"

}
#Initilaiser la grille avec des vides ( videz les 9 cases)
#en les remplaçant par un espace pour éviter une déformation
function initialiser_la_grille()
{
A1=' ' && A2=' ' && A3=' '
B1=' ' && B2=' ' && B3=' '
C1=' ' && C2=' ' && C3=' '
}
#Afficher la grille (le tableau est dessiné )

function Afficher_grille()
{
afficher_banner
#banner Morpion Game

GRID="
    A   B   C
  +---+---+---+
1 | $A1 | $B1 | $C1 |
  +---+---+---+
2 | $A2 | $B2 | $C2 |
  +---+---+---+
3 | $A3 | $B3 | $C3 |
  +---+---+---+
"
echo "$GRID"
}
#Variables Globales afin de catch le erreurs

ALREADY="La position est déja prise ,choisissez une autre valide et cliquez sur entrer "
OUTSIDE="La position n'existe pas ,choisissez une autre valide et cliquez sur entrer "
INVALID="Une option invalide , taper oui ou non et cliquez sur entrer "

# rediriger la grille vers fichier téléchargable  
touch game_results.txt
#Vérifier la disponiblité de la case
#On check si la position est déjà prise on regarde si elle contient un O ou un X sinon

function test_pos()
{
XO="$1"
if [[ "$XO" = 'X' ]] || [[ "$XO" = 'O' ]]
then
clear && echo "$ALREADY" && turn
else
true
fi
}
#
function take_pos()
{

case "$PLAY" in

A1|a1) test_pos "$A1" ;;
A2|a2) test_pos "$A2" ;;
A3|a3) test_pos "$A3" ;;
B1|b1) test_pos "$B1" ;;
B2|b2) test_pos "$B2" ;;
B3|b3) test_pos "$B3" ;;
C1|c1) test_pos "$C1" ;;
C2|c2) test_pos "$C2" ;;
C3|c3) test_pos "$C3" ;;
esac
}
#on lit la position choisie PLAY  par le joueur Player
function turn()
{
Afficher_grille

echo '-------------------------------'
echo "Turn: $TURN - Player: $PLAYER"
echo '-------------------------------'

read PLAY
take_pos

case "$PLAY" in

A1|a1) A1="$PLAYER" ;;
A2|a2) A2="$PLAYER" ;;
A3|a3) A3="$PLAYER" ;;
B1|b1) B1="$PLAYER" ;;
B2|b2) B2="$PLAYER" ;;
B3|b3) B3="$PLAYER" ;;
C1|c1) C1="$PLAYER" ;;
C2|c2) C2="$PLAYER" ;;
C3|c3) C3="$PLAYER" ;;
exit) clear && exit_game ;;
*) clear && echo "$OUTSIDE" && turn

esac

}

function check_line()
{
CHECK1="$1"
CHECK2="$2"
CHECK3="$3"

if [[ "$CHECK1" = "$PLAYER" ]] && [[ "$CHECK2" = "$PLAYER" ]] && [[ "$CHECK3" = "$PLAYER" ]]
then
clear && echo "$PLAYER wins!" && Afficher_grille  && Afficher_grille >> game_results.txt && play_again
else
true
fi  
}

#On
function check_victory()
{

check_line $A1 $A2 $A3
check_line $B1 $B2 $B3
check_line $C1 $C2 $C3
check_line $A1 $B1 $C1
check_line $A2 $B2 $C2
check_line $A3 $B3 $C3
check_line $A1 $B2 $C3
check_line $A3 $B2 $C1
}

function exit_game()
{
echo "Voulez vous quitter? (oui/non)"
read EXITINPUT

if [[ "$EXITINPUT" = 'oui' ]] || [[ "$EXITINPUT" = 'o' ]]
then clear && exit
elif [[ "$EXITINPUT" = 'non' ]] || [[ "$EXITINPUT" = 'n' ]]
then clear && turn
else
clear && echo "$INVALID" && turn && exit_game
fi
}

function play_again()
{
echo "Encore un tour ? (oui/non)"
read PLAYAGAININPUT

if [["PLAYAGAININPUT" = 'oui' ]] || [[ "$PLAYAGAININPUT" = 'o' ]]
then game_start
elif [[ "$PLAYAGAININPUT" = 'non' ]] || [[ "$PLAYAGAININPUT" = 'n' ]]
then clear && exit
else
clear && echo "$INVALID" && turn
play_again
fi
}

function game_over() {
 clear && echo "Game Over" && Afficher_grille && play_again; }

#démarrer le jeu
function game_start()
{
echo 

"  ███▄ ▄███▓ ▒█████   ██▀███   ██▓███   ██▓ ▒█████   ███▄    █      ▄████  ▄▄▄       ███▄ ▄███▓▓█████ 
▓██▒▀█▀ ██▒▒██▒  ██▒▓██ ▒ ██▒▓██░  ██▒▓██▒▒██▒  ██▒ ██ ▀█   █     ██▒ ▀█▒▒████▄    ▓██▒▀█▀ ██▒▓█   ▀ 
▓██    ▓██░▒██░  ██▒▓██ ░▄█ ▒▓██░ ██▓▒▒██▒▒██░  ██▒▓██  ▀█ ██▒   ▒██░▄▄▄░▒██  ▀█▄  ▓██    ▓██░▒███   
▒██    ▒██ ▒██   ██░▒██▀▀█▄  ▒██▄█▓▒ ▒░██░▒██   ██░▓██▒  ▐▌██▒   ░▓█  ██▓░██▄▄▄▄██ ▒██    ▒██ ▒▓█  ▄ 
▒██▒   ░██▒░ ████▓▒░░██▓ ▒██▒▒██▒ ░  ░░██░░ ████▓▒░▒██░   ▓██░   ░▒▓███▀▒ ▓█   ▓██▒▒██▒   ░██▒░▒████▒
░ ▒░   ░  ░░ ▒░▒░▒░ ░ ▒▓ ░▒▓░▒▓▒░ ░  ░░▓  ░ ▒░▒░▒░ ░ ▒░   ▒ ▒     ░▒   ▒  ▒▒   ▓▒█░░ ▒░   ░  ░░░ ▒░ ░
░  ░      ░  ░ ▒ ▒░   ░▒ ░ ▒░░▒ ░      ▒ ░  ░ ▒ ▒░ ░ ░░   ░ ▒░     ░   ░   ▒   ▒▒ ░░  ░      ░ ░ ░  ░
░      ░   ░ ░ ░ ▒    ░░   ░ ░░        ▒ ░░ ░ ░ ▒     ░   ░ ░    ░ ░   ░   ░   ▒   ░      ░      ░   
       ░       ░ ░     ░               ░      ░ ░           ░          ░       ░  ░       ░      ░  ░ 
"
afficher_banner
initialiser_la_grille
#le joueur X commence ensuite le O
#tant que les cases ne sont pas toutes remplies et que y'a pas eu une victoire on continue  
#on augment le chiffre du tour
TURN='1'
PLAYER=X && clear && turn && ((TURN++)) # TURN +1
until [[ $A1 != ' ' ]] && [[ $A2 != ' ' ]] && [[ $A3 != ' ' ]] \
&& [[ $B1 != ' ' ]] && [[ $B2 != ' ' ]] && [[ $B3 != ' ' ]] \
&& [[ $C1 != ' ' ]] && [[ $C2 != ' ' ]] && [[ $C3 != ' ' ]]

do  
PLAYER=O && clear && turn && check_victory && ((TURN++))
PLAYER=X && clear && turn && check_victory && ((TURN++))
done
#Afficher_grille >> game_results.txt 

game_over
}
game_start
 
