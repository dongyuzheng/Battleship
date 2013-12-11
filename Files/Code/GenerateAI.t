%Programmer:   Gary Zheng
%Date:         June 2013
%Course:       ICS3CU1
%Teacher:      M. Ianni
%Program Name: BattleShip
%Descriptions: randomizes AI's ships; procs to run: GenerateAI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fcn GetOrientation : boolean
    var x : int := Rand.Int (1, 2)
    if x = 1 then
	result true
    else
	result false
    end if
end GetOrientation

proc GenerateAI (var P2Board : array 1 .. 10, 1 .. 10 of string)
    var Row, Column, CountDown, ShipLength : int := 5
    var VerticalPlacement : boolean
    var AllowPlace : boolean := true
    var ShipToPlace : string

    loop
	exit when CountDown = 0
	if CountDown = 5 then %determines which ship to place
	    ShipToPlace := "A"
	    ShipLength := 5
	elsif CountDown = 4 then
	    ShipToPlace := "B"
	    ShipLength := 4
	elsif CountDown = 3 then
	    ShipToPlace := "S"
	    ShipLength := 3
	elsif CountDown = 2 then
	    ShipToPlace := "D"
	    ShipLength := 3
	elsif CountDown = 1 then
	    ShipToPlace := "P"
	    ShipLength := 2
	end if

	Row := Rand.Int (1, 10)
	Column := Rand.Int (1, 10)
	VerticalPlacement := GetOrientation %randomizes horizontal/vertical ships

	if VerticalPlacement then %place vertically
	    if Row + ShipLength - 1 <= 10 then %does not go off grid
		for yDiff : 0 .. (ShipLength - 1)
		    if P2Board (Row + yDiff, Column) not= "X" then %does not overlap ships
			AllowPlace := false
		    end if
		end for
		if AllowPlace then
		    for yDiff : 0 .. (ShipLength - 1) %places the ships
			P2Board (Row + yDiff, Column) := ShipToPlace
		    end for
		    CountDown -= 1
		end if
	    end if
	else
	    if Column + ShipLength - 1 <= 10 then %place horizontally
		for xDiff : 0 .. (ShipLength - 1)
		    if P2Board (Row, Column + xDiff) not= "X" then
			AllowPlace := false
		    end if
		end for
		if AllowPlace then
		    for xDiff : 0 .. (ShipLength - 1)
			P2Board (Row, Column + xDiff) := ShipToPlace
		    end for
		    CountDown -= 1
		end if
	    end if
	end if
	AllowPlace := true
    end loop
    cls

    % for x : 1 .. 10     %uncomment to check AI's ship placements
    %     for y : 1 .. 10
    %         if y = 10 then
    %             put P2Board (x, y)
    %         else
    %             put P2Board (x, y), " " ..
    %         end if
    %     end for
    % end for
    % loop
    %     exit when hasch
    % end loop
end GenerateAI
