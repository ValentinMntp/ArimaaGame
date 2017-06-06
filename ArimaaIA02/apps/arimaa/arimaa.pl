
:- include('externalTools.pl').
:- include('internalTools.pl').
:- include('print.pl').
:- include('initialization.pl').
:- include('engine.pl').



startGame :- writeMultSep(3,40), write("Hi human !"), nl,
 write("This is Arimaa game, and you're about to play a game. Please set your board first."),
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
	write(" [Player "), write(PlayerColor), write("]"),
	doRound(Brd, PlayerColor, 4),
	ennemyColor(PlayerColor, EnnemyColor),
	round(EnnemyColor).

doRound(_,_, 0) :- !.
doRound(Brd, gold, K) :-
  nl, write(K), write(" moves remaining."), nl,
  possibleMoves(K, Brd, gold, PossibleMoves),
  askMovePlayer(PossibleMoves, Move),
  updateBrd(Brd, Move, BrdRes),
  setBrd(BrdRes),
  showBrd(BrdRes),
  computeDist(Move, Dist),
  K2 is K - Dist,
  doRound(BrdRes, gold, K2).

doRound(Brd, silver, K) :-
  nl, write(K), write(" moves remaining."), nl,
  possibleMoves(K, Brd, silver, PossibleMoves),
  askMovePlayer(PossibleMoves, Move),
  updateBrd(Brd, Move, BrdRes),
  setBrd(BrdRes),
  showBrd(BrdRes),
  computeDist(Move, Dist),
  K2 is K - Dist,
  doRound(BrdRes, silver, K2).



askMovePlayer(PossibleMoves, Move) :-
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
