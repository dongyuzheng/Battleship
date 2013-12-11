%Programmer:   Gary Zheng
%Date:         June 2013
%Course:       ICS3CU1
%Teacher:      M. Ianni
%Program Name: BattleShip
%Description:  starts actual game; procedures to run: StartGame
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

proc GetSmartAIHit (previousColumn, previousRow : int, var GuessDir, HitDir, Column, Row : int)
    var RandDir : int := Rand.Int (1, 4)     %gets a random direction for the ai to hit
    GuessDir := RandDir %temporary direction = direction
    if HitDir not= 0 then %if directional hitting if off then...
	RandDir := HitDir
    end if
    if RandDir = 1 then
	Row := previousRow + 1
	Column := previousColumn
    elsif RandDir = 2 then
	Row := previousRow - 1
	Column := previousColumn
    elsif RandDir = 3 then
	Row := previousRow
	Column := previousColumn + 1
    elsif RandDir = 4 then
	Row := previousRow
	Column := previousColumn - 1
    end if

    if Row = 11 then     %so the ai doesn't go off the grid
	Row -= 2
    elsif Row = 0 then
	Row += 2
    end if

    if Column = 11 then     %so the ai doesn't go off the grid
	Column -= 2
    elsif Column = 0 then
	Column += 2
    end if
end GetSmartAIHit

proc WriteQuit
    var FONT : int := Font.New ("comicsans:28")
    Draw.FillBox (645, 23, 745, 63, yellow)
    Font.Draw ("QUIT", 650, 30, FONT, blue)
end WriteQuit

proc AIsTurn (SmartAI : int, var previousHit, ppH : boolean, var ppTries, ppC, ppR, previousColumn, previousRow,
	PlayerShipPartsLeft, EnemyHits, EnemyMisses, GuessDir, HitDir : int, var P1Board : array 1 .. 10, 1 .. 10 of string)
    delay (2000)
    var Column : int := Rand.Int (1, 10)
    var Row : int := Rand.Int (1, 10)
    if SmartAI = 0 then %smart AI off
	loop
	    if length (P1Board (Row, Column)) >= 2 then %already hit
		Column := Rand.Int (1, 10)
		Row := Rand.Int (1, 10)
	    elsif P1Board (Row, Column) = "X" then %miss
		EnemyMisses += 1
		fork Splash
		Player1Board -> setImage ("Images/InGame/18MISS.bmp") %sets the miss image
		Player1Board -> setDrawCR (Column, Row) %set where to place the image
		Player1Board -> DrawCell %draw the image
		P1Board (Row, Column) += "X" %mark that this spot is miss shot on the array
		exit
	    else %hit
		EnemyHits += 1
		fork Hit
		if P1Board (Row, Column) = "A" then %sets the correct hit image
		    Player1Board -> setImage ("Images/InGame/18A_HIT.bmp")
		elsif P1Board (Row, Column) = "B" then
		    Player1Board -> setImage ("Images/InGame/18B_HIT.bmp")
		elsif P1Board (Row, Column) = "S" then
		    Player1Board -> setImage ("Images/InGame/18S_HIT.bmp")
		elsif P1Board (Row, Column) = "D" then
		    Player1Board -> setImage ("Images/InGame/18D_HIT.bmp")
		elsif P1Board (Row, Column) = "P" then
		    Player1Board -> setImage ("Images/InGame/18P_HIT.bmp")
		end if
		Player1Board -> setDrawCR (Column, Row)
		Player1Board -> DrawCell
		P1Board (Row, Column) += "X" %sets the ship part as dead, the value will look like "AX"
		PlayerShipPartsLeft -= 1
		exit
	    end if
	end loop
    elsif SmartAI = 1 then %smart AI on
	var AllTried : int := 4

	if previousHit = true then
	    GetSmartAIHit (previousColumn, previousRow, GuessDir, HitDir, Column, Row) %get where to hit
	end if

	loop
	    if length (P1Board (Row, Column)) >= 2 then %already hit
		Column := Rand.Int (1, 10)
		Row := Rand.Int (1, 10)
		if previousHit = true and AllTried >= 0 then %prevents loop with no exit
		    GetSmartAIHit (previousColumn, previousRow, GuessDir, HitDir, Column, Row)
		    AllTried -= 1
		end if
	    elsif P1Board (Row, Column) = "X" then %miss
		EnemyMisses += 1
		if ppH then %if the previous missed, go back to the previous previous location
		    previousColumn := ppC
		    previousRow := ppR
		    ppTries -= 1
		end if
		if ppTries <= 0 or HitDir not= 0 then %if previous previous location is tested 4 times or misses during directional attack, stop trying
		    ppH := false
		    ppTries := 4
		    HitDir := 0
		end if

		fork Splash
		Player1Board -> setImage ("Images/InGame/18MISS.bmp")
		Player1Board -> setDrawCR (Column, Row)
		Player1Board -> DrawCell
		P1Board (Row, Column) += "X"
		exit
	    else     %hit
		HitDir := GuessDir
		EnemyHits += 1
		fork Hit
		if P1Board (Row, Column) = "A" then
		    Player1Board -> setImage ("Images/InGame/18A_HIT.bmp")
		elsif P1Board (Row, Column) = "B" then
		    Player1Board -> setImage ("Images/InGame/18B_HIT.bmp")
		elsif P1Board (Row, Column) = "S" then
		    Player1Board -> setImage ("Images/InGame/18S_HIT.bmp")
		elsif P1Board (Row, Column) = "D" then
		    Player1Board -> setImage ("Images/InGame/18D_HIT.bmp")
		elsif P1Board (Row, Column) = "P" then
		    Player1Board -> setImage ("Images/InGame/18P_HIT.bmp")
		end if
		Player1Board -> setDrawCR (Column, Row)
		Player1Board -> DrawCell
		P1Board (Row, Column) += "X"
		PlayerShipPartsLeft -= 1
		previousHit := true %the previous hit is confirmed
		previousColumn := Column
		previousRow := Row
		ppC := Column
		ppR := Row
		ppH := true %the previous prevous cell is confirmed
		exit
	    end if
	end loop

    end if
    delay (500)
