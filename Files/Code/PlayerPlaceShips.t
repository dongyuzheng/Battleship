%Programmer:   Gary Zheng
%Date:         June 2013
%Course:       ICS3CU1
%Teacher:      M. Ianni
%Program Name: BattleShip
%Descriptions: lets the player place down ships; procs to run: PlayerPlaceShips
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

proc WriteShipNames
    var FONT : int := Font.New ("comicsans:28")
    Font.Draw ("Click to Select Place!", 200, 525, FONT, white)
    Font.Draw ("Vertical   Horizontal", 450, 400, FONT, white)
    Font.Draw ("(A) Aircraft Carrier ", 450, 350, FONT, white)
    Font.Draw ("(B) Battleship", 450, 300, FONT, white)
    Font.Draw ("(S) Submarine", 450, 250, FONT, white)
    Font.Draw ("(D) Destroyer", 450, 200, FONT, white)
    Font.Draw ("(P) Patrol Boat", 450, 150, FONT, white)
    Font.Draw ("(X) Reset Grid", 450, 100, FONT, white)
    Font.Draw ("FINISH", 650, 30, FONT, white)
end WriteShipNames

proc PlayerPlaceShips (var P1Board : array 1 .. 10, 1 .. 10 of string)
    Draw.FillBox (0, 0, maxx, maxy, black)
    Draw.FillBox (450, 340, 750, 380, gray)
    Draw.FillBox (445, 430, 575, 397, gray)
    WriteShipNames %displays text to screen

    var APlaced, BPlaced, SPlaced, DPlaced, PPlaced : boolean := false %check if the ship is placed
    var VerticalPlacement, AllowPlace : boolean := true
    var MouseX, MouseY, Column, Row, ShipLength : int := 5
    var ShipToPlace : string := "A" %default is A to prevent crash

    Player1Board -> DrawBoard %draws the grid
    Player1Board -> setImage ("Images/InGame/38A.bmp") %prevent crash

    loop
	delay (200) %prevents double click
	GetMouse (MouseX, MouseY)
	Player1Board -> setWantXY (MouseX, MouseY) %sets x value for GetColumn and y value to GetRow
	Column := Player1Board -> GetColumn
	Row := Player1Board -> GetRow

	% locate (1, 1)
	% Text.ColourBack (black)
	% Text.Colour (white)
	% put Column, ", ", Row, ", ", ShipToPlace, ShipLength

	if MouseX >= 450 and MouseX <= 750 and MouseY >= 350 and MouseY <= 380 then %mouse click Aircraft Carrier
	    fork ClickSound
	    ShipToPlace := "A"
	    ShipLength := 5
	    Player1Board -> setImage ("Images/InGame/38A.bmp") %sets the image to draw into cells
	    Draw.FillBox (450, 340, 750, 380, gray)
	    Draw.FillBox (450, 290, 670, 330, black)
	    Draw.FillBox (450, 240, 690, 280, black)
	    Draw.FillBox (450, 185, 670, 230, black)
	    Draw.FillBox (450, 140, 700, 180, black)
	    Draw.FillBox (450, 90, 680, 130, black)
	    WriteShipNames
	elsif MouseX >= 450 and MouseX <= 670 and MouseY >= 300 and MouseY <= 330 then %mouse click Battleship
	    fork ClickSound
	    ShipToPlace := "B"
	    ShipLength := 4
	    Player1Board -> setImage ("Images/InGame/38B.bmp")
	    Draw.FillBox (450, 340, 750, 380, black)
	    Draw.FillBox (450, 290, 670, 330, gray)
	    Draw.FillBox (450, 240, 690, 280, black)
	    Draw.FillBox (450, 185, 670, 230, black)
	    Draw.FillBox (450, 140, 700, 180, black)
	    Draw.FillBox (450, 90, 680, 130, black)
	    WriteShipNames
	elsif MouseX >= 450 and MouseX <= 690 and MouseY >= 250 and MouseY <= 280 then %mouse click Submarine
	    fork ClickSound
	    ShipToPlace := "S"
	    ShipLength := 3
	    Player1Board -> setImage ("Images/InGame/38S.bmp")
	    Draw.FillBox (450, 340, 750, 380, black)
	    Draw.FillBox (450, 290, 670, 330, black)
	    Draw.FillBox (450, 240, 690, 280, gray)
	    Draw.FillBox (450, 185, 670, 230, black)
	    Draw.FillBox (450, 140, 700, 180, black)
	    Draw.FillBox (450, 90, 680, 130, black)
	    WriteShipNames
	elsif MouseX >= 450 and MouseX <= 670 and MouseY >= 195 and MouseY <= 230 then %mouse click Destroyer
	    fork ClickSound
	    ShipToPlace := "D"
	    ShipLength := 3
	    Player1Board -> setImage ("Images/InGame/38D.bmp")
	    Draw.FillBox (450, 340, 750, 380, black)
	    Draw.FillBox (450, 290, 670, 330, black)
	    Draw.FillBox (450, 240, 690, 280, black)
	    Draw.FillBox (450, 185, 670, 230, gray)
	    Draw.FillBox (450, 140, 700, 180, black)
	    Draw.FillBox (450, 90, 680, 130, black)
	    WriteShipNames
	elsif MouseX >= 450 and MouseX <= 700 and MouseY >= 150 and MouseY <= 180 then %mouse click Patrol Boat
	    fork ClickSound
	    ShipToPlace := "P"
	    ShipLength := 2
	    Player1Board -> setImage ("Images/InGame/38P.bmp")
	    Draw.FillBox (450, 340, 750, 380, black)
	    Draw.FillBox (450, 290, 670, 330, black)
	    Draw.FillBox (450, 240, 690, 280, black)
	    Draw.FillBox (450, 185, 670, 230, black)
	    Draw.FillBox (450, 140, 700, 180, gray)
	    Draw.FillBox (450, 90, 680, 130, black)
	    WriteShipNames
	elsif MouseX >= 450 and MouseX <= 680 and MouseY >= 100 and MouseY <= 130 then %mouse click Reset Grid
	    fork ClickSound
	    for x : 1 .. 10 %clears player's array
		for y : 1 .. 10
		    P1Board (y, x) := "X"
		end for
	    end for
	    cls
	    PlayerPlaceShips (P1Board) %restart the placing
	    exit
	elsif MouseX >= 446 and MouseX <= 573 and MouseY >= 397 and MouseY <= 430 then %button to place vertically
	    fork ClickSound
	    VerticalPlacement := true
	    Draw.FillBox (445, 430, 575, 397, gray)
	    Draw.FillBox (600, 430, 766, 398, black)
	    WriteShipNames
	elsif MouseX >= 600 and MouseX <= 766 and MouseY >= 398 and MouseY <= 430 then %button to place horizontally
	    fork ClickSound
	    VerticalPlacement := false
	    Draw.FillBox (445, 430, 575, 397, black)
	    Draw.FillBox (600, 430, 766, 398, gray)
	    WriteShipNames
	elsif MouseX >= 650 and MouseX <= 771 and MouseY >= 27 and MouseY <= 60 then %button to start the actual game
	    if APlaced and BPlaced and SPlaced and DPlaced and PPlaced then %make sure all ships are placed
		fork ClickSound
		delay (400)
		exit
	    else
		fork ErrorSound
	    end if
	end if

	if Column > 0 and Row > 0 then %if the xval and yval is on the grid

	    if ShipToPlace = "A" and APlaced then %disallow double placing
		AllowPlace := false
	    elsif ShipToPlace = "B" and BPlaced then
		AllowPlace := false
	    elsif ShipToPlace = "S" and SPlaced then
		AllowPlace := false
	    elsif ShipToPlace = "D" and DPlaced then
		AllowPlace := false
	    elsif ShipToPlace = "P" and PPlaced then
		AllowPlace := false
	    end if

	    if VerticalPlacement then %place vertically
		if Row + ShipLength - 1 <= 10 then %does not go off grid
		    for yDiff : 0 .. (ShipLength - 1)
			if P1Board (Row + yDiff, Column) not= "X" then %does not overlap ships
			    AllowPlace := false
			end if
		    end for
		    if AllowPlace then
			for yDiff : 0 .. (ShipLength - 1) %places the ships
			    P1Board (Row + yDiff, Column) := ShipToPlace
			    Player1Board -> setDrawCR (Column, Row + yDiff)
			    Player1Board -> DrawCell
			end for
		    end if
		else
		    AllowPlace := false
		end if
	    else
		if Column + ShipLength - 1 <= 10 then %place horizontally
		    for xDiff : 0 .. (ShipLength - 1)
			if P1Board (Row, Column + xDiff) not= "X" then
			    AllowPlace := false
			end if
		    end for
		    if AllowPlace then
			for xDiff : 0 .. (ShipLength - 1)
			    P1Board (Row, Column + xDiff) := ShipToPlace
			    Player1Board -> setDrawCR (Column + xDiff, Row)
			    Player1Board -> DrawCell
			end for
		    end if
		else
		    AllowPlace := false
		end if
	    end if

	    if AllowPlace then %marks that a ship has been placed
		fork ClickSound
		if ShipToPlace = "A" then
		    APlaced := true
		elsif ShipToPlace = "B" then
		    BPlaced := true
		elsif ShipToPlace = "S" then
		    SPlaced := true
		elsif ShipToPlace = "D" then
		    DPlaced := true
		elsif ShipToPlace = "P" then
		    PPlaced := true
		end if
	    else
		fork ErrorSound
	    end if

	end if
	AllowPlace := true
    end loop
end PlayerPlaceShips
