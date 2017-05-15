:- module(bot,
      [  get_moves/3
      ]).

:- include('externalTools.pl').
:- include('internalTools.pl').

% PrintBoard
initialBoard([
             [(0, s2),(0, s2),(0, s2),(0, s2),(0, s2),(0, s2),(0, s2),(0, s2)],
             [(0, s1),(0, s1),(0, s1),(0, s1),(0, s1),(0, s1),(0, s1),(0, s1)],
             [(0, e),(0, e),(2, t),(0, e),(0, e),(0, t),(0, e),(0, e)],
             [(0, e),(0, e),(0, e),(0, e),(0, e),(0, e),(0, e),(0, e)],
             [(0, e),(0, e),(0, e),(0, e),(0, e),(0, e),(0, e),(0, e)],
             [(0, e),(0, e),(0, t),(0, e),(0, e),(0, t),(0, e),(0, e)],
             [(0, g1),(0, g1),(0, g1),(0, g1),(0, g1),(0, g1),(0, g1),(0, g1)],
             [(0, g2),(0, g2),(0, g2),(0, g2),(0, g2),(0, g2),(0, g2),(0, g2)]
            ]).

% Write a separator on N cases
wSep(0) :- !.
wSep(N) :- write("_"), Tmp is N-1, wSep(Tmp).

% Write a separator with new line
% K is number of lines
% N is numbers of cases separator
multipleWSep(0,_) :- !.
multipleWSep(K, N) :- wSep(N), nl, SK is K - 1, multipleWSep(SK, N).
% write a tabulation (2 espaces)
wTab :- write("  ").


/*On vérifie si les pions sont placés du bon côté */
checkInitPlacement(Board, silver,(X,Y)) :-
  Y > 0, Y < 9, X > 0, X < 3.
  % cell(Board, X, Y, (cellType, e)). TO BE DONE
checkInitPlacement(Board, silver,_):-
  nl, multipleWSep(2, 60),
	nl, writeln("Coordonnees invalides, elles doivent etre comprises entre (1,1) et (2,8)"), fail.
checkInitPlacement(Board, gold, (X,Y)) :-
  Y > 0, Y < 9, X > 6, X < 9.
  %cell(Board, X, Y, (cellType, e)). TO BE DONE
checkInitPlacement(Board, gold,_):-
  nl, multipleWSep(2, 60),
	nl, writeln("Coordonnees invalides, elles doivent etre comprises entre (7,1) et (8,8)"), fail.


  /*
	cell(X,Y, Board, Res)
	------------------------------
	Unifie Res avec le tuple présent dans le plateau
	aux coordonnées (X,Y)
*/
cell(X, Y, Board, Res) :-
	rowFromBrd(X, Board, RowRes),
	cellFromRow(Y, RowRes, Res).
rowFromBrd(1, [X|_], X) :- !.
rowFromBrd(R,[_|Q], Res) :- R2 is R-1, rowFromBrd(R2, Q, Res).
cellFromRow(1, [X|_], X) :- !.
cellFromRow(R, [_|Q], Res) :- R2 is R-1, cellFromRow(R2, Q, Res).



% get_moves signature
% get_moves(Moves, gamestate, board).

% Exemple of variable
% gamestate: [side, [captured pieces] ] (e.g. [silver, [ [0,1,rabbit,silver],[0,2,horse,silver] ])
% board: [[0,0,rabbit,silver],[0,1,rabbit,silver],[0,2,horse,silver],[0,3,rabbit,silver],[0,4,elephant,silver],[0,5,rabbit,silver],[0,6,rabbit,silver],[0,7,rabbit,silver],[1,0,camel,silver],[1,1,cat,silver],[1,2,rabbit,silver],[1,3,dog,silver],[1,4,rabbit,silver],[1,5,horse,silver],[1,6,dog,silver],[1,7,cat,silver],[2,7,rabbit,gold],[6,0,cat,gold],[6,1,horse,gold],[6,2,camel,gold],[6,3,elephant,gold],[6,4,rabbit,gold],[6,5,dog,gold],[6,6,rabbit,gold],[7,0,rabbit,gold],[7,1,rabbit,gold],[7,2,rabbit,gold],[7,3,cat,gold],[7,4,dog,gold],[7,5,rabbit,gold],[7,6,horse,gold],[7,7,rabbit,gold]]

% Call exemple:
% get_moves(Moves, [silver, []], [[0,0,rabbit,silver],[0,1,rabbit,silver],[0,2,horse,silver],[0,3,rabbit,silver],[0,4,elephant,silver],[0,5,rabbit,silver],[0,6,rabbit,silver],[0,7,rabbit,silver],[1,0,camel,silver],[1,1,cat,silver],[1,2,rabbit,silver],[1,3,dog,silver],[1,4,rabbit,silver],[1,5,horse,silver],[1,6,dog,silver],[1,7,cat,silver],[2,7,rabbit,gold],[6,0,cat,gold],[6,1,horse,gold],[6,2,camel,gold],[6,3,elephant,gold],[6,4,rabbit,gold],[6,5,dog,gold],[6,6,rabbit,gold],[7,0,rabbit,gold],[7,1,rabbit,gold],[7,2,rabbit,gold],[7,3,cat,gold],[7,4,dog,gold],[7,5,rabbit,gold],[7,6,horse,gold],[7,7,rabbit,gold]]).

% default call
get_moves([[[1,0],[2,0]],[[0,0],[1,0]],[[0,1],[0,0]],[[0,0],[0,1]]], Gamestate, Board).
