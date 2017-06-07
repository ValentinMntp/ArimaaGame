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
	concat([PieceGauche],SubRes,Res), !.

getNeighboursPieces((X,Y),Brd,Res) :-
	X = 1, Y > 1, Y < 8,
	cell((X+1, Y), Brd, (PieceBasse, _)),
	concat([PieceBasse],[], SubSubRes),
	cell((X,Y+1), Brd, (PieceDroite, _)),
	concat([PieceDroite],SubSubRes,SubRes),
	Ybis is Y-1,
	cell((X,Ybis), Brd, (PieceGauche, _)),
	concat([PieceGauche],SubRes,Res), !.

getNeighboursPieces((X,Y),Brd,Res) :-
	X > 1, X < 8, Y = 1,
	cell((X+1, Y), Brd, (PieceBasse, _)),
	concat([PieceBasse],[], SubSubRes),
	Xbis is X-1,
	cell((Xbis, Y), Brd, (PieceHaute, _)),
	concat([PieceHaute],SubSubRes,SubRes),
	cell((X,Y+1), Brd, (PieceDroite, _)),
	concat([PieceDroite],SubRes,Res), !.

getNeighboursPieces((X,Y),Brd,Res) :-
	X > 1, X < 8, Y = 8,
	cell((X+1, Y), Brd, (PieceBasse, _)),
	concat([PieceBasse],[], SubSubRes),
	Xbis is X-1,
	cell((Xbis, Y), Brd, (PieceHaute, _)),
	concat([PieceHaute],SubSubRes,SubRes),
	Ybis is Y-1,
	cell((X,Ybis), Brd, (PieceGauche, _)),
	concat([PieceGauche],SubRes,Res), !.

getNeighboursPieces((X,Y),Brd,Res) :-
	X = 8, Y > 1, Y < 8,
	Xbis is X-1,
	cell((Xbis, Y), Brd, (PieceHaute, _)),
	concat([PieceHaute],[],SubSubRes),
	cell((X,Y+1), Brd, (PieceDroite, _)),
	concat([PieceDroite],SubSubRes,SubRes),
	Ybis is Y-1,
	cell((X,Ybis), Brd, (PieceGauche, _)),
	concat([PieceGauche],SubRes,Res), !.

getNeighboursPieces((1,1),Brd,Res) :-
	cell((2, 1), Brd, (PieceBasse, _)),
	concat([PieceBasse],[], SubRes),
	cell((1,2), Brd, (PieceDroite, _)),
	concat([PieceDroite],SubRes,Res), !.

getNeighboursPieces((1,8),Brd,Res) :-
	cell((2,8), Brd, (PieceBasse, _)),
	concat([PieceBasse],[], SubRes),
	cell((1,7), Brd, (PieceGauche, _)),
	concat([PieceGauche],SubRes,Res), !.

getNeighboursPieces((8,1),Brd,Res) :-
	cell((7, 1), Brd, (PieceHaute, _)),
	concat([PieceHaute],[], SubRes),
	cell((8, 2), Brd, (PieceDroite, _)),
	concat([PieceDroite],SubRes,Res), !.

getNeighboursPieces((8,8),Brd,Res) :-
	cell((7,8), Brd, (PieceHaute, _)),
	concat([PieceHaute],[], SubRes),
	cell((8,7), Brd, (PieceGauche, _)),
	concat([PieceGauche],SubRes,Res), !.


/*
  getNeighboursCells((X,Y),Res),
  ------------------------------
	Unifies Res with cell that are next to (X,Y).
*/

getNeighboursCells((X,Y),Res) :-
	X > 1, X < 8, Y > 1, Y < 8,
	Bas is X+1,
	concat([(Bas, Y)],[], SubSubSubRes),
	Haut is X-1,
	concat([(Haut, Y)],SubSubSubRes,SubSubRes),
	Droite is Y+1,
	concat([(X,Droite)],SubSubRes,SubRes),
	Gauche is Y-1,
	concat([(X,Gauche)],SubRes,Res),!.

getNeighboursCells((X,Y),Res) :-
	X = 1, Y > 1, Y < 8,
	Bas is X+1,
	concat([(Bas, Y)],[], SubSubRes),
	Droite is Y+1,
	concat([(X,Droite)], SubSubRes,SubRes),
	Gauche is Y-1,
	concat([(X,Gauche)],SubRes,Res),!.

