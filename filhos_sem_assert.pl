% Exemplo de execução: 
% caminho(0,0,0,2,[],C).
% os dois primeiros parametros indicam o nó inicial: 0,0.
% os outros dois paramentros indicam o nó destino: 0,2. 
% Os ultimos parametros são para a criação da lista contendo o caminho:
% Onde [] é uma lista vazia que será utilizada para formar o caminho,
% e C irá guardar o caminho final.

:-dynamic(destino/2).

passa_a_b(A, B, A2, B2):- A+B < 4, A2 is 0, B2 is A+B.
passa_a_b(A, B, A2, B2):- A+B >= 4, B2 is 4, A2 is A+B - 4.
passa_b_a(A, B, A2, B2):- A+B < 3, B2 is 0, A2 is A+B.
passa_b_a(A, B, A2, B2):- A+B >= 3, A2 is 3, B2 is A+B - 3.

caminho(A, B, CAMINHO, CAMINHO_FINAL):- destino(A,B), append([[A,B]], CAMINHO, CAMINHO_FINAL) .
caminho(A, B, AD, BD, CAMINHO, CAMINHO_FINAL):- assertz(destino(AD,BD)), append([[A, B]], CAMINHO, C1), filhos(A, B, A2, B2, C1, CAMINHO_FINAL).
caminho(A, B, CAMINHO, CAMINHO_FINAL):- not(member([A,B], CAMINHO)), append([[A, B]], CAMINHO, C1), filhos(A, B, A2, B2, C1, CAMINHO_FINAL).

diferentes(A, B, A2, B2):- A =\= A2, !; B =\= B2, !.
filhos(A, B, A2, B2, CAMINHO, CAMINHO_FINAL):- A2 is 3, B2 is B, diferentes(A, B, A2, B2), caminho(A2, B2, CAMINHO, CAMINHO_FINAL).
filhos(A, B, A2, B2, CAMINHO, CAMINHO_FINAL):- A2 is A, B2 is 4, diferentes(A, B, A2, B2), caminho(A2, B2, CAMINHO, CAMINHO_FINAL).
filhos(A, B, A2, B2, CAMINHO, CAMINHO_FINAL):- A2 is 0, B2 is B, diferentes(A, B, A2, B2), caminho(A2, B2, CAMINHO, CAMINHO_FINAL).
filhos(A, B, A2, B2, CAMINHO, CAMINHO_FINAL):- A2 is A, B2 is 0, diferentes(A, B, A2, B2), caminho(A2, B2, CAMINHO, CAMINHO_FINAL).
filhos(A, B, A2, B2, CAMINHO, CAMINHO_FINAL):- passa_a_b(A, B, A2, B2), diferentes(A, B, A2, B2), caminho(A2, B2, CAMINHO, CAMINHO_FINAL).
filhos(A, B, A2, B2, CAMINHO, CAMINHO_FINAL):- passa_b_a(A, B, A2, B2), diferentes(A, B, A2, B2), caminho(A2, B2, CAMINHO, CAMINHO_FINAL).
