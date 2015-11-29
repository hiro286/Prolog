%grafo dirigido
connected(1,2).
connected(3,4).
connected(5,6).
connected(7,8).
connected(9,10).
connected(12,13).
connected(13,14).
connected(15,16).
connected(17,18).
connected(19,20).
connected(4,1).
connected(6,3).
connected(4,7).
connected(6,11).
connected(14,9).
connected(11,15).
connected(16,12).
connected(14,17).
connected(16,19).

%1) Puedo ir de A a B?
conectado(X,X).
conectado(X,Y):- connected(X,Z), conectado(Z,Y).

%2) A que puntos puedo ir a partir de A?
desde(A,[Z|R]):- connected(A,Z), desde(Z,R).
desde(_,[]).

nexos(A,X):- connected(A,X).%, nexos(A,X).
%nexos(_,[]).

%3) Desde que puntos se empieza para terminar en B?
hacia([X|Resto],B):- connected(X,B), hacia(Resto,X).
hacia([],_).
%haciaB(X,B):- connected(X,B).%, haciaB(_,X).
%haciaX(A,[Z|R]):- connected(Z,A), haciaX(Z,R).
%haciaX(_,[]).