end AIsTurn

proc Layout
    var DrawThis : int := Pic.FileNew ("Images/InGame/InGameLayout.bmp")
    Pic.Draw (DrawThis, 0, 0, 0)
    Pic.Free (DrawThis)
end Layout

proc RestoreP1Grid (P1Board : array 1 .. 10, 1 .. 10 of string)
    for x : 1 .. 10
	for y : 1 .. 10
	    if P1Board (y, x) not= "X" then %if the cell is not blank then...
		if P1Board (y, x) = "A" then
		    Player1Board -> setImage ("Images/InGame/18A.bmp")
		elsif P1Board (y, x) = "B" then
		    Player1Board -> setImage ("Images/InGame/18B.bmp")
		elsif P1Board (y, x) = "S" then
		    Player1Board -> setImage ("Images/InGame/18S.bmp")
		elsif P1Board (y, x) = "D" then
		    Player1Board -> setImage ("Images/InGame/18D.bmp")
		elsif P1Board (y, x) = "P" then
		    Player1Board -> setImage ("Images/InGame/18P.bmp")
		end if
		Player1Board -> setDrawCR (x, y)
		Player1Board -> DrawCell
	    end if
	end for
    end for
end RestoreP1Grid

proc DisplayStats (Username : string, SmartAI, YourHits, YourMisses,
	EnemyHits, EnemyMisses, EnemyShipPartsLeft, PlayerShipPartsLeft : int)
    var AIname : string
    if SmartAI = 0 then
	AIname := "Dumb AI"
    elsif SmartAI = 1 then
	AIname := "Smart AI"
    end if
    Text.ColourBack (black)
    Text.Colour (white)
    locate (19, 65)
    put Username, "'s Stats"
    locate (20, 60)
    put "Your Hits: ", YourHits
    locate (21, 60)
    put "Your Misses: ", YourMisses
    locate (23, 65)
    put AIname, "'s Stats"
    locate (24, 60)
    put "Enemy Hits: ", EnemyHits
    locate (25, 60)
    put "Enemy Misses: ", EnemyMisses
    locate (27, 65)
    put "Ship Parts Left"
    locate (28, 60)
    put Username, ": ", PlayerShipPartsLeft
    locate (29, 60)
    put "AI: ", EnemyShipPartsLeft
end DisplayStats

proc WhosTurn (Username : string, PlayersTurn : boolean)
    if PlayersTurn then
	locate (31, 60)
	put Username, "'s Turn"
    else
	locate (31, 60)
	put "AI's Turn"
    end if
end WhosTurn

