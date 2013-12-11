%Programmer:   Gary Zheng
%Date:         June 2013
%Course:       ICS3CU1
%Teacher:      M. Ianni
%Program Name: BattleShip
%Descriptions: displays gameover; procedures to run: GameOver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

proc DisplayGOStats (Username : string, SmartAI, YourHits, YourMisses, EnemyHits,
	EnemyMisses, EnemyShipPartsLeft, PlayerShipPartsLeft : int)
    var FONT : int := Font.New ("comicsans:28")
    var FONT2 : int := Font.New ("comicsans:20")
    var AIname : string := "Dumb AI"

    if SmartAI = 0 then
	AIname := "Dumb AI"
    elsif SmartAI = 1 then
	AIname := "Smart AI"
    end if

    Font.Draw (Username + " VS. " + AIname, 60, 475, FONT, white)

    if PlayerShipPartsLeft > EnemyShipPartsLeft then
	Font.Draw (Username + " WINS!", 60, 425, FONT, white)
    elsif PlayerShipPartsLeft < EnemyShipPartsLeft then
	Font.Draw (AIname + " WINS!", 60, 425, FONT, white)
    elsif PlayerShipPartsLeft = EnemyShipPartsLeft then
	Font.Draw ("TIE!", 60, 425, FONT, white)
    end if

    Font.Draw (Username + "'s Stats", 60, 345, FONT, white)
    Font.Draw ("Hits: " + intstr (YourHits), 60, 295, FONT2, white)
    Font.Draw ("Misses: " + intstr (YourMisses), 60, 245, FONT2, white)
    Font.Draw (AIname + "'s Stats", 400, 345, FONT, white)
    Font.Draw ("Hits: " + intstr (EnemyHits), 400, 295, FONT2, white)
    Font.Draw ("Misses: " + intstr (EnemyMisses), 400, 245, FONT2, white)
    Font.Draw ("Ship Parts Left", 250, 173, FONT, white)
    Font.Draw (Username + ": " + intstr (PlayerShipPartsLeft), 60, 120, FONT2, white)
    Font.Draw (AIname + ": " + intstr (EnemyShipPartsLeft), 400, 120, FONT2, white)

end DisplayGOStats

proc GameOver (Username : string, SmartAI, YourHits, YourMisses, EnemyHits,
	EnemyMisses, EnemyShipPartsLeft, PlayerShipPartsLeft : int)
    var xval, yval, click, DrawThis : int
    var SoundPlayed : boolean := false
    DrawThis := Pic.FileNew ("Images/GameOver/GameOverBG.bmp") %display the background image
    Pic.Draw (DrawThis, 0, 0, 0)
    Pic.Free (DrawThis)
    DisplayGOStats (Username, SmartAI, YourHits, YourMisses, EnemyHits, %"GO" = GameOver
	EnemyMisses, EnemyShipPartsLeft, PlayerShipPartsLeft)
    loop
	Mouse.Where (xval, yval, click)
	if xval >= 461 and xval <= 750 and yval >= 11 and yval <= 80 then %when mouse hovers over QUIT
	    DrawThis := Pic.FileNew ("Images/GameOver/GameOverHover.bmp") %displays the QUIT hover image
	    Pic.Draw (DrawThis, 0, 0, 2)
	    Pic.Free (DrawThis)
	    if SoundPlayed = false then %prevents the sound from playing continiously
		SoundPlayed := true
		fork HoverSound
	    end if
	    if click = 1 then
		fork ClickSound
		delay (150) %prevents double click
		exit
	    end if
	else
	    DrawThis := Pic.FileNew ("Images/GameOver/GameOverNoHover.bmp") %displays the non QUIT hover image
	    Pic.Draw (DrawThis, 0, 0, 2)
	    Pic.Free (DrawThis)
	    SoundPlayed := false
	end if
    end loop
end GameOver
