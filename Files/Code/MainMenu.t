%Programmer:   Gary Zheng
%Date:         June 2013
%Course:       ICS3CU1
%Teacher:      M. Ianni
%Program Name: BattleShip
%Description: gets main menu choice; functions to run: MenuSelect
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

proc HoverDisplay (choice : int)
    var DrawThis : int
    if choice = 0 then
	DrawThis := Pic.FileNew ("Images/MainMenu/NOSELECT.bmp")
    elsif choice = 1 then
	DrawThis := Pic.FileNew ("Images/MainMenu/PLAY.bmp")
    elsif choice = 2 then
	DrawThis := Pic.FileNew ("Images/MainMenu/INSTRUCTIONS.bmp")
    elsif choice = 3 then
	DrawThis := Pic.FileNew ("Images/MainMenu/OPTIONS.bmp")
    elsif choice = 4 then
	DrawThis := Pic.FileNew ("Images/MainMenu/QUIT.bmp")
    end if

    Pic.Draw (DrawThis, 0, 0, 0)
    Pic.Free (DrawThis)
end HoverDisplay

fcn MenuSelect : int
    var xval, yval, click : int
    var SoundPlayed := false
    HoverDisplay (0)
    loop
	Mouse.Where (xval, yval, click)
	if xval >= 342 and xval <= 469 and yval >= 134 and yval <= 179 then %mouse hover over PLAY
	    if SoundPlayed = false then
		SoundPlayed := true
		fork HoverSound
	    end if
	    HoverDisplay (1) %PLAY pops up
	    if click = 1 then
		fork ClickSound
		result 1
	    end if
	elsif xval >= 207 and xval <= 614 and yval >= 76 and yval <= 121 then %mouse hover over INSTRUCTIONS
	    if SoundPlayed = false then
		SoundPlayed := true
		fork HoverSound
	    end if
	    HoverDisplay (2) %INSTRUCTIONS pops up
	    if click = 1 then
		fork ClickSound
		result 2
	    end if
	elsif xval >= 284 and xval <= 528 and yval >= 17 and yval <= 63 then %mouse hover over OPTIONS
	    if SoundPlayed = false then
		SoundPlayed := true
		fork HoverSound
	    end if
	    HoverDisplay (3) %OPTIONS pops up
	    if click = 1 then
		fork ClickSound
		result 3
	    end if
	elsif xval >= 674 and xval <= 776 and yval >= 19 and yval <= 54 then %mouse hover over QUIT
	    if SoundPlayed = false then
		SoundPlayed := true
		fork HoverSound
	    end if
	    HoverDisplay (4) %QUIT pops up
	    if click = 1 then
		fork ClickSound
		result 4
	    end if
	else
	    SoundPlayed := false
	    HoverDisplay (0)
	end if
    end loop
end MenuSelect
