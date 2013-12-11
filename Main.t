%Programmer:   Gary Zheng
%Date:         June 2013
%Course:       ICS3CU1
%Teacher:      M. Ianni
%Program Name: BattleShip
%Descriptions: the main game launcher
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
include "files/code/includes.t"

var GameWindow : int := Window.Open ("graphics:800;600,title:Battleship") %opens the game window so it can be closed later
setInitialGameValues


%%%%%%%%%%%%%%%%%%%%%%%%GAME INTRO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PlayIntro %Play the intro

%%%%%%%%%%%%%%%%%%%%%%%%THE GAME%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

loop
    delay (200) %prevents misclick
    MenuChoice := MenuSelect %Show the main menu, menu choice can be picked by the mouse
    case (MenuChoice) of
	label 1 : %Play
	    PlayerPlaceShips (P1Board) %Ask player to place their ships on the grid, allowing rotation, but not diagonal and overlapping placement
	    GenerateAI (P2Board) %Generates the AI's ship placements randomly
	    StartGame (Username, SmartAI, YourHits, YourMisses, EnemyHits, %start the actual game, player 1 always goes first, updates statistics after every turn
		EnemyMisses, EnemyShipPartsLeft, PlayerShipPartsLeft, P1Board, P2Board)
	    GameOver (Username, SmartAI, YourHits, YourMisses, EnemyHits, %Display game over screen, display statistics
		EnemyMisses, EnemyShipPartsLeft, PlayerShipPartsLeft)
	    Window.Close (GameWindow) %close the game
	    exit
	label 2 : %Instructions
	    DisplayInstructions %Displays the instructions read from a text file
	label 3 : %Options
	    SetOptions (Username, SmartAI) %View, set, save, reset the game options, this will affect Play
	label 4 : %Quit
	    Window.Close (GameWindow) %close the game
	    exit
    end case
end loop


