%Diccionarios
%Movimeitos Validos

%%%%Derecha
%Primer Renglon
mover([0,L1,L2,L3,L4,L5,L6,L7,L8],[L1,0,L2,L3,L4,L5,L6,L7,L8],[>]).
mover([L1,0,L2,L3,L4,L5,L6,L7,L8],[L1,L2,0,L3,L4,L5,L6,L7,L8],[>]).
%Segundo Renglon
mover([L1,L2,L3,0,L4,L5,L6,L7,L8],[L1,L2,L3,L4,0,L5,L6,L7,L8],[>]).
mover([L1,L2,L3,L4,0,L5,L6,L7,L8],[L1,L2,L3,L4,L5,0,L6,L7,L8],[>]).
%Tercer Renglon
mover([L1,L2,L3,L4,L5,L6,0,L7,L8],[L1,L2,L3,L4,L5,L6,L7,0,L8],[>]).
mover([L1,L2,L3,L4,L5,L6,L7,0,L8],[L1,L2,L3,L4,L5,L6,L7,L8,0],[>]).

%%%%Izquierda
%Primer Renglon
mover([L1,L2,0,L3,L4,L5,L6,L7,L8],[L1,0,L2,L3,L4,L5,L6,L7,L8],[<]).
mover([L1,0,L2,L3,L4,L5,L6,L7,L8],[0,L1,L2,L3,L4,L5,L6,L7,L8],[<]).
%Segundo Renglon
mover([L1,L2,L3,L4,L5,0,L6,L7,L8],[L1,L2,L3,L4,0,L5,L6,L7,L8],[<]).
mover([L1,L2,L3,L4,0,L5,L6,L7,L8],[L1,L2,L3,0,L4,L5,L6,L7,L8],[<]).
%Tercer Renglon
mover([L1,L2,L3,L4,L5,L6,L7,L8,0],[L1,L2,L3,L4,L5,L6,L7,0,L8],[<]).
mover([L1,L2,L3,L4,L5,L6,L7,0,L8],[L1,L2,L3,L4,L5,L6,0,L7,L8],[<]).

%%%%Abajo
%Primer Renglon
mover([0,L1,L2,L3,L4,L5,L6,L7,L8],[L3,L1,L2,0,L4,L5,L6,L7,L8],[v]).
mover([L1,0,L2,L3,L4,L5,L6,L7,L8],[L1,L4,L2,L3,0,L5,L6,L7,L8],[v]).
mover([L1,L2,0,L3,L4,L5,L6,L7,L8],[L1,L2,L5,L3,L4,0,L6,L7,L8],[v]).
%Segundo Renglon
mover([L1,L2,L3,0,L4,L5,L6,L7,L8],[L1,L2,L3,L6,L4,L5,0,L7,L8],[v]).
mover([L1,L2,L3,L4,0,L5,L6,L7,L8],[L1,L2,L3,L4,L7,L5,L6,0,L8],[v]).
mover([L1,L2,L3,L4,L5,0,L6,L7,L8],[L1,L2,L3,L4,L5,L8,L6,L7,0],[v]).

%%%%Arriba
%Segundo Renglon
mover([L1,L2,L3,0,L4,L5,L6,L7,L8],[0,L2,L3,L1,L4,L5,L6,L7,L8],[^]).
mover([L1,L2,L3,L4,0,L5,L6,L7,L8],[L1,0,L3,L4,L2,L5,L6,L7,L8],[^]).
mover([L1,L2,L3,L4,L5,0,L6,L7,L8],[L1,L2,0,L4,L5,L3,L6,L7,L8],[^]).
%Tercer Renglon
mover([L1,L2,L3,L4,L5,L6,0,L7,L8],[L1,L2,L3,0,L5,L6,L4,L7,L8],[^]).
mover([L1,L2,L3,L4,L5,L6,L7,0,L8],[L1,L2,L3,L4,0,L6,L7,L5,L8],[^]).
mover([L1,L2,L3,L4,L5,L6,L7,L8,0],[L1,L2,L3,L4,L5,0,L7,L8,L6],[^]).

mv(<,izquierda).
mv(>,derecha).
mv(^,arriba).
mv(v,abajo).
mv(f,falla).
mv(e,exito).


%Concatenar (L1,L2,[L1,L2]).
concatenar([],L1,L1):-!.
concatenar([H|C],L2,[H|R]):-concatenar(C,L2,R).

%puzPL([[1,2,3,4,5,6,7,8,0]|[]],5,R,F).

%Traduce Ruta de Caracteres a palabras
% [<,<] = [izquierda, izquierda]
% (caracter, palabra)
transRuta([],[]).
transRuta([H|T],[H1|T1]):-
	mv(H,H1),
	transRuta(T,T1).


