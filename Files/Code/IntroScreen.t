%Programmer:   Gary Zheng
%Date:         June 2013
%Course:       ICS3CU1
%Teacher:      M. Ianni
%Program Name: BattleShip
%Descriptions: displays a intro; procedures to run: PlayIntro
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

proc PlayIntro %offscreenonly and View.Updat will not work for me
    var BG := Pic.FileNew ("Images/IntroAnimation/Complete/BG.bmp")
    var Bc := Pic.FileNew ("Images/IntroAnimation/Complete/Bc.bmp")
    var Ac := Pic.FileNew ("Images/IntroAnimation/Complete/Ac.bmp")
    var Tc := Pic.FileNew ("Images/IntroAnimation/Complete/Tc.bmp")
    var Tc2 := Pic.FileNew ("Images/IntroAnimation/Complete/Tc2.bmp")
    var Lc := Pic.FileNew ("Images/IntroAnimation/Complete/Lc.bmp")
    var Ec := Pic.FileNew ("Images/IntroAnimation/Complete/Ec.bmp")
    var Sc := Pic.FileNew ("Images/IntroAnimation/Complete/Sc.bmp")
    var Hc := Pic.FileNew ("Images/IntroAnimation/Complete/Hc.bmp")
    var Ic := Pic.FileNew ("Images/IntroAnimation/Complete/Ic.bmp")
    var Pc := Pic.FileNew ("Images/IntroAnimation/Complete/Pc.bmp")

    var B := Pic.FileNew ("Images/IntroAnimation/B.bmp")
    var A := Pic.FileNew ("Images/IntroAnimation/A.bmp")
    var T := Pic.FileNew ("Images/IntroAnimation/T.bmp")
    var L := Pic.FileNew ("Images/IntroAnimation/L.bmp")
    var E := Pic.FileNew ("Images/IntroAnimation/E.bmp")
    var S := Pic.FileNew ("Images/IntroAnimation/S.bmp")
    var H := Pic.FileNew ("Images/IntroAnimation/H.bmp")
    var I := Pic.FileNew ("Images/IntroAnimation/I.bmp")
    var P := Pic.FileNew ("Images/IntroAnimation/P.bmp")

    loop %characters drop out of the top of the screen, press any key to skip
	for decreasing y : 600 .. 476 by 2 %B
	    Pic.Draw (B, 33, y, 2)
	    Pic.Draw (BG, 0, 0, 2)
	end for
	Pic.Draw (Bc, 0, 0, 2) %prevents flashing
	Pic.Free (B)
	Pic.Free (BG)
	fork Gunshot
	exit when hasch
	for decreasing y : 600 .. 476 by 2 %A
	    Pic.Draw (A, 105, y, 2)
	    Pic.Draw (Bc, 0, 0, 2)
	end for
	Pic.Draw (Ac, 0, 0, 2)
	Pic.Free (A)
	Pic.Free (Bc)
	fork Gunshot
	exit when hasch
	for decreasing y : 600 .. 476 by 2 %T
	    Pic.Draw (T, 173, y, 2)
	    Pic.Draw (Ac, 0, 0, 2)
	end for
	Pic.Draw (Tc, 0, 0, 2)
	Pic.Free (Ac)
	fork Gunshot
	exit when hasch
	for decreasing y : 600 .. 476 by 2 %T
	    Pic.Draw (T, 250, y, 2)
	    Pic.Draw (Tc, 0, 0, 2)
	end for
	Pic.Draw (Tc2, 0, 0, 2)
	Pic.Free (T)
	Pic.Free (Tc)
	fork Gunshot
	exit when hasch
	for decreasing y : 600 .. 476 by 2 %L
	    Pic.Draw (L, 335, y, 2)
	    Pic.Draw (Tc2, 0, 0, 2)
	end for
	Pic.Draw (Lc, 0, 0, 2)
	Pic.Free (L)
	Pic.Free (Tc2)
	fork Gunshot
	exit when hasch
	for decreasing y : 600 .. 476 by 2 %E
	    Pic.Draw (E, 402, y, 2)
	    Pic.Draw (Lc, 0, 0, 2)
	end for
	Pic.Draw (Ec, 0, 0, 2)
	Pic.Free (E)
	Pic.Free (Lc)
	fork Gunshot
	exit when hasch
	for decreasing y : 600 .. 476 by 2 %S
	    Pic.Draw (S, 472, y, 2)
	    Pic.Draw (Ec, 0, 0, 2)
	end for
	Pic.Draw (Sc, 0, 0, 2)
	Pic.Free (S)
	Pic.Free (Ec)
	fork Gunshot
	exit when hasch
	for decreasing y : 600 .. 476 by 2 %H
	    Pic.Draw (H, 547, y, 2)
	    Pic.Draw (Sc, 0, 0, 2)
	end for
	Pic.Draw (Hc, 0, 0, 2)
	Pic.Free (H)
	Pic.Free (Sc)
	fork Gunshot
	exit when hasch
	for decreasing y : 600 .. 476 by 2 %I
	    Pic.Draw (I, 630, y, 2)
	    Pic.Draw (Hc, 0, 0, 2)
	end for
	Pic.Draw (Ic, 0, 0, 2)
	Pic.Free (I)
	Pic.Free (Hc)
	fork Gunshot
	exit when hasch
	for decreasing y : 600 .. 476 by 2 %P
	    Pic.Draw (P, 684, y, 2)
	    Pic.Draw (Ic, 0, 0, 2)
	end for
	Pic.Draw (Pc, 0, 0, 0)
	Pic.Free (P)
	Pic.Free (Ic)
	fork Gunshot
	exit when hasch
	Pic.Draw (Pc, 0, 0, 0)
	delay (500)
	Pic.Free (Pc)
	exit
    end loop
end PlayIntro
