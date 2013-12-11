%Programmer:   Gary Zheng
%Date:         June 2013
%Course:       ICS3CU1
%Teacher:      M. Ianni
%Program Name: BattleShip
%Description:  allows user to modify game options; procedures to run: SetOptions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fcn isInt (word : string) : boolean
    var answer : boolean := true
    if index ("+-1234567890", word (1)) = 0 then
	answer := false
    end if
    for i : 2 .. length (word)
	if index ("1234567890", word (i)) = 0 then
	    answer := false
	end if
    end for
    result answer
end isInt

fcn GetUserName : string
    var word : string
    var stream : int
    open : stream, "Files/Text/Options.txt", get
    for i : 1 .. 2 %gets the second word, which is the username value
	get : stream, skip
	exit when eof (stream)
	get : stream, word
    end for
    close : stream
    result word
end GetUserName

fcn GetAI : int
    var word : string
    var stream : int
    open : stream, "Files/Text/Options.txt", get
    for i : 1 .. 4 %gets the 4th word, which is the AI value
	get : stream, skip
	exit when eof (stream)
	get : stream, word
    end for
    close : stream
    result strint (word)
end GetAI

proc RestoreDefault %copy everything from defualt to options
    var line : string
    var stream, stream2 : int
    open : stream, "Files/Data/default.dat", get
    open : stream2, "Files/Text/Options.txt", put
    loop
	exit when eof (stream)
	get : stream, line : *
	put : stream2, line
    end loop
    close : stream2
    close : stream
end RestoreDefault

proc EraseOptions %clear text from screen
    var DrawThis := Pic.FileNew ("Images/Options/OptionsBG.bmp")
    Pic.Draw (DrawThis, 0, 0, 0)
    Pic.Free (DrawThis)
end EraseOptions

proc DisplayOptions %draw text to screen, read from options.txt
    var TextY : int := 450
    var FONT : int := Font.New ("comicsans:28")
    var stream : int
    var line : string
    open : stream, "Files/Text/Options.txt", get
    loop
	get : stream, skip
	exit when eof (stream)
	get : stream, line : *
	Font.Draw (line, 30, TextY, FONT, white)
	TextY -= 50
    end loop
    close : stream
end DisplayOptions

proc Change %displays the CHANGE buttons
    var FONT : int := Font.New ("comicsans:28")
    Font.Draw ("CHANGE", 600, 450, FONT, white)
    Font.Draw ("CHANGE", 600, 400, FONT, white)
end Change

proc GetNewName (SmartAI : int)
    var NewName : string := ""
    var stream : int
    loop
	Text.ColourBack (yellow)
	Text.Colour (blue)
	locate (1, 1)
	put "                                                                "
	locate (1, 1)
	put "ENTER YOUR NEW NAME (1-8 Characters Long): " ..
	get NewName %gets the new username
	exit when length (NewName) >= 1 and length (NewName) <= 8 %make sure new name is legal
    end loop
    open : stream, "Files/Text/Options.txt", put %modify the options.txt
    put : stream, "Name= " + NewName
    put : stream, "SmartAI= " + intstr (SmartAI)
    close : stream
end GetNewName

proc GetNewAI (Username : string)
    var NewLevel : string := ""
    var stream : int
    loop
	Text.ColourBack (yellow)
	Text.Colour (blue)
	locate (1, 1)
	put "                                                                "
	locate (1, 1)
	put "ENTER NEW AI LEVEL (0-1): " ..
	get NewLevel %gets the new ai level
	if isInt (NewLevel) then %make sure new ai level is legal
	    exit when NewLevel = "0" or NewLevel = "1"
	end if
    end loop
    open : stream, "Files/Text/Options.txt", put %modify the options.txt
    put : stream, "Name= " + Username
    put : stream, "SmartAI= " + NewLevel
    close : stream
end GetNewAI

proc SetOptions (var Username : string, var SmartAI : int)
    var xval, yval, click, DrawThis : int
    var SoundPlayed, TextDisplayed : boolean := false
    DrawThis := Pic.FileNew ("Images/Options/OptionsBG.bmp")
    Pic.Draw (DrawThis, 0, 0, 0)
    Pic.Free (DrawThis)
    loop
	Mouse.Where (xval, yval, click)
	% locate (1, 1)
	% put xval, ", ", yval
	if xval >= 581 and xval <= 756 and yval >= 20 and yval <= 78 then %mouse hover over BACK
	    DrawThis := Pic.FileNew ("Images/Options/BackHover.bmp")
	    Pic.Draw (DrawThis, 0, 0, 2)
	    Pic.Free (DrawThis)
	    if SoundPlayed = false then
		SoundPlayed := true
		fork HoverSound
	    end if
	    if click = 1 then
		fork ClickSound
		delay (150) %prevents double click
		Username := GetUserName
		SmartAI := GetAI
		exit
	    end if
	elsif xval >= 9 and xval <= 301 and yval >= 17 and yval <= 78 then
	    DrawThis := Pic.FileNew ("Images/Options/DefaultHover.bmp") %mouse hover over DEFAULT
	    Pic.Draw (DrawThis, 0, 0, 2)
	    Pic.Free (DrawThis)
	    if SoundPlayed = false then
		SoundPlayed := true
		fork HoverSound
	    end if
	    if click = 1 then
		fork ClickSound
		RestoreDefault
		EraseOptions
		DisplayOptions
		Change
		delay (150) %prevents double click
	    end if
	elsif xval >= 600 and xval <= 760 and yval >= 450 and yval <= 480 then %change name
	    if SoundPlayed = false then
		SoundPlayed := true
		fork HoverSound
	    end if
	    if click = 1 then
		fork ClickSound
		SmartAI := GetAI
		GetNewName (SmartAI)
		EraseOptions
		DisplayOptions
		Change
		DrawThis := Pic.FileNew ("Images/Options/NoHover.bmp")
		Pic.Draw (DrawThis, 0, 0, 2)
		Pic.Free (DrawThis)
		delay (150) %prevents double click
	    end if
	elsif xval >= 600 and xval <= 760 and yval >= 400 and yval <= 430 then %change AI level
	    if SoundPlayed = false then
		SoundPlayed := true
		fork HoverSound
	    end if
	    if click = 1 then
		fork ClickSound
		Username := GetUserName
		GetNewAI (Username)
		EraseOptions
		DisplayOptions
		Change
		DrawThis := Pic.FileNew ("Images/Options/NoHover.bmp")
		Pic.Draw (DrawThis, 0, 0, 2)
		Pic.Free (DrawThis)
		delay (150) %prevents double click
	    end if
	else
	    DrawThis := Pic.FileNew ("Images/Options/NoHover.bmp") %mouse is not on a button
	    Pic.Draw (DrawThis, 0, 0, 2)
	    Pic.Free (DrawThis)
	    DisplayOptions
	    Change
	    SoundPlayed := false
	end if
    end loop
end SetOptions
