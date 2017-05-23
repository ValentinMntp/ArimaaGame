% :- module(bot,
%       [  get_moves/3
%       ]).

:- include('externalTools.pl').
:- include('internalTools.pl').
:- include('print.pl').
:- include('initialization.pl').






startGame :- writeMultSep(3,40), write("Hi human !"), nl,
 write("This is Arimaa game, and you're about to play against me. Please set your board first."),
 positioningPhase([[(0, s2),(0, s2),(0, s2),(0, s2),(0, s2),(0, s2),(rS, s2),(0, s2)],
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
  enemyColor(PlayerColor, EnnemyColor),
	checkWinningConditions(Brd, EnnemyColor), !.

% otherwise, play round
round(PlayerColor) :-
	board(Brd),
	write(" [Player "), write(PlayerColor), write("]"),
	doRound(Brd, PlayerColor),
	enemyColor(PlayerColor, EnnemyColor),
	round(EnnemyColor).

doRound(Brd, gold) :-
  askMovePlayer(Brd, Move),

doRound(Brd, silver).


askMovePlayer(Brd, Move) :-
  nl, wSep(60), nl,
	repeat,
  write("Choose the piece to move [Answer with format X,Y.]"), nl,
  read(StartPosition), nl,
  write("Choose cell where you want to move it [Answer with format X,Y.]"), nl,
  read(EndPosition), nl,
  validMove(StartPosition, EndPosition),
  Move = [StartPosition, EndPosition].

moveAskedPossible(Cstart,Cend) :-

	\+element([Cstart, Cend], PossibleMoves), !,
	writeln("Movement is forbidden."),
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
