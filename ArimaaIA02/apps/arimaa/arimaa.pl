% :- module(bot,
%       [  get_moves/3
%       ]).

:- include('externalTools.pl').
:- include('internalTools.pl').
:- include('print.pl').

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
	============================================================
	============================================================
	Positionnement des pions sur le plateau
  						[[(0, s2),(0, s2),(0, s2),(0, s2),(0, s2),(0, s2),(0, s2),(0, s2)],
               [(0, s1),(0, s1),(0, s1),(0, s1),(0, s1),(0, s1),(0, s1),(0, s1)],
               [(0, e),(0, e),(0 , t),(0, e),(0, e),(0, t),(0, e),(0, e)],
               [(0, e),(0, e),(0, e),(0, e),(0, e),(0, e),(0, e),(0, e)],
               [(0, e),(0, e),(0, e),(0, e),(0, e),(0, e),(0, e),(0, e)],
               [(0, e),(0, e),(0, t),(0, e),(0, e),(0, t),(0, e),(0, e)],
               [(eG, g1),(0, g1),(0, g1),(0, g1),(0, g1),(0, g1),(0, g1),(0, g1)],
               [(0, g2),(0, g2),(0, g2),(0, g2),(0, g2),(0, g2),(0, g2),(0, g2)]]
	============================================================
	============================================================
*/

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
	%playerPositioning(SubBrd, silver, ResBrd),
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
humanPositioningMenu(_, [], _, _).
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
iaPositioningMenu(Brd, 7, PlayerSide, Brd) :-
	nl, write("Positionnement de l'IA du camp "), writeln(PlayerSide),
	showBrd(Brd), !.
iaPositioningMenu(Brd, 6, PlayerSide, ResBrd) :-
	repeat, generateRandomStartPosition(PlayerSide, (X,Y)),
	cell(X,Y, Brd, (CellPower,empty)),
	pieceDenomination(PlayerSide, kalista, Type),
	setCell(Brd, (CellPower, Type), (X,Y), SubBrd),
	iaPositioningMenu(SubBrd, 7, PlayerSide, ResBrd).
iaPositioningMenu(Brd, N, PlayerSide, ResBrd) :-
	repeat, generateRandomStartPosition(PlayerSide, (X,Y)),
	cell(X,Y, Brd, (CellPower,empty)),
	M is N+1,
	pieceDenomination(PlayerSide, sbire, Type),
	setCell(Brd, (CellPower, Type), (X,Y), SubBrd),
	iaPositioningMenu(SubBrd, M, PlayerSide, ResBrd).


/*
	generateRandomStartPosition
	------------------------------
	Génére des coordonnées aléatoires pour
	le placement des pions pour l'IA
*/
generateRandomStartPosition(ocre, (X,Y)) :-
	random(1,3,X), random(1,7,Y).
generateRandomStartPosition(rouge, (X,Y)) :-
	random(5,7,X), random(1,7,Y).



% get_moves signature
% get_moves(Moves, gamestate, board).

% Exemple of variable
% gamestate: [side, [captured pieces] ] (e.g. [silver, [ [0,1,rabbit,silver],[0,2,horse,silver] ])
% board: [[0,0,rabbit,silver],[0,1,rabbit,silver],[0,2,horse,silver],[0,3,rabbit,silver],[0,4,elephant,silver],[0,5,rabbit,silver],[0,6,rabbit,silver],[0,7,rabbit,silver],[1,0,camel,silver],[1,1,cat,silver],[1,2,rabbit,silver],[1,3,dog,silver],[1,4,rabbit,silver],[1,5,horse,silver],[1,6,dog,silver],[1,7,cat,silver],[2,7,rabbit,gold],[6,0,cat,gold],[6,1,horse,gold],[6,2,camel,gold],[6,3,elephant,gold],[6,4,rabbit,gold],[6,5,dog,gold],[6,6,rabbit,gold],[7,0,rabbit,gold],[7,1,rabbit,gold],[7,2,rabbit,gold],[7,3,cat,gold],[7,4,dog,gold],[7,5,rabbit,gold],[7,6,horse,gold],[7,7,rabbit,gold]]

% Call exemple:
% get_moves(Moves, [silver, []], [[0,0,rabbit,silver],[0,1,rabbit,silver],[0,2,horse,silver],[0,3,rabbit,silver],[0,4,elephant,silver],[0,5,rabbit,silver],[0,6,rabbit,silver],[0,7,rabbit,silver],[1,0,camel,silver],[1,1,cat,silver],[1,2,rabbit,silver],[1,3,dog,silver],[1,4,rabbit,silver],[1,5,horse,silver],[1,6,dog,silver],[1,7,cat,silver],[2,7,rabbit,gold],[6,0,cat,gold],[6,1,horse,gold],[6,2,camel,gold],[6,3,elephant,gold],[6,4,rabbit,gold],[6,5,dog,gold],[6,6,rabbit,gold],[7,0,rabbit,gold],[7,1,rabbit,gold],[7,2,rabbit,gold],[7,3,cat,gold],[7,4,dog,gold],[7,5,rabbit,gold],[7,6,horse,gold],[7,7,rabbit,gold]]).

% default call
get_moves([[[1,0],[2,0]],[[0,0],[1,0]],[[0,1],[0,0]],[[0,0],[0,1]]], Gamestate, Board).
