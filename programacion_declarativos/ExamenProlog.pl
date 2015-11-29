%1) Predicado "cuñado(X,Y)."% Y es la esposa del hermano de X?
hermanos(juan,paco).
hermanos(juan,perla).
hermanos(paco,perla).
esposos(paco,samanta).
esposos(perla,carlos).
esposos(juan,alexia).

cuñado(X,Y):- hermanos(X,A), esposos(A,Y),!.
cuñado(X,Y):- hermanos(A,X), esposos(A,Y),!.


%2) Predicado "borrar(L,X,R)."
%?-borrar(a,[a,b,c,d,a,b],R).

borrar(_,[],[]):-!.
borrar(X,[X|T],R):- borrar(X,T,R),!.
borrar(X,[H|T],[H|Resto]):- borrar(X,T,Resto),!.

%3) Predicado "sustituye(L,X,Y,R)."
%?-sustituye([1,2,3,4,2],2,b,R).
%R=[1,b,3,4,b]

sustituye([],_,_,[]):-!.
sustituye([X|T],X,Y,[Y|Resto]):- sustituye(T,X,Y,Resto),!.
sustituye([H|T],X,Y,[H|Resto]):- sustituye(T,X,Y,Resto),!.

%5) Predicado "incElem(L,N)."
%?-incElem([1,2,3],R).
%R=[2,3,4].

incElem([],[]).
incElem([H|T],[Z|R]):- Z is H+1,incElem(T,R).

%6) Predicado "multiVec(V1,V2,R)."
%?-multiVec([1,2,3],[2,3,2],R).
%R=[2,6,6].

multiVec([],[],[]).
multiVec([H0|T0],[H1|T1],[Z|R]):- Z is H0*H1,
	multiVec(T0,T1,R).

%7) Predicado "primerosXelem(L,R)."
%?-primerosXelem([2,5,7,1,4],R).
%R=[2,5].

primXelem(_,0,[]):-!.
primXelem([H|T],X,[H|R]):- Z is X-1, primXelem(T,Z,R).

%8) Predicado "ultimosXelem(L,R)."
%?-ultimosXelem([2,5,7,1,4],2,R).
%R=[1,4].

ultimosXelem(L,N,R):- longitud(L,K), M is K-N,
	ultXelem(L,M,R).

longitud(L,R):-long(L,R,0).

long([],R,R):-!.
long([_|T],R,N):- M is N+1, long(T,R,M),!.

ultXelem([],0,[]):-!.
ultXelem([_|T],N,R):- N>0, M is N-1,
	ultXelem(T,M,R),!.
ultXelem([H|T],_,[H|R]):- ultXelem(T,0,R),!.

%9) Predicado "reversa(L,R)."
%?-reversa([1,2,3,4],R).
%R=[4,3,2,1].

%reversa([],[]).
%reversa([H|T],[R|H]):-reversa(T,R).

reversa1([],[]).
reversa1([H|T],R):-reversa1(T,R),
	Resto is R+0, R is [H|Resto].
%reversa1([H|_],[H|_],1).
%



%11) Predicado "mismoConjunto(L1,L2)."
%?-mismoConjunto([a,b,c],[a,c,b,b,a]).
%true

mismoConjunto(L1,L2):- mc1(L1,L2),mc1(L2,L1).

mc1([],_):-!.
mc1([H1|T1],L):- estaEn(H1,L), mc1(T1,L).

%mc2(_,[]).
%mc2(L,[H1|T1]):- estaEn(H1,L), mc2(L,T1).

estaEn(X,[X|_]):-!.
estaEn(X,[_|T]):-estaEn(X,T).

%12) Predicado "sublista(L1,L2)."
%?-sublista([1,a,2,b,3,c],[2,b,3]).
%true
%?-sublista([1,a,2,b,3,c],[b,3,2]).
%false

sublista(_,[]):-!.
sublista([X|T1],[X|T2]):-sublista(T1,T2),!.
sublista([_|T1],L):- sublista(T1,L).
