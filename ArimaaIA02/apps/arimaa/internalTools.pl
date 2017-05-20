/*
  	=================================
  	internaltools.pl
  	=================================
    This file contains predicates used as utility tools in
    this project. There are specific to this project.
  	-------------------------------
*/



  /*
  	stronger(X,Y)
  	------------------------------
  	Check if X is stronger than Y
  */

beat(elephant, camel).
beat(camel, horse).
beat(horse, dog).
beat(dog, cat).
beat(cat, rabbit).
stronger(X,Y) :- beat(X,Y).
stronger(X,Y) :- beat(X,Z), stronger(Z,Y).



  /*
  	enemyColor(X,Y)
  	------------------------------
  	Given X, give the enemy color Y.
  */
enemyColor(gold, silver).
enemyColor(silver, gold).

/*
	pieceToColor(PieceType, PlayerSide)
	------------------------------
	Given a PieceType, give the playerSide silver or gold
*/
pieceToColor(eS, silver).
pieceToColor(cS, silver).
pieceToColor(hS, silver).
pieceToColor(dS, silver).
pieceToColor(kS, silver).
pieceToColor(rS, silver).
pieceToColor(eG, gold).
pieceToColor(cG, gold).
pieceToColor(hG, gold).
pieceToColor(dG, gold).
pieceToColor(kG, gold).
pieceToColor(rG, gold).

/*
	pieceDenomination(PlayerSide, PieceCategory, PieceType)
	------------------------------
	Giver PlayerSide and PieceCategory, give the PieceType for printing on board.
*/
pieceDenomination(silver, elephant, eS).
pieceDenomination(silver, camel, cS).
pieceDenomination(silver, horse, hS).
pieceDenomination(silver, dog, dS).
pieceDenomination(silver, cat, kS).
pieceDenomination(silver, rabbit, rS).
pieceDenomination(gold, elephant, eG).
pieceDenomination(gold, camel, cG).
pieceDenomination(gold, horse, hG).
pieceDenomination(gold, dog, dG).
pieceDenomination(gold, cat, kG).
pieceDenomination(gold, rabbit, rG).


/*
	checkValidPosition(Brd, PlayerSide, C)
	------------------------------
  Check if positions given by user are allowed.
  A position is invalid if cell is already taken or if positions
  don't match with the 2 rows of player side.
*/

% --------- SILVER side case
checkValidPosition(Brd, silver, (X,Y)) :-
	X >=1, X =< 2, Y >= 1, Y =< 8,
	cell((X, Y), Brd, (0,_)), !.

% cell is not empty
checkValidPosition(_, silver, (X,Y)) :-
	X >= 1, X =< 2, Y >= 1, Y =< 8, !, fail.

% --------- GOLD side case
checkValidPosition(Brd, gold, (X, Y)) :-
	X >= 7, X =< 8, Y >= 1, Y =< 8,
	cell((X, Y), Brd, (0,_)), !.

% Cas où la cellule n'est pas vide
checkValidPosition(_, gold, (X, Y)) :-
	X >= 7, X =< 8, Y >= 1, Y =< 8,
	nl, writeMultSep(2, 60),
	nl, write("Cell is already taken !"), !, fail.

% Cas où les coordonnées ne sont pas valides.
checkValidPosition(_, gold,_) :-
	nl, writeMultSep(2, 60),
	nl, writeln("Invalid positions, must be between (7,1) and (8,8)"), fail.


/* checkWinLoseConditions(Brd)
    ------------------------------
    Check if there is a Winner after a round
    The order of checking for win/lose conditions is as follows assuming Silver just made the move and Gold now needs to move:

    Check if a rabbit of Silver reached goal. If so Silver wins.
    Check if a rabbit of Gold reached goal. If so Gold wins.
    Check if Silver lost all rabbits. If so Gold wins.
    Check if Gold lost all rabbits. If so Silver wins.
    Check if Gold has no possible move (all pieces are frozen or have no place to move). If so Silver wins.
    Check if the only moves Gold has are 3rd time repetitions. If so Silver wins.    /// -> see later \\\
*/

% --------- Gold just made the move
checkWinningConditions(Brd, gold) :-
    checkSilverInGoldSide(Brd),
    checkGoldInSilverSide(Brd),
    checkGoldRabbits,
    checkSilverRabbits,
    checkSilverMove.

% --------- Silver just made the move
checkWinningConditions(Brd, silver) :-
    checkSilverInGoldSide(Brd),
    checkGoldInSilverSide(Brd),
    checkGoldRabbits,
    checkSilverRabbits,
    checkGoldMove.

%  Check if a rabbit of Silver reached goal. If so Silver wins.

checkSilverInGoldSide(Brd) :-
    brdToRow(8, Brd, Row),
    element((rS,g2), Row),
    nl, writeMultSep(2, 60),
    nl, writeln("Silver is the winner").


%  Check if a rabbit of Gold reached goal. If so Gold wins.

checkGoldInSilverSide(Brd):-
    brdToRow(1, Brd, Row),
    element((rG,s2), Row),
    nl, writeMultSep(2, 60),
    nl, writeln("Gold is the winner").



/*
  cell(X,Y, Brd, Res)
  ------------------------------
  Unifies Res with tuple on position (X,Y)
*/
cell((X,Y), Brd, Res) :-
	brdToRow(X, Brd, RowRes),
	rowToCell(Y, RowRes, Res).
brdToRow(1, [X|_], X) :- !.
brdToRow(R,[_|Q], Res) :- R2 is R-1, brdToRow(R2, Q, Res).
rowToCell(1, [X|_], X) :- !.
rowToCell(R, [_|Q], Res) :- R2 is R-1, rowToCell(R2, Q, Res).

/*
  cellType(X,Y, Brd, Res)
  ------------------------------
  Unifies Res with the cell Type on position (X,Y)
*/
cellType((X,Y), Brd, Res) :-
	brdToRow(X, Brd, RowRes),
	rowToCellType(Y, RowRes, Res).
rowToCellType(1, [(X,Y)|_], Y) :- !.
rowToCellType(R, [_|Q], Res) :- R2 is R-1, rowToCellType(R2, Q, Res).




setCell([X|Q], Cell, (1,J), [SubRes|Q]) :-
	setRowCell(X, Cell, J, SubRes), !.
setCell([T|Q], Cell, (I,J), [T|SubRes]) :-
	SubI is I - 1,
	setCell(Q, Cell, (SubI, J), SubRes), !.

setRowCell([_|Q], Cell, 1, [Cell|Q]) :- !.
setRowCell([T|Q], Cell, J, [T|SubRow]) :-
	SubJ is J - 1,
	setRowCell(Q, Cell, SubJ, SubRow), !.
