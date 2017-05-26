% :- module(bot,
%       [  get_moves/3
%       ]).

:- include('externalTools.pl').
:- include('internalTools.pl').
:- include('print.pl').
:- include('initialization.pl').
:- include('engine.pl').



startGame :- writeMultSep(3,40), write("Hi human !"), nl,
 write("This is Arimaa game, and you're about to play against me. Please set your board first."),
 positioningPhase([[(0, s2),(0, s2),(0, s2),(0, s2),(0, s2),(0, s2),(0, s2),(0, s2)],
  [(0, s1),(0, s1),(0, s1),(0, s1),(0, s1),(0, s1),(0, s1),(0, s1)],
  [(0, e),(0, e),(0 , t),(0, e),(0, e),(0, t),(0, e),(0, e)],
  [(0, e),(0, e),(0, e),(0, e),(0, e),(0, e),(0, e),(0, e)],
  [(0, e),(0, e),(0, e),(0, e),(0, e),(0, e),(0, e),(0, e)],
  [(0, e),(0, e),(0, t),(0, e),(0, e),(0, t),(0, e),(0, e)],
  [(0, g1),(0, g1),(0, g1),(0, g1),(0, g1),(0, g1),(0, g1),(0, g1)],
  [(0, g2),(0, g2),(0, g2),(0, g2),(0, g2),(0, g2),(0, g2),(0, g2)]], ResBrd),
	setBrd(ResBrd),
	round(gold).


% Check if ennemy won
round(PlayerColor) :-
  ennemyColor(PlayerColor, EnnemyColor),
  board(Brd),
	checkWinningConditions(Brd, EnnemyColor), !.

% otherwise, play round
round(PlayerColor) :-
	board(Brd),
  showBrd(Brd),
	write(" [Player "), write(PlayerColor), write("]"),
	doRound(Brd, PlayerColor, 4),
	ennemyColor(PlayerColor, EnnemyColor),
	round(EnnemyColor).

doRound(Brd, gold, 0) :- !.
doRound(Brd, gold, K) :-
  nl, write(K), write(" moves remaining."), nl,
  possibleMoves(K, Brd, gold, PossibleMoves),
  askMovePlayer(Brd,gold, PossibleMoves, Move),
  updateBrd(Brd, Move, BrdRes),
  setBrd(BrdRes),
  showBrd(BrdRes),
  computeDist(Move, Dist),
  K2 is K - Dist,
  doRound(BrdRes, gold, K2).

doRound(Brd, silver, K) :-
  possibleMoves(K, Brd, silver, PossibleMoves),
  askMovePlayer(Brd, silver, PossibleMoves, Move),
  updateBrd(Brd, Move, BrdRes),
  setBrd(BrdRes),
  doRound(Brd, silver, K2).



askMovePlayer(Brd, PlayerSide, PossibleMoves, Move) :-
  nl, writeSep(60), nl,
	repeat,
  write("Choose the piece to move [Answer with format X,Y.]"), nl,
  read(StartPosition), nl,
  write("Choose cell destination [Answer with format X,Y.]"), nl,
  read(EndPosition), nl,
  moveAskedPossible(StartPosition, EndPosition, PossibleMoves),
	Move = [StartPosition,EndPosition].

moveAskedPossible(StartPosition,EndPosition, PossibleMoves) :-
	\+element([StartPosition, EndPosition], PossibleMoves), !,
	writeln("Forbidden move."),
	fail.
moveAskedPossible(_,_,_).


% get_moves signature
% get_moves(Moves, gamestate, board).

% Exemple of variable
% gamestate: [side, [captured pieces] ] (e.g. [silver, [ [0,1,rabbit,silver],[0,2,horse,silver] ])
% board: [[0,0,rabbit,silver],[0,1,rabbit,silver],[0,2,horse,silver],[0,3,rabbit,silver],[0,4,elephant,silver],[0,5,rabbit,silver],[0,6,rabbit,silver],[0,7,rabbit,silver],[1,0,camel,silver],[1,1,cat,silver],[1,2,rabbit,silver],[1,3,dog,silver],[1,4,rabbit,silver],[1,5,horse,silver],[1,6,dog,silver],[1,7,cat,silver],[2,7,rabbit,gold],[6,0,cat,gold],[6,1,horse,gold],[6,2,camel,gold],[6,3,elephant,gold],[6,4,rabbit,gold],[6,5,dog,gold],[6,6,rabbit,gold],[7,0,rabbit,gold],[7,1,rabbit,gold],[7,2,rabbit,gold],[7,3,cat,gold],[7,4,dog,gold],[7,5,rabbit,gold],[7,6,horse,gold],[7,7,rabbit,gold]]

% Call exemple:
% get_moves(Moves, [silver, []], [[0,0,rabbit,silver],[0,1,rabbit,silver],[0,2,horse,silver],[0,3,rabbit,silver],[0,4,elephant,silver],[0,5,rabbit,silver],[0,6,rabbit,silver],[0,7,rabbit,silver],[1,0,camel,silver],[1,1,cat,silver],[1,2,rabbit,silver],[1,3,dog,silver],[1,4,rabbit,silver],[1,5,horse,silver],[1,6,dog,silver],[1,7,cat,silver],[2,7,rabbit,gold],[6,0,cat,gold],[6,1,horse,gold],[6,2,camel,gold],[6,3,elephant,gold],[6,4,rabbit,gold],[6,5,dog,gold],[6,6,rabbit,gold],[7,0,rabbit,gold],[7,1,rabbit,gold],[7,2,rabbit,gold],[7,3,cat,gold],[7,4,dog,gold],[7,5,rabbit,gold],[7,6,horse,gold],[7,7,rabbit,gold]]).

% default call
%get_moves([[[1,0],[2,0]],[[0,0],[1,0]],[[0,1],[0,0]],[[0,0],[0,1]]], Gamestate, Board).