proc StartGame (Username : string, SmartAI : int,
	var YourHits, YourMisses, EnemyHits, EnemyMisses, EnemyShipPartsLeft, PlayerShipPartsLeft : int, %statistics
	var P1Board, P2Board : array 1 .. 10, 1 .. 10 of string)
    var MouseX, MouseY, Column, Row, previousColumn, previousRow, ppC, ppR : int
    var GuessDir, HitDir : int := 0 %for directional hitting
    var ppTries : int := 4 %4 adjacent cells to check
    var previousHit, ppH : boolean := false
    Layout
    WriteQuit
    Player1Board -> setBL (560, 350) %sets bottom left corner of grid
    Player1Board -> setCellLW (20) %sets cell length and width
    Player1Board -> DrawBoard %draws player's board to top right of screen
    Player2Board -> DrawBoard %draws AI's board to center of screen

    RestoreP1Grid (P1Board)

    loop
	DisplayStats (Username, SmartAI, YourHits, YourMisses, EnemyHits, %writes the stats to the screen
	    EnemyMisses, EnemyShipPartsLeft, PlayerShipPartsLeft)
	if EnemyShipPartsLeft = 0 or PlayerShipPartsLeft = 0 then %check is all ships of one side is dead
	    delay (3000)
	    exit
	end if
	delay (200)
	WhosTurn (Username, true) %write who's turn it is
	GetMouse (MouseX, MouseY)
	Player2Board -> setWantXY (MouseX, MouseY)
	Column := Player2Board -> GetColumn
	Row := Player2Board -> GetRow

	if MouseX >= 645 and MouseX <= 745 and MouseY >= 23 and MouseY <= 63 then %quit button
	    fork ClickSound
	    delay (1500)
	    exit
	end if

	if Column > 0 and Row > 0 then %if click is on grid
	    if length (P2Board (Row, Column)) >= 2 then %already hit
		fork ErrorSound
	    elsif P2Board (Row, Column) = "X" then %player miss
		YourMisses += 1
		fork Splash
		Player2Board -> setImage ("Images/InGame/38MISS.bmp")
		Player2Board -> setDrawCR (Column, Row)
		Player2Board -> DrawCell %draws miss image
		P2Board (Row, Column) += "X"
		DisplayStats (Username, SmartAI, YourHits, YourMisses, EnemyHits,
		    EnemyMisses, EnemyShipPartsLeft, PlayerShipPartsLeft)
		if EnemyShipPartsLeft = 0 or PlayerShipPartsLeft = 0 then             %check is all ships of one side is dead
		    delay (3000)
		    exit
		end if
		WhosTurn (Username, false)
		AIsTurn (SmartAI, previousHit, ppH, ppTries, ppC, ppR, previousColumn, previousRow,   %AI runs
		    PlayerShipPartsLeft, EnemyHits, EnemyMisses, GuessDir, HitDir, P1Board)
	    else %player hits enemy
		YourHits += 1
		fork Hit
		if P2Board (Row, Column) = "A" then %draws the right hit image
		    Player2Board -> setImage ("Images/InGame/38A_HIT.bmp")
		elsif P2Board (Row, Column) = "B" then
		    Player2Board -> setImage ("Images/InGame/38B_HIT.bmp")
		elsif P2Board (Row, Column) = "S" then
		    Player2Board -> setImage ("Images/InGame/38S_HIT.bmp")
		elsif P2Board (Row, Column) = "D" then
		    Player2Board -> setImage ("Images/InGame/38D_HIT.bmp")
		elsif P2Board (Row, Column) = "P" then
		    Player2Board -> setImage ("Images/InGame/38P_HIT.bmp")
		end if
		Player2Board -> setDrawCR (Column, Row)
		Player2Board -> DrawCell
		P2Board (Row, Column) += "X"
		EnemyShipPartsLeft -= 1
		DisplayStats (Username, SmartAI, YourHits, YourMisses,
		    EnemyHits, EnemyMisses, EnemyShipPartsLeft, PlayerShipPartsLeft)
		if EnemyShipPartsLeft = 0 or PlayerShipPartsLeft = 0 then         %check is all ships of one side is dead
		    delay (3000)
		    exit
		end if
		WhosTurn (Username, false)
		AIsTurn (SmartAI, previousHit, ppH, ppTries, ppC, ppR, previousColumn, previousRow,
		    PlayerShipPartsLeft, EnemyHits, EnemyMisses, GuessDir, HitDir, P1Board)
	    end if
	end if
    end loop
end StartGame

