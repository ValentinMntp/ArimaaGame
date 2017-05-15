% ------------------------------------------------------------------
%	@developer : Julie BERTEAUX, UTC Student
%	@developer : Valentin MONTUPET, UTC Student
% ------------------------------------------------------------------

/*
  	=================================
  	internaltools.pl
  	=================================
  	Ce fichier contient les différents prédicats
  	qui sont utilisées de manière utilitaire au projet.
  	Ils sont internes au projet et sa structure de données
  	utiles pour de simples actions
  	(sélection de cellule, etc...)
  	-------------------------------
*/



  /*
  	stronger(X,Y)
  	------------------------------
  	Verifie si X est plus fort que Y.
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
  	Unifie X et Y avec les deux couleurs
  	antagonistes.
  */
enemyColor(gold, silver).
enemyColor(silver, gold).

/*
	typeFromSide(PieceType, PlayerSide)
	------------------------------
	Unifie PlayerSide avec le camp de la pièce
	selon son intitulé de type
*/
typeFromSide(eS, silver).
typeFromSide(caS, silver).
typeFromSide(hS, silver).
typeFromSide(dS, silver).
typeFromSide(chS, silver).
typeFromSide(rS, silver).
typeFromSide(eG, gold).
typeFromSide(caG, gold).
typeFromSide(hG, gold).
typeFromSide(dG, gold).
typeFromSide(chG, gold).
typeFromSide(rG, gold).

/*
	pieceType(PlayerSide, PieceCategory, PieceType)
	------------------------------
	Unifie PieceType pour avec l'intitulé de la pièce
	en prenant en compte son camp (PlayerSide),
	et sa catégorie (PieceCategory)
*/
pieceType(silver, elephant, eS).
pieceType(silver, camel, caS).
pieceType(silver, horse, hS).
pieceType(silver, dog, dS).
pieceType(silver, cat, caS).
pieceType(silver, rabbit, rS).
pieceType(gold, elephant, eG).
pieceType(gold, camel, caG).
pieceType(gold, horse, hG).
pieceType(gold, dog, dG).
pieceType(gold, cat, caG).
pieceType(gold, rabbit, rG).

/*
	pieceFromColor(Piece, Color)
	------------------------------
	Unifie Color avec la couleur de Piece
*/
pieceFromColor(eS, silver).
pieceFromColor(caS, silver).
pieceFromColor(hS, silver).
pieceFromColor(dS, silver).
pieceFromColor(chS, silver).
pieceFromColor(rS, silver).
pieceFromColor(eG, gold).
pieceFromColor(caG, gold).
pieceFromColor(hG, gold).
pieceFromColor(dG, gold).
pieceFromColor(chG, gold).
pieceFromColor(rG, gold).
