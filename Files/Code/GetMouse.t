%Programmer:   Gary Zheng
%Date:         June 2013
%Course:       ICS3CU1
%Teacher:      M. Ianni
%Program Name: BattleShip
%Descriptions: gets mouse data, procs to run: GetMouse
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

proc GetMouse (var MouseX, MouseY : int)
    var Click : int := 0
    loop
	Mouse.Where (MouseX, MouseY, Click)
	% locate (2, 1)
	% put MouseX, ", ", MouseY
	exit when Click = 1
    end loop
end GetMouse
