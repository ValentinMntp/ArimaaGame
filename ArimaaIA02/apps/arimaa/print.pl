/*
  	=================================
  	print.pl
  	=================================
  	Ce fichier contient les différents prédicats
  	qui sont utilisés pour afficher en console.
  	-------------------------------
*/


/*
  writeSep(N)
  ------------------------------
  display N separators
*/
writeSep(0) :- !.
writeSep(N) :- write("-"), Tmp is N-1, writeSep(Tmp).

/*
  writeMultSep(K,N)
  ------------------------------
  Display N separators on K lines
*/
writeMultSep(0,_) :- !.
writeMultSep(K, N) :- writeSep(N), nl, SK is K - 1, writeMultSep(SK, N).
/*
  wTab
  ------------------------------
  Display tabulation (two spaces)
*/
wTab :- write(" ").


/*
	============================================================
	============================================================
  Board Display
	============================================================
	============================================================
*/

/*
	showCurrentBrd
	------------------------------
	Display actual board content
*/
% showCurrentBrd :- board(Brd), showColumns, showBrd(Brd).

/*
	showBrd
	------------------------------
	Display board content
*/
showBrd(Brd) :- showColumns, showRows(1, Brd).

/*
	showColumns
	------------------------------
	Display column headers
*/
showColumns :-
  nl, wTab, wTab, writeSubColumnLoop(1), nl,
	wTab, wTab, writeSep(41), nl.

% writeSubColumn / writeSubColumnLoop
writeSubColumnLoop(N) :- N < 9, writeSubColumn(N), Nb is N+1, writeSubColumnLoop(Nb), !.
writeSubColumnLoop(_).
writeSubColumn(N) :- wTab, wTab, write(N), write("  ").


/*
	showRows(N, Row)
	------------------------------
	Display Nth row content
*/
showRows(_, []) :- !.
showRows(NumLigne, [T|Q]) :-
	N is NumLigne + 1,
	write(NumLigne), write(" |"),  showCellsContent(T, NumLigne, 1), nl,
	writeSubRow, showRows(N, Q).

% writeSubRow / writeSubRowLoop
%"Sous"-prédicats pour boucler et faciliter l'écriture de showRows
writeSubRow :- wTab, write(" +"), writeSubRowLoop(1).
writeSubRowLoop(N) :- N<9, write("----+"), Nb is N+1, writeSubRowLoop(Nb), !.
writeSubRowLoop(_) :- nl.


/*
	showCellsContent(Row, LineNumber, ColomnNumber)
	------------------------------
	Display content of Nth cell of a row
*/
showCellsContent([],_,_) :- !.
showCellsContent([Cell|Q],I, J) :-
	writeCellContent(Cell),
	SubJ is J + 1, showCellsContent(Q, I, SubJ), !.

% -- Print cell content
writeCellContent((0,t)) :- write("  T |"), !.
writeCellContent((X,t)) :- write(" "), write(X), write("T|"), !.
writeCellContent((0,_)) :- write("    |"), !.
writeCellContent((X,_)) :- write(" "), write(X), write(" |"), !.