getNeighboursCells((X,Y),Res) :-
	X > 1, X < 8, Y = 1,
	Bas is X+1,
	concat([(Bas, Y)],[], SubSubRes),
	Haut is X-1,
	concat([(Haut, Y)],SubSubRes,SubRes),
	Droite is Y+1,
	concat([(X,Droite)],SubRes,Res),!.

getNeighboursCells((X,Y),Res) :-
	X > 1, X < 8, Y = 8,
	Bas is X+1,
	concat([(Bas, Y)],[], SubSubRes),
	Haut is X-1,
	concat([(Haut, Y)],SubSubRes,SubRes),
	Gauche is Y-1,
	concat([(X,Gauche)],SubRes,Res),!.

getNeighboursCells((X,Y),Res) :-
	X = 8, Y > 1, Y < 8,
	Haut is X-1,
	concat([(Haut, Y)],[],SubSubRes),
	Droite is Y+1,
	concat([(X,Droite)],SubSubRes,SubRes),
	Gauche is Y-1,
	concat([(X,Gauche)],SubRes,Res),!.

getNeighboursCells((1,1),Res) :-
	concat([(1,2),(2,1)],[],Res),!.

getNeighboursCells((1,8),Res) :-
	concat([(1,7),(2,8)],[],Res),!.

getNeighboursCells((8,1),Res) :-
	concat([(7,1),(8,2)],[],Res),!.

getNeighboursCells((8,8),Res) :-
	concat([(7,8),(8,7)],[],Res),!.



/*
	nextTo(C, PosX, PosY, Brd, Boolean)
	------------------------------
	Unifies a C couple with (PosX, PosY) neighbour positions.
	Check if neighbour cell is empty if bool is true.

*/
  nextTo((Xstart, Ystart), Brd, (Xres,Yres), true) :-
  	Xres is Xstart - 1, Yres is Ystart,
  		Xres>0, Yres>0, Xres<9, Yres<9,
  		cell((Xres, Yres), Brd, (0,_));
  	Xres is Xstart, Yres is Ystart - 1,
  		 Xres>0, Yres>0, Xres<9, Yres<9,
  		 cell((Xres, Yres), Brd, (0,_));
  	Xres is Xstart + 1, Yres is Ystart,
  		Xres>0, Yres>0, Xres<9, Yres<9,
  		cell((Xres, Yres), Brd, (0,_));
  	Xres is Xstart, Yres is Ystart + 1,
  		Xres>0, Yres>0, Xres<9, Yres<9,
  		cell((Xres, Yres), Brd, (0,_)).

  nextTo((Xstart, Ystart),_,(Xres,Yres), false) :-
  	Xres is Xstart - 1, Yres is Ystart,
  		Xres>0, Yres>0, Xres<9, Yres<9;
  	Xres is Xstart, Yres is Ystart - 1,
  		Xres>0, Yres>0, Xres<9, Yres<9;
  	Xres is Xstart + 1, Yres is Ystart,
  		Xres>0, Yres>0, Xres<9, Yres<9;
  	Xres is Xstart, Yres is Ystart + 1,
  		Xres>0, Yres>0, Xres<9, Yres<9.

  /*
  neighbourPositions(Brd,(X,Y), Moves, CheckEmpty)
  	------------------------------
  	Unifies Moves with various neighbour positions reachable by (X,Y) position.
  */
  neighbourPositions(Brd, (X,Y), Moves, CheckEmpty) :-
  	findall(C, nextTo((X,Y),Brd,C, CheckEmpty), Moves).

  neighbourPositions(Brd, (X,Y), Moves, CheckEmpty, History, NewHistory) :-
    findall(C, nextTo((X,Y),Brd,C, CheckEmpty), SubMoves),
    difference(SubMoves, History, Moves),
    concat(History, Moves, NewHistory).

/*
	possibleMoves(K,Brd, PlayerSide, PossibleMoves)
	------------------------------
	Unifies PossibleMoves with the list of possible moves which can be made by the PlayerSide player.
	K is the number of move you still have to play.

	Move take this form :
		[(Xstart, Ystart), (Xend, Yend) ]
*/
possibleMoves(K, Brd, PlayerSide, PossibleMoves) :-
	bPossibleMoves(K, Brd, Brd, PlayerSide, (1,1), PossibleMoves), PossibleMoves \= [], !.

