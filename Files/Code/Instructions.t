%Programmer:   Gary Zheng
%Date:         June 2013
%Course:       ICS3CU1
%Teacher:      M. Ianni
%Program Name: BattleShip
%Description: displays instructions; procedures to run: DisplayInstructions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

proc WriteInstructions
    var TextY : int := 450
    var FONT : int := Font.New ("comicsans:28")
    var stream : int
    var line : string
    open : stream, "Files/Text/Instructions.txt", get
    loop
	get : stream, skip
	exit when eof (stream)
	get : stream, line : *
	Font.Draw (line, 30, TextY, FONT, white)
	TextY -= 50
    end loop
    close : stream
end WriteInstructions

proc DisplayInstructions
    var xval, yval, click, DrawThis : int
    var SoundPlayed : boolean := false
    DrawThis := Pic.FileNew ("Images/Instructions/InstructionsBG.bmp") %displays instructions background image
    Pic.Draw (DrawThis, 0, 0, 0)
    Pic.Free (DrawThis)
    WriteInstructions %reads instructions from text file then displays it
    loop
	Mouse.Where (xval, yval, click)
	if xval >= 581 and xval <= 756 and yval >= 20 and yval <= 78 then %mouse hovers over BACK button
	    DrawThis := Pic.FileNew ("Images/Instructions/InstructionsHover.bmp") %when mouse hover, BACK button changes shape
	    Pic.Draw (DrawThis, 0, 0, 2)
	    Pic.Free (DrawThis)
	    if SoundPlayed = false then %prevents sound glitches
		SoundPlayed := true
		fork HoverSound
	    end if
	    if click = 1 then
		fork ClickSound
		delay (150) %prevents double click
		exit
	    end if
	else
	    DrawThis := Pic.FileNew ("Images/Instructions/InstructionsNoHover.bmp") %display regular BACK button
	    Pic.Draw (DrawThis, 0, 0, 2)
	    Pic.Free (DrawThis)
	    SoundPlayed := false
	end if
    end loop
end DisplayInstructions
