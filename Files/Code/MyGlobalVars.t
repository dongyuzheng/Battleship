%Programmer:   Gary Zheng
%Date:         June 2013
%Course:       ICS3CU1
%Teacher:      M. Ianni
%Program Name: BattleShip
%Description:  global vars; procedures to run: setInitialGameValues
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

var MenuChoice, SmartAI, YourHits, YourMisses, EnemyHits, EnemyMisses, EnemyShipPartsLeft, PlayerShipPartsLeft : int
var Username : string
var P1Board, P2Board : array 1 .. 10, 1 .. 10 of string %the boards are string 2D arrays because it is easier to work with in the beginning
%another option is with int arrays, but is doesn't really matter
var Player1Board, Player2Board : pointer to Board

fcn GetUserName2 : string
    var word : string
    var stream : int
    open : stream, "Files/Text/Options.txt", get
    for i : 1 .. 2
	get : stream, skip
	exit when eof (stream)
	get : stream, word
    end for
    close : stream
    result word
end GetUserName2

fcn GetAI2 : int
    var word : string
    var stream : int
    open : stream, "Files/Text/Options.txt", get
    for i : 1 .. 4
	get : stream, skip
	exit when eof (stream)
	get : stream, word
    end for
    close : stream
    result strint (word)
end GetAI2

proc setInitialGameValues
    cls
    MenuChoice := 0
    YourHits := 0
    YourMisses := 0
    EnemyHits := 0
    EnemyMisses := 0
    EnemyShipPartsLeft := 17
    PlayerShipPartsLeft := 17
    SmartAI := GetAI2
    Username := GetUserName2
    for x : 1 .. 10 %sets all spots on grids as blank ("X")
	for y : 1 .. 10
	    P1Board (y, x) := "X"
	    P2Board (y, x) := "X"
	end for
    end for

    new Player1Board
    Player1Board -> setBL (-30, -30) %set bottom left corner of grid
    Player1Board -> setCellLW (40) %set cell's length and width as 40 pixels
    new Player2Board
    Player2Board -> setBL (-30, -30)
    Player2Board -> setCellLW (40)

end setInitialGameValues
