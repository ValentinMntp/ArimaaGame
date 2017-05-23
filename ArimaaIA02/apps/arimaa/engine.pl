/*
  	=================================
  	engine.pl
  	=================================
    This file contains predicates used to make a move
  	-------------------------------
*/


/*
  getNeighboursPieces((X,Y), Brd, L)
  ------------------------------
	Unifies L with pieces that are next to (X,Y).
*/
getNeighboursPieces((X,Y),Brd,Res) :-
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

getNeighboursPieces((X,Y),Brd,Res) :-
	X = 1, Y > 1, Y < 8,
	cell((X+1, Y), Brd, (PieceBasse, _)),
	concat([PieceBasse],[], SubSubRes),
	cell((X,Y+1), Brd, (PieceDroite, _)),
	concat([PieceDroite],SubSubRes,SubRes),
	Ybis is Y-1,
	cell((X,Ybis), Brd, (PieceGauche, _)),
	concat([PieceGauche],SubRes,ResNoClean),
	retire_elements(0,ResNoClean, Res), !.

getNeighboursPieces((X,Y),Brd,Res) :-
	X > 1, X < 8, Y = 1,
	cell((X+1, Y), Brd, (PieceBasse, _)),
	concat([PieceBasse],[], SubSubRes),
	Xbis is X-1,
	cell((Xbis, Y), Brd, (PieceHaute, _)),
	concat([PieceHaute],SubSubRes,SubRes),
	cell((X,Y+1), Brd, (PieceDroite, _)),
	concat([PieceDroite],SubRes,ResNoClean),
	retire_elements(0,ResNoClean, Res), !.

getNeighboursPieces((X,Y),Brd,Res) :-
	X > 1, X < 8, Y = 8,
	cell((X+1, Y), Brd, (PieceBasse, _)),
	concat([PieceBasse],[], SubSubRes),
	Xbis is X-1,
	cell((Xbis, Y), Brd, (PieceHaute, _)),
	concat([PieceHaute],SubSubRes,SubRes),
	cell((X,Ybis), Brd, (PieceGauche, _)),
	concat([PieceGauche],SubRes,ResNoClean),
	retire_elements(0,ResNoClean, Res), !.

getNeighboursPieces((X,Y),Brd,Res) :-
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

getNeighboursPieces((1,1),Brd,Res) :-
	cell((2, 1), Brd, (PieceBasse, _)),
	concat([PieceBasse],[], SubRes),
	cell((1,2), Brd, (PieceDroite, _)),
	concat([PieceDroite],SubRes,ResNoClean),
	retire_elements(0,ResNoClean, Res), !.

getNeighboursPieces((1,8),Brd,Res) :-
	cell((2,8), Brd, (PieceBasse, _)),
	concat([PieceBasse],[], SubRes),
	cell((1,7), Brd, (PieceGauche, _)),
	concat([PieceGauche],SubRes,ResNoClean),
	retire_elements(0,ResNoClean, Res), !.

getNeighboursPieces((8,1),Brd,Res) :-
	cell((7, 1), Brd, (PieceHaute, _)),
	concat([PieceHaute],[], SubRes),
	cell((8, 2), Brd, (PieceDroite, _)),
	concat([PieceDroite],SubRes,ResNoClean),
	retire_elements(0,ResNoClean, Res), !.

getNeighboursPieces((8,8),Brd,Res) :-
	cell((7,8), Brd, (PieceHaute, _)),
	concat([PieceHaute],[], SubRes),
	cell((8,7), Brd, (PieceGauche, _)),
	concat([PieceGauche],SubRes,ResNoClean),
	retire_elements(0,ResNoClean, Res), !.



  /*
    getNeighboursCells((X,Y), Brd, L)
    ------------------------------
  	Unifies L with pieces that are next to (X,Y).
  */

getNeighboursCells((1,1),Res) :-
	Res = [(2,1),(1,2)], !.

getNeighboursCells((1,8),Res) :-
  Res = [(1,7),(2,8)], !.

getNeighboursCells((8,1),Res) :-
  Res = [(7,1),(8,2)], !.

getNeighboursCells((8,8),Res) :-
  Res = [(8,7),(7,8)], !.

getNeighboursCells((X,Y),Res) :-
	X > 1, X < 8, Y > 1, Y < 8,
  Xhaut is X-1, Xbas is X+1, Ygauche is Y-1, Ydroite is Y+1,
	Res = [(Xhaut,Y), (Xbas,Y), (X, Ygauche), (X,Ydroite)], !.

getNeighboursCells((X,Y),Res) :-
	X = 1, Y > 1, Y < 8,
  Xbas is X+1, Ygauche is Y-1, Ydroite is Y+1,
  Res = [(Xbas,Y), (X, Ygauche), (X,Ydroite)], !.

getNeighboursCells((X,Y),Res) :-
	Y = 1, X > 1, X < 8,
  Xhaut is X-1, Xbas is X+1, Ydroite is Y+1,
	Res = [(Xhaut,Y), (Xbas,Y), (X,Ydroite)], !.

getNeighboursCells((X,Y),Res) :-
	Y = 8, X > 1, X < 8,
  Xhaut is X-1, Xbas is X+1, Ygauche is Y-1,
	Res = [(Xhaut,Y), (Xbas,Y), (X, Ygauche)], !.

getNeighboursCells((X,Y),Res) :-
	X = 8, Y > 1, Y < 8,
  Xhaut is X-1, Ygauche is Y-1, Ydroite is Y+1,
	Res = [(Xhaut,Y), (X, Ygauche), (X,Ydroite)], !.
