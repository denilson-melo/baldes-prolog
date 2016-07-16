:-abolish(counter/1).
:-dynamic(existe/2).
:-dynamic(destino/2).

pertence(A, B, [[A, B] | _]).
pertence(A, B, [_ | L]):- pertence(A, B, L).

passa_a_b(A, B, A2, B2):- A+B < 4, A2 is 0, B2 is A+B.
passa_a_b(A, B, A2, B2):- A+B >= 4, B2 is 4, A2 is A+B - 4.
passa_b_a(A, B, A2, B2):- A+B < 3, B2 is 0, A2 is A+B.
passa_b_a(A, B, A2, B2):- A+B >= 3, A2 is 3, B2 is A+B - 3.

concatena([X], LISTA, [X | LISTA]).
concatena([X | LISTA1], LISTA2, [X | LISTA3]):- concatena(LISTA1, LISTA2, LISTA3).

caminho(A, B, X, CAMINHO):- destino(A,B), concatena([[A,B]], X, CAMINHO) .
caminho(A, B, AD, BD, X, CAMINHO):- assertz(destino(AD,BD)), concatena([[A, B]], X, C1), filhos(A, B, A2, B2, C1, CAMINHO).
caminho(A, B, X, CAMINHO):- \+ existe(A,B), assertz(existe(A,B)), concatena([[A, B]], X, C1), filhos(A, B, A2, B2, C1, CAMINHO).

diferentes(A, B, A2, B2):- A =\= A2, !; B =\= B2, !.
filhos(A, B, A2, B2, X, CAMINHO):- A2 is 3, B2 is B, diferentes(A, B, A2, B2), caminho(A2, B2, X, CAMINHO).
filhos(A, B, A2, B2, X, CAMINHO):- A2 is A, B2 is 4, diferentes(A, B, A2, B2), caminho(A2, B2, X, CAMINHO).
filhos(A, B, A2, B2, X, CAMINHO):- A2 is 0, B2 is B, diferentes(A, B, A2, B2), caminho(A2, B2, X, CAMINHO).
filhos(A, B, A2, B2, X, CAMINHO):- A2 is A, B2 is 0, diferentes(A, B, A2, B2), caminho(A2, B2, X, CAMINHO).
filhos(A, B, A2, B2, X, CAMINHO):- passa_a_b(A, B, A2, B2), diferentes(A, B, A2, B2), caminho(A2, B2, X, CAMINHO).
filhos(A, B, A2, B2, X, CAMINHO):- passa_b_a(A, B, A2, B2), diferentes(A, B, A2, B2), caminho(A2, B2, X, CAMINHO).