% printFront([[[1,2,3,4,6,0,7,5,8]|derecha],[[1,2,3,0,4,6,7,5,8]|izquierda],[[1,2,3,4,5,6,7,0,8]|abajo],[[1,0,3,4,2,6,7,5,8]|arriba]]).
%
printFront([]):-!.
% ([[[Tablero]|Movimiento]|Resto])
printFront([[[P1,P2,P3,P4,P5,P6,P7,P8,P9]|Mov]|B]):-nl,
	write(P1),write(P2),write(P3),write('   '),
	transRuta(Mov,M),write(M),nl,
	write(P4),write(P5),write(P6),nl,
	write(P7),write(P8),write(P9),nl,
	printFront(B).


%puzPL([[1,2,3,4,5,0,7,8,6]|[]],3,Ruta,E).
%
%puzPL([Edo|Mov],Lvl,Ruta,Exito/Falla).
puzPL([[1,2,3,4,5,6,7,8,0]|M],_,R,1):-
	concatenar(M,[e],R),!.
puzPL([H|M],N,R,F):-
%Comprovar que N>0, y decrementar N
	N > 0, N1 is N-1,
	%nl,write('   Nodo Actual:'),write('    Mov:  '),
	%write('Nodo Siguiente:'),nl,
%Calcula el siguinte moviminto.
	mover(H,Nx,Nm),
	%write(H),write(Nm),write(Nx),nl,
	concatenar(M,Nm,Ms),
	puzPL([Nx|Ms],N1,R,F).
puzPL([_|M],_,R,0):-
	concatenar(M,[f],R),!.

%*********************************************************
%*********************************************************

puzzleBPLI(T,N):-
	puzzlePL(T,N,R),
	printFront(R).
puzzleBPLI(T,N):-
	N1 is  N +1,
	write('Pasando al nivel: '),write(N1),nl,
	puzzleBPLI(T,N1).

correctTable([1,2,3,4,5,6,7,8,0]).

%Predicado inicial para llamar al programa:
puzzle(Table, Nivel):-
	write('Tablero inicial'), nl,
	write(Nivel),nl,
	%printTable(Table),
	printFront([[Table|[] ] | [] ]),
%Llamado al predicado que resuelve el problema.
	puzzlePL(Table, Nivel,Ruta),
	print(Ruta).
%Predicados que resuelven el problema y es recursivo.
%Parámetros( TableroActual, Nivel, RutaDeMovs).

%Caso base.
puzzlePL(TableroActual,_, Ruta):-
%Preguntamos si el tablero es la meta.
	correctTable(TableroActual),
	write('Solucion encontrada!'),nl,
	transRuta(Ruta,RutaF), write(RutaF).
%puzzlePLI(_,0,_):-
	%write('Limite alcanzado!').
%Caso recursivo.
puzzlePL(TableroActual,Nivel, Ruta):- Nivel>0,
	%hacerMovimiento(TableroActual, TableroResultante, MovRealizado),
	mover(TableroActual, TableroResultante, MovRealizado),
	%write('Nodo siguiente:'),nl,
	%write('Nivel ='), write(Nivel),nl,
	%printTable(TableroResultante),
	%printFront([[TableroResultante| MovRealizado ] | [] ]),
	NewNivel is Nivel-1,
	concatenar(Ruta, MovRealizado, NewRuta),
	puzzlePL(TableroResultante, NewNivel, NewRuta).


%*********************************************************
%*********************************************************



%fa_pPL([[1,2,3,4,5,6,0,7,8]|[]],2).
% [[>,>,e]|1]
% [[>,<,f]|0]
% [[>,^,f]|0]
% [[>,f]|0]
% [[^,>,f]|0]
% [[^,v,f]|0]
% [[^,^,f]|0]
% [[^,f]|0]
% [[f]|0]
% true.

fa_pPL(Edo,Lv):-findall([Ruta|E_F],puzPL(Edo,Lv,Ruta,E_F),Z),
	print_fa_pPL(Z).

print_fa_pPL([]).
print_fa_pPL([H|T]):-
	write(H),nl,
	print_fa_pPL(T).

% fa([1,2,3,4,5,6,7,8,0]).
% 123   [izquierda]
% 456
% 708  ...
fa(H):-findall([Es|Mov],mover(H,Es,Mov),Z),
	printFront(Z).



%Profundidad limitada iterativa
pli0(A,R):-pli(A,1,R,0),!.
%pli([Edo|Mov],Nivel,Ruta,1/0).
pli(_,Lvl,R,1):-
	LvlF is Lvl-1,nl,
	write('Solucion encontrada en nivel: '),
	write(LvlF),nl,
	write('Con ruta(R): '),
	write(R),!.
pli(_,100,_,_):-
	write('Se ha llegado al nivel 100!'),!.
pli(Atom,Lvl,R,_):-
	puzPL(Atom,Lvl,R,F),
	NLvl is Lvl +1,
	pli(Atom,NLvl,R,F).








