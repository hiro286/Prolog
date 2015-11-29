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

%LX = Lista X
%Mov = Movimiento
%R = Resultado
%LM = Last Move
%NM = New Move


buscar(L1,[L1|_],1):-!.
buscar(L1,[_|H],R):- buscar(L1,H,R),!.
buscar(_,_,0):-!.

concatenar([],L1,L1).
concatenar([H|C],L2,[H|R]):-concatenar(C,L2,R).


%[1,2,3,4,0,6,7,5,8]
%[1,2,3,4,5,0,7,8,6]
%[1,2,0,4,5,3,7,8,6]

%*****   Busqueda por aplitud   ******

%puzzle([[[1,2,3,4,0,6,7,5,8]|[]]],'inicio',R).
puzzle([[[1,2,3,4,5,6,7,8,0]|Ruta]|_],_,Ruta1):-
	transRuta(Ruta,Ruta1),!.
% ([[EdoActual|Mov]|Frontera],Explorados,Resultado).
puzzle([[H|M]|B],Exp,R):-
	%nl,write('Nodo Actual:'),write(H),write(M),nl,
%Agrega el nodo actual a Explorados
	concatenar(H,Exp,Exp1),% write(Exp1),nl,
%Crea a los hijos del nodo actual
	findall([Es|Mov],mover(H,Es,Mov),Z),
%Excluye de los nuevos nodos los que ya han sido explorados
	eexp(Exp1,Z,Z1),% nl,write(Z1),
%A cada nodo se le concatena la ruta que lleva
	addRuta(Z1,M,Z2),
%A la frontera se le Concatena los nuevos nodos por explorar
	concatenar(B,Z2,F),%Amplitud
	%concatenar(Z1,B,F),%Profundidad
	%write('Frontera:'),nl,printFront(F),nl,nl,
	puzzle(F,Exp1,R).


%Traduce Ruta de Caracteres a palabras
% [<,<] = [izquierda, izquierda]
% (caracter, palabra)
transRuta([],[]).
transRuta([H|T],[H1|T1]):-
	mv(H,H1),
	transRuta(T,T1).

% addRuta([[[2,0,3,1,4,6,7,5,8]|[>]],[[1,2,3,0,4,6,7,5,8]|[v]]],[v],R).
% R = [[[2, 0, 3, 1, 4, 6, 7|...], [v, >]], [[1, 2, 3, 0, 4, 6|...], [v, v]]].
%(Findall,Mov,Ruta,Resultado)
addRuta([],_,[]):-!.
% ([[Estado|Move]|RestoFindAll],Movimeintos, Resultado)
addRuta([[Edo|M]|Rfa],Mvs,[[Edo|Ruta]|Res]):-
	concatenar(Mvs,M,Ruta),
	addRuta(Rfa,Mvs,Res).


%Excluir Explorados
%eexp(Exp,FindAll,Res).
eexp(_,[],[]):-!.
%Si NO esta en explorados
eexp(Exp,[[H|M]|B],[[H|M]|R]):- buscar(H,Exp,N),N is 0,eexp(Exp,B,R),!.
%Sí SI esta en explorados
eexp(Exp,[_|B],[R]):- eexp(Exp,B,R).


% printFront([[[1,2,3,4,6,0,7,5,8]|derecha],[[1,2,3,0,4,6,7,5,8]|izquierda],[[1,2,3,4,5,6,7,0,8]|abajo],[[1,0,3,4,2,6,7,5,8]|arriba]]).
printFront([]):-!.
% ([[[Tablero]|Movimiento]|Resto])
printFront([[[P1,P2,P3,P4,P5,P6,P7,P8,P9]|Mov]|B]):-nl,
	write(P1),write(P2),write(P3),write('   '),
	transRuta(Mov,M),write(M),nl,
	write(P4),write(P5),write(P6),nl,
	write(P7),write(P8),write(P9),nl,
	printFront(B).




%%%%%%   Agrega Movimientos Validos
%E1=Estado 1
%M=Movimiento realizado
%Es=Estados generados (findall)
%R=Resultado.
%addvm(E1,M,ES,R).

%findall(X,mover([1,2,3,4,0,6,7,5,8],X,_),Z).
% Z = [[1, 2, 3, 4, 6, 0, 7, 5|...],
%      [1, 2, 3, 0, 4, 6, 7|...],
%      [1, 2, 3, 4, 5, 6|...],
%      [1, 0, 2, 3, 2|...]].

%Siguiente Movimiento Valido
smv(arriba,arriba).
smv(arriba,derecha).
smv(arriba,izquierda).
%smv(arriba,inicio)
%
smv(abajo,abajo).
smv(abajo,derecha).
smv(abajo,izquierda).
%smv(abajo,inicio).
%
smv(derecha,derecha).
smv(derecha,arriba).
smv(derecha,abajo).
%smv(derecha,inicio).
%
smv(izquierda,izquierda).
smv(izquierda,arriba).
smv(izquierda,abajo).
%smv(izquierda,inicio).





