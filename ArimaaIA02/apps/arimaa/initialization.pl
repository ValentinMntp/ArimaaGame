/*
	============================================================
	============================================================
	Positioning pieces on the board
  						[[(0, s2),(0, s2),(0, s2),(0, s2),(0, s2),(0, s2),(0, s2),(0, s2)],
               [(0, s1),(0, s1),(0, s1),(0, s1),(0, s1),(0, s1),(0, s1),(0, s1)],
               [(0, e),(0, e),(0, t),(0, e),(0, e),(0, t),(0, e),(0, e)],
               [(0, e),(0, e),(0, e),(eS, e),(rS, e),(0, e),(0, e),(0, e)],
               [(0, e),(0, e),(0, e),(0, e),(eG, e),(rS, e),(0, e),(0, e)],
               [(0, e),(rS, e),(0, t),(0, e),(0, e),(0, t),(0, e),(0, e)],
               [(eG, g1),(rG, g1),(0, g1),(0, g1),(0, g1),(0, g1),(0, g1),(0, g1)],
               [(eS, g2),(hG, g2),(0, g2),(0, g2),(0, g2),(0, g2),(0, g2),(0, g2)]]
	============================================================
	============================================================
*/

/*
	setBrd(Tab)
	------------------------------
	Board dynamic modification.
	Test if a board already exist, if not it's added.

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
		Start positioning Human Side
		Unifies result with ResBrd.
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

/* GenerateRandomtartPosition version */

/*
humanPositioningMenu(Brd, [],_, Brd) :-
	nl, write("Human initialization"), showBrd(Brd), !.
humanPositioningMenu(Brd, [T|Q], PlayerSide, ResBrd) :-
	repeat, generateRandomStartPositionGold(X,Y),
	checkValidPosition(Brd, PlayerSide,(X,Y)),
	pieceDenomination(PlayerSide, T, TypePion),
	cellType((X,Y), Brd, TypeCell),
	setCell(Brd, (TypePion, TypeCell), (X,Y), SubBrd),
	humanPositioningMenu(SubBrd, Q, PlayerSide, ResBrd).
*/

/*
	iaPositioningMenu
	------------------------------
	Launch automatic positionning phase for the IA  (or player 2)
	Unifies result with ResBrd.
*/
iaPositioningMenu(Brd, [],_, Brd) :-
	nl, write("AI initialization"), showBrd(Brd), !.
iaPositioningMenu(Brd, [T|Q], PlayerSide, ResBrd) :-
	repeat, generateRandomStartPositionSilver(X,Y),
	checkValidPosition(Brd, PlayerSide,(X,Y)),
	pieceDenomination(PlayerSide, T, TypePion),
	cellType((X,Y), Brd, TypeCell),
	setCell(Brd, (TypePion, TypeCell), (X,Y), SubBrd),
	iaPositioningMenu(SubBrd, Q, PlayerSide, ResBrd).


/*
	generateRandomStartPosition
	------------------------------
	generate random position for IA pieces.
*/
generateRandomStartPositionSilver(X,Y) :- random(1,3,X), random(1,9,Y).
generateRandomStartPositionGold(X,Y) :- random(7,9,X), random(1,9,Y).
