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

distManhMeta(1,0,0). distManhMeta(2,0,1). distManhMeta(3,0,2).
distManhMeta(4,1,0). distManhMeta(5,1,1). distManhMeta(6,1,2).
distManhMeta(7,2,0). distManhMeta(8,2,1). distManhMeta(0,2,2).

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

concatena1([],L1,L1).
concatena1([H|C],L2,[H|R]):-concatena1(C,L2,R).


%sort([[5]],[1,4,8],R).
%R = [1, 4, 5, 8].
% ***Solo se agrega de uno por uno.
%Ordenamiento (L1,L2,R).
sort([],L,L):-!.
sort(A1,[A2|T2],[A2|R]):-
%sort([E1,T1|R1],[[E2,T2|R2]|B2],[[E2,T2|R2]|R]):-
	%E1 > E2,
	euMay(A1,A2),
	sort(A1,T2,R),!.
sort(Atom,L2,R):-
	concatena1([Atom],L2,R1),
	sort([],R1,R),!.

euMay([E1|_],[E2|_]):- E1>E2.



%(NuevaPorAgragar,Vieja,Final)
makeSort([],L,L):-!.
makeSort([H|B],[],[Rf]):-
	makeSort(B,H,Rf),!.
makeSort([Hn|Bn],Old,Rf):-
	sort(Hn,Old,Re),
	makeSort(Bn,Re,Rf).


%[1,2,3,4,0,6,7,5,8]
%[1,2,3,4,5,0,7,8,6]
%[1,2,0,4,5,3,7,8,6]
%[4,1,2,7,0,3,8,5,6]

meta([1,2,3,4,5,6,7,8,0]).

%*****   Busqueda por A*   ******

%puzzleAe([[[],0,[1,2,3,4,0,6,7,5,8],[]]],'inicio',R).
puzzleAe([[_,_,[1,2,3,4,5,6,7,8,0],Ruta]|_],_,Ruta1):-
	transRuta(Ruta,Ruta1),!.
% ([[Euristica,Costo,EdoActual,Mov]|Frontera],Explorados,Resultado).
puzzleAe([[_,Costo,H,M]|B],Exp,R):-
	nl,write('Nodo Actual:'),nl,
	write(Costo),write(H),write(M),nl,
%Agrega el nodo actual a Explorados
	concatenar(H,Exp,Exp1),% write(Exp1),nl,
%Crea a los hijos del nodo actual
	findall([Es,Mov],mover(H,Es,Mov),Z),
%Excluye de los nuevos nodos los que ya han sido explorados

	eexp(Exp1,Z,Z1),% nl,write(Z1),
%A cada nodo se le concatena la ruta que lleva
	addRuta(Z1,M,Z2),%nl,write('Ruta'),write(Z2),nl,
%A la frontera se le Concatena los nuevos nodos por explorar
	addValor(Z2,Costo,Z3),
	makeSort(B,Z3,F),
	%concatenar(B,Z3,F),%Amplitud
	%concatenar(Z1,B,F),%Profundidad
	write('Frontera:'),nl,write(F),nl,nl,
	puzzleAe(F,Exp1,R).


% addValor([[[1,2,3,4,5,0,7,8,6],<,>],[[1,2,3,0,4,5,7,8,6],<,<]],[3],R).
% R = [[[3], [1, 2, 3, 4, 5, 0|...], <, >], [[3], [1, 2, 3, 0, 4|...], <,<]].
% (ListaOrigina,Costo,ListaConValor)
%
addValor([],_,[]).
addValor([[Edo,Ruta]|Residuo],Costo,[[E1,C1,Edo,Ruta]|Resto]):-
	C1 is Costo +1 ,%El costo es el del padre mas 1
%*************************************************************
	%ncd(Edo,[1,2,3,4,5,6,7,8,0],0,E),%# Casillas Fuera de Lugar
	distManh(Edo,0,0,E),%Esutistica: Distancia Manhattan
%*************************************************************
	E1 is E + C1,
	addValor(Residuo,Costo,Resto).
% Costo es el costo del padre, E sera la euristica determinada mas el
% costo


%Distancia Manhattan
%distManh([4,1,2,7,0,3,8,5,6],0,0,R).
%R = 10.
%([Pieza|Resto],Posicion,Contador,Resultado_final)
distManh([],_,C,C).
distManh([H|B],Pos,Cont,Rf):-
	distManhMeta(H,R1,C1),
	R0 is Pos // 3,%Renglon
	C0 is Pos mod 3,%Columna
	Cont1 is Cont  + abs(R0-R1),
	Cont2 is Cont1 + abs(C0-C1),
	Psig is Pos +1,
	distManh(B,Psig,Cont2,Rf).





%ncd([1,2,5,3,1],[4,2,3,5,1],0,R).
%R = 3
%Numero de Casillas Diferentes(L1,L2,Contador,Resultado).
ncd([],[],C,[C]):-!.
%([],[],C,[C]) <- Para que la euristica sea una lista.
ncd([H|T1],[H|T2],C,R):-ncd(T1,T2,C,R),!.
ncd([_|T1],[_|T2],C,R):- C1 is C +1, ncd(T1,T2,C1,R),!.



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
% addRuta([[Edo,M]|Rfa],Mvs,[[Edo,Ruta]|Res]):-
% ********* ^^^^^^^ Asi la ruta esra denro de una lista
%  " | " elimina un '[]' y deja como resto a su contenido.
addRuta([[Edo,M]|Rfa],Mvs,[[Edo,Ruta]|Res]):-
	concatenar(Mvs,M,Ruta),
	addRuta(Rfa,Mvs,Res).


%Excluir Explorados
%eexp(Exp,FindAll,Res).
eexp(_,[],[]):-!.
%Si NO esta en explorados
eexp(Exp,[[H,M]|B],[[H,M]|R]):- buscar(H,Exp,N),N is 0,eexp(Exp,B,R),!.
%Sí SI esta en explorados
eexp(Exp,[_|B],[R]):- eexp(Exp,B,R).


sumInv([],0).
sumInv([H|T],Rf):-
	invercion(H,T,0,C),
	sumInv(T,Re),
	Rf is C + Re.


% invercion(5,[4,6,3,2],0,R).
% R = 3.
%(Elemento,Lista,Contador,Resultado)
invercion(_,[],I,I):-!.
invercion(E,[0|T],C,R):-invercion(E,T,C,R),!.
invercion(E,[H|T],C,R):-
	E>H,
	C1 is C+1,
	invercion(E,T,C1,R),!.
invercion(E,[_|T],C,R):-
	invercion(E,T,C,R),!.


esPar(0):-!.
esPar(N):-
	N1 is N mod 2,
	esPar(N1),!.

% printFront([[[1,2,3,4,6,0,7,5,8]|derecha],[[1,2,3,0,4,6,7,5,8]|izquierda],[[1,2,3,4,5,6,7,0,8]|abajo],[[1,0,3,4,2,6,7,5,8]|arriba]]).
printTableros([]):-!.
% ([[[Tablero]|Movimiento]|Resto])
printTableros([[[P1,P2,P3,P4,P5,P6,P7,P8,P9]|Mov]|B]):-nl,
	write(P1),write(P2),write(P3),write('   '),
	transRuta(Mov,M),write(M),nl,
	write(P4),write(P5),write(P6),nl,
	write(P7),write(P8),write(P9),nl,
	printTableros(B).







