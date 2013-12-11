%Programmer:   Gary Zheng
%Date:         June 2013
%Course:       ICS3CU1
%Teacher:      M. Ianni
%Program Name: BattleShip
%Description: sound processes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

process HoverSound
    Music.PlayFile ("Sounds/MenuHover.wav")
end HoverSound

process ClickSound
    Music.PlayFile ("Sounds/MenuClick.wav")
end ClickSound

process Gunshot
    Music.PlayFile ("Sounds/IntroGunshot.wav")
end Gunshot

process ErrorSound
    Music.PlayFile ("Sounds/ErrorSound.wav")
end ErrorSound

process Splash
    Music.PlayFile ("Sounds/Splash.wav")
end Splash

process Hit
    Music.PlayFile ("Sounds/Hit.wav")
end Hit