bPossibleMoves(_,_,[],_,_,[]) :- !.
bPossibleMoves(K,Brd, [RowX|RowRest], PlayerSide, (X,Y), PossibleMoves) :-
	SubX is X+1,
	subPossibleMoves(K,Brd, RowX, PlayerSide, (X,Y), SubRes1),
	bPossibleMoves(K,Brd, RowRest, PlayerSide, (SubX,Y), SubRes2),
	concat(SubRes1, SubRes2, PossibleMoves).

subPossibleMoves(_,_,[],_,_,[]) :- !.
% If the piece is a PlayerSide color, explore its possible moves
subPossibleMoves(K,Brd, [(PieceType,_)|CellRest], PlayerSide, (X,Y), PossibleMoves) :-
	pieceToColor(PieceType, PlayerSide),
	\+isFrozen((X,Y),Brd),
	movesFrom(K,Brd, (X,Y), PossibleMovesFirst),
	SubY is Y + 1,
	subPossibleMoves(K, Brd, CellRest, PlayerSide, (X,SubY), PossibleMovesRest),
	concat(PossibleMovesFirst, PossibleMovesRest, PossibleMoves).

% If the piece isn't a PlayerSide color, next cell.
subPossibleMoves(K, Brd,[_|CellRest],PlayerSide,(X,Y), Res) :-
	SubY is Y + 1,
	subPossibleMoves(K, Brd, CellRest, PlayerSide, (X, SubY), Res), !.



neighbourPositionsFromList(_, [],[], _,History,History) :- !.
neighbourPositionsFromList(Brd, [CoupleTete|QueueCouples], MovesTotaux, CheckEmpty, History, FinalHistory) :-
	neighbourPositions(Brd, CoupleTete, MovesCouple, CheckEmpty, History, NewHistory),
	neighbourPositionsFromList(Brd, QueueCouples, MovesQueues, CheckEmpty, NewHistory, FinalHistory),
	concat(MovesCouple, MovesQueues, MovesTotaux).

/*
	movesFrom(K, Brd, C, MovesFrom)
*/
movesFrom(0,_,_,_) :- !.

movesFrom(K, Brd, (X,Y), MovesFrom) :-
	positionsFrom(K, Brd, (X,Y), PositionsFrom),
	subMovesFrom((X,Y), PositionsFrom, MovesFrom1),
	K2 is K-1,
	movesFrom(K2, Brd,(X,Y), MovesFrom2),
	concat(MovesFrom1, MovesFrom2, MovesFrom3),
	deleteDoublons(MovesFrom3, MovesFrom).

subMovesFrom(_,[],[]) :- !.
subMovesFrom((X,Y), [Pos|RestPos], [[(X,Y), Pos]|RestMoves]) :-
	subMovesFrom((X,Y), RestPos, RestMoves).

/*
	positionsFrom(K, Brd, Couple, Res)
	------------------------------
	Unifies Res with reachable position from Couple positon with exactly K moves.
*/
positionsFrom(1, Brd, (X,Y), Res) :-
	neighbourPositions(Brd, (X,Y), SubSubRes, false, [(X,Y)], _),
	friendPiecesFilter((X,Y), Brd, SubSubRes, SubRes), ennemyPiecesFilter((X,Y), Brd, SubRes, Res), !.
positionsFrom(K, Brd, (X,Y), Res) :-
	K2 is K-1,
	subPositionsFrom(K2, Brd, (X,Y), MovesOne, [(X,Y)], NewHistory),
	neighbourPositionsFromList(Brd, MovesOne, MovesTwo, false, NewHistory,_),
	friendPiecesFilter((X,Y), Brd, MovesTwo, SubRes), ennemyPiecesFilter((X,Y), Brd, SubRes, Res).

subPositionsFrom(1, Brd, (X,Y), Res, History, NewHistory) :-
	neighbourPositions(Brd, (X,Y), Res, true, History, NewHistory), !.
subPositionsFrom(K, Brd, (X,Y), Res, History, FinalHistory) :-
	K2 is K-1,
	subPositionsFrom(K2, Brd, (X,Y), MovesOne, History, SubHistory),
	neighbourPositionsFromList(Brd, MovesOne, Res, true, SubHistory, FinalHistory), !.


