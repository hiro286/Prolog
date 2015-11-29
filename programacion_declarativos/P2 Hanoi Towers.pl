%mover(3,izquierda,dereacha,centro).

hanoi(1,X,Y,_) :-
    write('Mueve el dico tope de la torre '),
    write(X),
    write(' hacia la torre '),
    write(Y),
    nl.
hanoi(N,X,Y,Z) :-
    N>1,
    M is N-1,
    hanoi(M,X,Z,Y),
    hanoi(1,X,Y,_),
    hanoi(M,Z,Y,X).



%Mover hacia abajo
mover1([0,X,Y,Z],[Y,X,0,Z]).
mover1([X,0,Y,Z],[X,Z,Y,0]).
%Mover haci arriba
mover2([X,Y,0,Z],[0,Y,X,Z]).
mover2([X,Y,Z,0],[X,0,Z,Y]).
%Mover hacia la derecha
mover3([0,X,Y,Z],[X,0,Y,Z]).
mover3([X,Y,0,Z],[X,Y,Z,0]).
%Mover hacia la izquierda
mover4([X,0,Y,Z],[0,X,Y,Z]).
mover4([X,Y,Z,0],[X,Y,0,Z]).


dosX2([1,2,3,0]):-!.
dosX2(A):-mover1(A,R),
	write(R),nl,dosX2(R).
dosX2(A):-mover3(A,R),
	write(R),nl,dosX2(R).
dosX2(A):-mover2(A,R),
	write(R),nl,dosX2(R).
dosX2(A):-mover4(A,R),
	write(R),nl,dosX2(R).





