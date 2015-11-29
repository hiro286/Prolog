%       Clae 10 de Noviembre de 2014


writeList([]):- nl.
writeList([H|T]):- write(H), tab(1), writeList(T).


escribeMiNombre(X):- write([mi,nombre,es,X]),nl.

%imprimeLista([hola,que,haces]).
%?.- hola
%    que
%    haces

%hello:- writeList([what,,is,your,name]),

%suma(2,R).
%R=3    2+1
%suma(3,R).
%R=6    3+2+1
% *********** NO FUNCIONA (AUN) *************
suma(1,1).
suma(X,R):- X1 is X-1, suma(X1,Z),R is X + Z.


%mayor(2,3,R).
%R=3
mayor(X,Y,Y):- X<Y,!.
mayor(X,Y,X):- X>Y.