/*
	friendPiecesFilter((X,Y), Brd, SubRes, Res)
*/
friendPiecesFilter((X,Y), Brd, SubRes, Res) :-
	cell((X,Y), Brd, (PieceType,_)), PieceType = eG, !,
	subFriendPiecesFilter(Brd, SubRes, gold, Res);
	cell((X,Y), Brd, (PieceType,_)), PieceType = cG, !,
	subFriendPiecesFilter(Brd, SubRes, gold, Res);
	cell((X,Y), Brd, (PieceType,_)), PieceType = hG, !,
	subFriendPiecesFilter(Brd, SubRes, gold, Res);
	cell((X,Y), Brd, (PieceType,_)), PieceType = dG, !,
	subFriendPiecesFilter(Brd, SubRes, gold, Res);
	cell((X,Y), Brd, (PieceType,_)), PieceType = kG, !,
	subFriendPiecesFilter(Brd, SubRes, gold, Res);
	cell((X,Y), Brd, (PieceType,_)), PieceType = rG, !,
	subFriendPiecesFilter(Brd, SubRes, gold, Res);
	cell((X,Y), Brd, (PieceType, _)), PieceType = eS, !,
	subFriendPiecesFilter(Brd, SubRes, silver, Res);
	cell((X,Y), Brd, (PieceType, _)), PieceType = cS, !,
	subFriendPiecesFilter(Brd, SubRes, silver, Res);
	cell((X,Y), Brd, (PieceType, _)), PieceType = hS, !,
	subFriendPiecesFilter(Brd, SubRes, silver, Res);
	cell((X,Y), Brd, (PieceType, _)), PieceType = dS, !,
	subFriendPiecesFilter(Brd, SubRes, silver, Res);
	cell((X,Y), Brd, (PieceType, _)), PieceType = kS, !,
	subFriendPiecesFilter(Brd, SubRes, silver, Res);
	cell((X,Y), Brd, (PieceType,_)), PieceType = rS,
	subFriendPiecesFilter(Brd, SubRes, silver, Res).

