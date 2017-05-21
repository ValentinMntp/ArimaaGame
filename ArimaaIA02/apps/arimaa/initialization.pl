/*
	============================================================
	============================================================
	Positionnement des pions sur le plateau
  						[[(0, s2),(0, s2),(0, s2),(0, s2),(0, s2),(0, s2),(0, s2),(0, s2)],
               [(0, s1),(0, s1),(0, s1),(0, s1),(0, s1),(0, s1),(0, s1),(0, s1)],
               [(0, e),(0, e),(0 , t),(0, e),(0, e),(0, t),(0, e),(0, e)],
               [(0, e),(0, e),(0, e),(0, e),(0, e),(0, e),(0, e),(0, e)],
               [(0, e),(0, e),(0, e),(0, e),(0, e),(0, e),(0, e),(0, e)],
               [(0, e),(0, e),(0, t),(0, e),(0, e),(0, t),(0, e),(0, e)],
               [(0, g1),(0, g1),(0, g1),(0, g1),(0, g1),(0, g1),(0, g1),(0, g1)],
               [(0, g2),(0, g2),(0, g2),(0, g2),(0, g2),(0, g2),(0, g2),(0, g2)]]
	============================================================
	============================================================
*/

/*
	setBrd(Tab)
	------------------------------
	Modifie le prédicat dynamique du tableau
	Teste d'abord le retract si il y existe déjà un fait
	Sinon, il l'ajoute.
*/
setBrd(Brd) :-
	retractall(board(_)),
	assertz(board(Brd)), !.
setBrd(Brd) :-
	assertz(board(Brd)).


/*
	positioningPhase
	------------------------------
	Starting initialization of all
	pieces at the beginning of the game
*/
positioningPhase(Brd, ResBrd) :-
	nl, nl, writeMultSep(3, 60),
	wTab, write("Pieces placement, GOLD side"), nl,
	playerPositioning(Brd, gold, SubBrd),
	nl, nl, writeMultSep(3, 60),
	wTab, write("Pieces placement SILVER side"), nl,
	playerPositioning(SubBrd, silver, ResBrd),
	nl, writeMultSep(4, 60),
	nl, writeln("Plateau de depart : "),
	showBrd(ResBrd), !.

/*
	playerPositioning
	------------------------------
	Start positioning gold and silver side
	Unifies result with ResBrd.
*/
playerPositioning(Brd, gold, ResBrd) :-
	humanPositioningMenu(Brd, [elephant, camel, horse, horse, dog, dog, cat, cat, rabbit, rabbit, rabbit, rabbit, rabbit, rabbit, rabbit, rabbit], gold, ResBrd).
playerPositioning(Brd, silver, ResBrd) :-
	iaPositioningMenu(Brd, [elephant, camel, horse, horse, dog, dog, cat, cat, rabbit, rabbit, rabbit, rabbit, rabbit, rabbit, rabbit, rabbit], silver, ResBrd).


/*
	humanPositioningMenu
	------------------------------
		Lance le positionnement humain du joueur
		du camp PlayerSide
	Unifie le résultat du positionnement avec ResBrd.
*/
humanPositioningMenu(Brd, [], _, Brd) :- showBrd(Brd).
humanPositioningMenu(Brd, [T|Q], PlayerSide, ResBrd) :-
	repeat, nl, writeSep(20), nl,
	showBrd(Brd),
	write(" [Player "), write(PlayerSide), write("] => Position of "),
	write(T), nl, write("Write position in this format : (X,Y) "), nl,
	read(CHOICE),checkValidPosition(Brd, PlayerSide, CHOICE),
	pieceDenomination(PlayerSide, T, TypePion),
	cellType((X,Y), Brd, TypeCell),
	setCell(Brd, (TypePion, TypeCell), CHOICE, SubBrd),
	humanPositioningMenu(SubBrd, Q, PlayerSide, ResBrd).


/*
	iaPositioningMenu
	------------------------------
	Lance le positionnement IA du joueur
	du camp PlayerSide
	Unifie le résultat du positionnement avec ResBrd.
*/
iaPositioningMenu(Brd, [],_, Brd) :-
	nl, write("AI initialization"), showBrd(Brd), !.
iaPositioningMenu(Brd, [T|Q], PlayerSide, ResBrd) :-
	repeat, generateRandomStartPosition(X,Y),
	checkValidPosition(Brd, PlayerSide,(X,Y)),
	pieceDenomination(PlayerSide, T, TypePion),
	cellType((X,Y), Brd, TypeCell),
	setCell(Brd, (TypePion, TypeCell), (X,Y), SubBrd),
	iaPositioningMenu(SubBrd, Q, PlayerSide, ResBrd).


/*
	generateRandomStartPosition
	------------------------------
	Génére des coordonnées aléatoires pour
	le placement des pions pour l'IA
*/
generateRandomStartPosition(X,Y) :- random(1,3,X), random(1,9,Y).
