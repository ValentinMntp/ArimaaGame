/*
  	=================================
  	engine.pl
  	=================================
    This file contains predicates used to make a move
  	-------------------------------
*/


/*
  getNeighbours((X,Y), Brd, L)
  ------------------------------
	Unifies L with pieces that are next to (X,Y).
*/
getNeighbours((X,Y),Brd,Res) :-
	X > 1, X < 8, Y > 1, Y < 8,
	cell((X+1, Y), Brd, (PieceBasse, _)),
	concat([PieceBasse],[], SubSubSubRes),
	Xbis is X-1,
	cell((Xbis, Y), Brd, (PieceHaute, _)),
	concat([PieceHaute],SubSubSubRes,SubSubRes),
	cell((X,Y+1), Brd, (PieceDroite, _)),
	concat([PieceDroite],SubSubRes,SubRes),
	Ybis is Y-1,
	cell((X,Ybis), Brd, (PieceGauche, _)),
	concat([PieceGauche],SubRes,ResNoClean),
	retire_elements(0,ResNoClean, Res), !.

getNeighbours((X,Y),Brd,Res) :-
	X = 1, Y > 1, Y < 8,
	cell((X+1, Y), Brd, (PieceBasse, _)),
	concat([PieceBasse],[], SubSubRes),
	cell((X,Y+1), Brd, (PieceDroite, _)),
	concat([PieceDroite],SubSubRes,SubRes),
	Ybis is Y-1,
	cell((X,Ybis), Brd, (PieceGauche, _)),
	concat([PieceGauche],SubRes,ResNoClean),
	retire_elements(0,ResNoClean, Res), !.

getNeighbours((X,Y),Brd,Res) :-
	X > 1, X < 8, Y = 1,
	cell((X+1, Y), Brd, (PieceBasse, _)),
	concat([PieceBasse],[], SubSubRes),
	Xbis is X-1,
	cell((Xbis, Y), Brd, (PieceHaute, _)),
	concat([PieceHaute],SubSubRes,SubRes),
	cell((X,Y+1), Brd, (PieceDroite, _)),
	concat([PieceDroite],SubRes,ResNoClean),
	retire_elements(0,ResNoClean, Res), !.

getNeighbours((X,Y),Brd,Res) :-
	X > 1, X < 8, Y = 8,
	cell((X+1, Y), Brd, (PieceBasse, _)),
	concat([PieceBasse],[], SubSubRes),
	Xbis is X-1,
	cell((Xbis, Y), Brd, (PieceHaute, _)),
	concat([PieceHaute],SubSubRes,SubRes),
	cell((X,Ybis), Brd, (PieceGauche, _)),
	concat([PieceGauche],SubRes,ResNoClean),
	retire_elements(0,ResNoClean, Res), !.

getNeighbours((X,Y),Brd,Res) :-
	X = 8, Y > 1, Y < 8,
	Xbis is X-1,
	cell((Xbis, Y), Brd, (PieceHaute, _)),
	concat([PieceHaute],[],SubSubRes),
	cell((X,Y+1), Brd, (PieceDroite, _)),
	concat([PieceDroite],SubSubRes,SubRes),
	Ybis is Y-1,
	cell((X,Ybis), Brd, (PieceGauche, _)),
	concat([PieceGauche],SubRes,ResNoClean),
	retire_elements(0,ResNoClean, Res), !.

getNeighbours((1,1),Brd,Res) :-
	cell((2, 1), Brd, (PieceBasse, _)),
	concat([PieceBasse],[], SubRes),
	cell((1,2), Brd, (PieceDroite, _)),
	concat([PieceDroite],SubRes,ResNoClean),
	retire_elements(0,ResNoClean, Res), !.

getNeighbours((1,8),Brd,Res) :-

	cell((2,8), Brd, (PieceBasse, _)),
	concat([PieceBasse],[], SubRes),
	cell((1,7), Brd, (PieceGauche, _)),
	concat([PieceGauche],SubRes,ResNoClean),
	retire_elements(0,ResNoClean, Res), !.

getNeighbours((8,1),Brd,Res) :-

	cell((7, 1), Brd, (PieceHaute, _)),
	concat([PieceHaute],[], SubRes),
	cell((8, 2), Brd, (PieceDroite, _)),
	concat([PieceDroite],SubRes,ResNoClean),
	retire_elements(0,ResNoClean, Res), !.

getNeighbours((8,8),Brd,Res) :-

	cell((7,8), Brd, (PieceHaute, _)),
	concat([PieceHaute],[], SubRes),
	cell((8,7), Brd, (PieceGauche, _)),
	concat([PieceGauche],SubRes,ResNoClean),
	retire_elements(0,ResNoClean, Res), !.