subFriendPiecesFilter(_,[], _, []) :- !.
subFriendPiecesFilter(Brd, [(X,Y)|RestPos], gold, Res) :-
	cell((X,Y), Brd, (Type,_)), Type = eG,
	subFriendPiecesFilter(Brd, RestPos, gold, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = cG,
	subFriendPiecesFilter(Brd, RestPos, gold, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = hG,
	subFriendPiecesFilter(Brd, RestPos, gold, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = dG,
	subFriendPiecesFilter(Brd, RestPos, gold, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = kG,
	subFriendPiecesFilter(Brd, RestPos, gold, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = rG,
	subFriendPiecesFilter(Brd, RestPos, gold, Res), !.
subFriendPiecesFilter(Brd, [(X,Y)|RestPos], silver, Res) :-
	cell((X,Y), Brd, (Type,_)), Type = eS,
	subFriendPiecesFilter(Brd, RestPos, silver, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = cS,
	subFriendPiecesFilter(Brd, RestPos, silver, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = hS,
	subFriendPiecesFilter(Brd, RestPos, silver, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = dS,
	subFriendPiecesFilter(Brd, RestPos, silver, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = kS,
	subFriendPiecesFilter(Brd, RestPos, silver, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = rS,
	subFriendPiecesFilter(Brd, RestPos, silver, Res), !.
subFriendPiecesFilter(Brd, [(X,Y)|RestPos], PlayerType, [(X,Y)|Res]) :-
	subFriendPiecesFilter(Brd, RestPos, PlayerType, Res).

/*
	ennemyPiecesFilter((X,Y), Brd, SubRes, Res)
*/
ennemyPiecesFilter( (X,Y), Brd, SubRes, Res) :-
	cell((X,Y), Brd, (PieceType,_)), PieceType = eG, !,
	subEnnemyPiecesFilter( Brd, SubRes, gold, Res);
	cell((X,Y), Brd, (PieceType,_)), PieceType = cG, !,
	subEnnemyPiecesFilter( Brd, SubRes, gold, Res);
	cell((X,Y), Brd, (PieceType,_)), PieceType = hG, !,
	subEnnemyPiecesFilter( Brd, SubRes, gold, Res);
	cell((X,Y), Brd, (PieceType,_)), PieceType = dG, !,
	subEnnemyPiecesFilter( Brd, SubRes, gold, Res);
	cell((X,Y), Brd, (PieceType,_)), PieceType = kG, !,
	subEnnemyPiecesFilter( Brd, SubRes, gold, Res);
	cell((X,Y), Brd, (PieceType,_)), PieceType = rG, !,
	subEnnemyPiecesFilter( Brd, SubRes, gold, Res);
	cell((X,Y), Brd, (PieceType, _)), PieceType = eS, !,
	subEnnemyPiecesFilter( Brd, SubRes, silver, Res);
	cell((X,Y), Brd, (PieceType, _)), PieceType = cS, !,
	subEnnemyPiecesFilter( Brd, SubRes, silver, Res);
	cell((X,Y), Brd, (PieceType, _)), PieceType = hS, !,
	subEnnemyPiecesFilter( Brd, SubRes, silver, Res);
	cell((X,Y), Brd, (PieceType, _)), PieceType = dS, !,
	subEnnemyPiecesFilter( Brd, SubRes, silver, Res);
	cell((X,Y), Brd, (PieceType, _)), PieceType = kS, !,
	subEnnemyPiecesFilter( Brd, SubRes, silver, Res);
	cell((X,Y), Brd, (PieceType,_)), PieceType = rS,
	subEnnemyPiecesFilter( Brd, SubRes, silver, Res).


subEnnemyPiecesFilter(_, [], _, []) :- !.

subEnnemyPiecesFilter(Brd, [(X,Y)|RestPos], gold, Res) :-
	cell((X,Y), Brd, (Type,_)), Type = eS, \+canBePush((X,Y), Brd),
	subEnnemyPiecesFilter(Brd, RestPos, gold, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = cS, \+canBePush((X,Y), Brd),
	subEnnemyPiecesFilter( Brd, RestPos, gold, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = hS, \+canBePush((X,Y), Brd),
	subEnnemyPiecesFilter( Brd, RestPos, gold, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = dS, \+canBePush((X,Y), Brd),
	subEnnemyPiecesFilter( Brd, RestPos, gold, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = kS, \+canBePush((X,Y), Brd),
	subEnnemyPiecesFilter( Brd, RestPos, gold, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = rS, \+canBePush((X,Y), Brd),
	subEnnemyPiecesFilter( Brd, RestPos, gold, Res), !.
subEnnemyPiecesFilter( Brd, [(X,Y)|RestPos], silver, Res) :-
	cell((X,Y), Brd, (Type,_)), Type = eG, \+canBePush((X,Y), Brd),
	subEnnemyPiecesFilter( Brd, RestPos, silver, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = cG, \+canBePush((X,Y), Brd),
	subEnnemyPiecesFilter( Brd, RestPos, silver, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = hG, \+canBePush((X,Y), Brd),
	subEnnemyPiecesFilter( Brd, RestPos, silver, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = dG, \+canBePush((X,Y), Brd),
	subEnnemyPiecesFilter( Brd, RestPos, silver, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = kG, \+canBePush((X,Y), Brd),
	subEnnemyPiecesFilter( Brd, RestPos, silver, Res), !;
	cell((X,Y), Brd, (Type,_)), Type = rG, \+canBePush((X,Y), Brd),
	subEnnemyPiecesFilter( Brd, RestPos, silver, Res), !.
subEnnemyPiecesFilter( Brd, [(X,Y)|RestPos], PlayerType, [(X,Y)|Res]) :-
	subEnnemyPiecesFilter( Brd, RestPos, PlayerType, Res).




updateBrd(Brd, [(Xstart, Ystart), (Xend, Yend)], BrdRes) :-
	cell((Xstart, Ystart), Brd, (PieceType, CellType)),
	cell((Xend, Yend), Brd, (0,CellType2)),
	setCell(Brd, (0, CellType), (Xstart, Ystart), SubBrd),
	setCell(SubBrd, (PieceType, CellType2), (Xend, Yend), SubBrdRes),
	toTrap((3,6), SubBrdRes, BrdRes).

updateBrd(Brd, [(Xstart, Ystart), (Xend, Yend)], BrdRes) :-
	cell((Xstart, Ystart), Brd, (PieceType, CellType)),
	cell((Xend, Yend), Brd, (0,CellType2)),
	setCell(Brd, (0, CellType), (Xstart, Ystart), SubBrd),
	setCell(SubBrd, (PieceType, CellType2), (Xend, Yend), SubBrdRes),
	toTrap((3,3), SubBrdRes, BrdRes).

updateBrd(Brd, [(Xstart, Ystart), (Xend, Yend)], BrdRes) :-
	cell((Xstart, Ystart), Brd, (PieceType, CellType)),
	cell((Xend, Yend), Brd, (0,CellType2)),
	setCell(Brd, (0, CellType), (Xstart, Ystart), SubBrd),
	setCell(SubBrd, (PieceType, CellType2), (Xend, Yend), SubBrdRes),
	toTrap((6,3), SubBrdRes, BrdRes).

updateBrd(Brd, [(Xstart, Ystart), (Xend, Yend)], BrdRes) :-
	cell((Xstart, Ystart), Brd, (PieceType, CellType)),
	cell((Xend, Yend), Brd, (0,CellType2)),
	setCell(Brd, (0, CellType), (Xstart, Ystart), SubBrd),
	setCell(SubBrd, (PieceType, CellType2), (Xend, Yend), SubBrdRes),
	toTrap((6,6), SubBrdRes, BrdRes).

updateBrd(Brd, [(Xstart, Ystart), (Xend, Yend)], BrdRes) :-
	cell((Xstart, Ystart), Brd, (PieceType, CellType)),
	cell((Xend, Yend), Brd, (0,CellType2)),
	setCell(Brd, (0, CellType), (Xstart, Ystart), SubBrd),
	setCell(SubBrd, (PieceType, CellType2), (Xend, Yend), SubBrdRes),
	toTrap((Xend, Yend), SubBrdRes, BrdRes).

updateBrd(Brd, [(Xstart, Ystart), (Xend, Yend)], BrdRes) :-
	cell((Xstart, Ystart), Brd, (PieceType, CellType)),
	cell((Xend, Yend), Brd, (0,CellType2)),
	setCell(Brd, (0, CellType), (Xstart, Ystart), SubBrd),
	setCell(SubBrd, (PieceType, CellType2), (Xend, Yend), BrdRes).

/* IN CASE THERE IS A PUSH */
% TODO : Fix function below : loop for asking position

% updateBrd(Brd, [(Xstart, Ystart), (Xend, Yend)], BrdRes) :-
% 	cell((Xstart, Ystart), Brd, (PieceType, CellType)),
% 	cell((Xend, Yend), Brd, (PieceType2,CellType2)),
% 	askPush((Xend,Yend), PushPosition),
% 	cell((PushPosition), Brd, (0,CellType3)),
% 	setCell(Brd, (0, CellType), (Xstart, Ystart), SubSubSubBrd),
% 	setCell(SubSubSubBrd, (PieceType2, CellType3), (PushPosition), SubSubBrd),
% 	setCell(SubSubBrd, (PieceType, CellType2), (Xend, Yend), SubBrdRes),
% 	toTrap((PushPosition), SubBrdRes, BrdRes).

updateBrd(Brd, [(Xstart, Ystart), (Xend, Yend)], BrdRes) :-
	cell((Xstart, Ystart), Brd, (PieceType, CellType)),
	cell((Xend, Yend), Brd, (PieceType2,CellType2)),
	askPush((Xend,Yend), PushPosition),
	cell((PushPosition), Brd, (0,CellType3)),
	setCell(Brd, (0, CellType), (Xstart, Ystart), SubBrd),
	setCell(SubBrd, (PieceType2, CellType3), (PushPosition), SubSubBrd),
	setCell(SubSubBrd, (PieceType, CellType2), (Xend, Yend), BrdRes).

askPush((Xend,Yend), PushPosition) :-
	repeat,
	write("[IT'S A PUSH !] Choose where to push the piece [Answer with format X,Y.]"), nl,
  read(PushPosition), nl,
	getNeighboursCells((Xend, Yend), L),
	element((PushPosition),L).

computeDist([(W,X),(Y,Z)], Dist) :-
	W =< Y, X =< Z,
	Dist is Y-W+Z-X,!.
computeDist([(W,X),(Y,Z)], Dist) :-
	W >= Y, X >= Z,
	Dist is W-Y+X-Z,!.
computeDist([(W,X),(Y,Z)], Dist) :-
	W =< Y, X >= Z,
	Dist is Y-W+X-Z,!.
computeDist([(W,X),(Y,Z)], Dist) :-
	W >= Y, X =< Z,
	Dist is W-Y+Z-X,!.
