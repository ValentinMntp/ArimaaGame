/*
	=================================
	externaltools.pl
	=================================
	Ce fichier contient les différents prédicats
	qui sont utilisés de manière utilitaire au projet.
	Ils peuvent être indépendants du projet
	-------------------------------
*/


%   ==================================================================
%	Prédicats indépendants du projet
%	==================================================================


/*
  tete(T,L)
  ------------------------------
  unifie la variable T avec la tête de la liste L.
*/
tete(T,[T|_]).

/*
  queue(Q,L)
  ------------------------------
  unifie la variable Q avec la queue de la liste L.
*/
queue(Q,[_|Q]).

/*
  vide(L)
  ------------------------------
  s’efface si la liste L est vide.
*/
vide([]).

/*
	element(X, L)
	------------------------------
	Prédicat qui retourne VRAI si :
	un élément X (argument 1) est présent dans la liste L (argument 2)
*/
element(X, [X|_]) :- !.
element(X, [_|Q]) :- element(X,Q).

/*
	concat(Liste1, Liste2, ListeResultat)
	------------------------------
	Prédicat qui unifie ListeResultat
	avec la concaténation des listes Liste1 et Liste2
*/
concat([], L, L) :- !.
concat(L, [], L) :- !.
concat([T|Q], L2, [T|Res]) :- concat(Q, L2, Res).

/*
    inverse (Liste , ListeInverse)
    ------------------------------
    Prédicat qui unifie ListeInverse
    avec l'inverse de la liste passé en paramètre
*/
inverse([T|Q], Qr) :- inverse(Q, I), concat(I, [T], Qr).
inverse([],[]).


/*
	deleteElement(X, L1, L2)
	------------------------------
	Prédicat qui déplace dans L2 TOUTES les occurences de l'élément X dans L
*/
deleteElement(_, [], []) :- !.
deleteElement(X, [X|Q], Res) :- deleteElement(X, Q, Res), !.
deleteElement(X, [T|Q], [T|Res]) :- deleteElement(X,Q,Res).

/*
	deleteDoublons(L, Res)
	------------------------------
	Prédicat qui insère dans Res la liste L retirée de tous ses doublons
	Res devient donc un 'ensemble'
*/
deleteDoublons([], []) :- !.
deleteDoublons([T|Q], [T|R]) :- deleteElement(T, Q, Res), deleteDoublons(Res, R).

/*
	difference(L1, L2, Res)
	------------------------------
	Prédicat qui retire les éléments de L1 présents dans L2
	et met le résultat filtré dans Res
*/
difference([],_,[]) :- !.
difference([T|Q], L2, [T|Res]) :- \+element(T, L2), difference(Q, L2, Res), !.
difference([_|Q], L2, Res) :- difference(Q, L2, Res), !.

/*
	longueur(L, Res)
	------------------------------
	Prédicat qui unifie Res
	avec la longueur de la liste L
*/
longueur([], 0).
longueur([_|Q], Res) :- longueur(Q, Tmp), Res is Tmp + 1.



max(X,Y,Z) :-
  (  X =< Y
  -> Z = Y
  ;  Z = X
   ).
