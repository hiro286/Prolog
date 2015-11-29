%            8 Reinas por Hill Climbing
%
%Se resntringira el movimiento de las reinas pudiendo
% solo cambiar de columna (no de renglon), iniciando con
% una sola reina por renglon.
%Cada Renglon estara representado como una lista. El tablero
% sera una lista con 8 listas.


%                Tableros: inicial, aleatorio
%	                  impresion y
%	              deteccion de reinas
%***************************************************************

tablero_inicial([[1,0,0,0,0,0,0,0],
		[1,0,0,0,0,0,0,0],
		[1,0,0,0,0,0,0,0],
		[1,0,0,0,0,0,0,0],
		[1,0,0,0,0,0,0,0],
		[1,0,0,0,0,0,0,0],
		[1,0,0,0,0,0,0,0],
		[1,0,0,0,0,0,0,0]]).


%Crea un Tablero
%makeBoard(0, Resultado).
%(Contador, Resultado)
makeBoard(8,[]).
makeBoard(Cont,[H|R]):-
	C1 is Cont + 1,
	aleat(Ran),
	moveQueen(Ran,0,H),
	makeBoard(C1,R).


demo_mQ(Rf):-aux_demo_mQ(0,Rf).

aux_demo_mQ(8,[]):-!.
aux_demo_mQ(N,[Ran|Rf]):-
	N1 is N + 1,
	aleat(Ran),
	%write(Ran),nl,
	aux_demo_mQ(N1,Rf),!.

%Posiciona una Reina en una columna del renglon
%   *** "setQueen"   ***
%   *** "makeLine"   ***
% moveQueen(7,0,R).
% R = [0,0,0,0,0,0,0,1].
%(ColumnaQueen, Contador, Resultado)
moveQueen(_,8,[]):-!.
moveQueen(0,Cont,[1|R]):-
	C1 is Cont + 1,
	moveQueen(-1,C1,R),!.%moveQueen(9,C1,R),!.
moveQueen(Q,Cont,[0|R]):-
	C1 is Cont + 1,
	Q1 is Q - 1,
	moveQueen(Q1,C1,R),!.

%Crea un numero Entero Aleatorio de 0 a 8
aleat(A):-
	random(Ran),%<- de 0.0 hasta 1.0
	Aux is 7 * Ran ,%<- Aqui limito el maximo
	A is integer(Aux).%<- Elimino Decimales


%     *****     Imprimir Tablero     *****

%Imprime el Tablero
printBoard([]):-!.
printBoard([H|B]):-
	printLine(H),nl,
	printBoard(B),!.

%Imprime un Renglon (una lista) del tablero.
printLine([]):-!.
printLine([0|B]):-
	write(' '),write('0'),
	printLine(B),!.
printLine([1|B]):-
	write(' '),write('R'),
	printLine(B),!.


demo([]):- tablero_inicial(TI), printBoard(TI),!.

demo1([]):- makeBoard(0,NewBoard), printBoard(NewBoard),!.


%     *****     Deteccion de reinas     *****

%Hay reina
%aQueen(3,0,[0,0,0,1],R).
%R = 1.
% Servira para encontrar las coliciones por columna.
% (Posicion,Contador<0>,Renglon,Rf)
aQueen(_,_,[],0):-!.
aQueen(N,N,[1|_],1):-!.
aQueen(Num,Cont,[_|R],Rf):-
	C1 is Cont + 1,
	aQueen(Num,C1,R,Rf).


%Optine Posicioin (Columna) de la Reina en el renglon
%getQueen([0,0,0,1],0,R).
%R = 3.
% (Renglon,Contador<0>,Resultado)
getQueen([1|_],C,C):-!.
getQueen([_|B],Cont,Rf):-
	C1 is Cont + 1,
	getQueen(B,C1,Rf),!.


%                      Funciones de Ataque
%***************************************************************

demo3(R):-tablero_inicial(Ti),ataqueVertical(Ti,0,0,R).

demo3_1([]):- makeBoard(0,NB), printBoard(NB),!.
demo4(Atk):- makeBoard(0,NB), printBoard(NB), ataques(NB,0,0,Atk),!.

%Suma los ataques del Tablero (EURISTICA)
% Regresa la cantidad de ataques del tablero.
% ataques([[0,1,0],[1,0,0],[0,1,0]],0,0,R).
% R = 3
%(Tablero, RenglonActual, Contador, Resultado).
ataques([],_,C,C):-!.
ataques([H|B],Ren1,Cont,Rf):-
	getQueen(H,0,Col1),%<- Optiene la Reina del renglon
	ataqueVertical(B,Col1,0,AtkV),
	Ren_sig is Ren1 + 1,
	%Calcula los ataques en diagonal al resto del tablero
	ataqueDiagonal(B,Ren_sig,[Ren1,Col1],0,AtkD),
	Aux is AtkV + AtkD,
	Cont1 is Aux + Cont,
	ataques(B,Ren_sig,Cont1,Rf).


%Cuantas piesas puede atacar en vertical en todos los
% renglones que se le envia a la funcion.
% ataqueVertical([[1,0],[1,0]],0,0,R).
%R = 2
%
%(Tablero,ColumnaReina,Contador,Resultado)
ataqueVertical([],_,C,C).
ataqueVertical([H|B],Pos,Cont,Rf):-
	getQueen(H,0,Pos),
	C1 is Cont + 1,
	ataqueVertical(B,Pos,C1,Rf).
ataqueVertical([_|B],Pos,Cont,Rf):-
	ataqueVertical(B,Pos,Cont,Rf).



%Ataque en Diagonal
%%%ataqueDiagonal([[0,1,0],[0,0,1]],1,[0,0],0,R).
%R = 2.
%(Renglones, #RenglonActual, PosicionReinaAtacante, ContadorAtaques, Resultado)
ataqueDiagonal([],_,_,C,C):-!.
ataqueDiagonal([H|B],Ren1,[Ren2,Col2],Cont,Rf):-
	getQueen(H,0,Col1),
	atkDiag([Ren1,Col1],[Ren2,Col2],1),
	Cont1 is Cont + 1,
	Ren_sig is Ren1 + 1,
	ataqueDiagonal(B,Ren_sig,[Ren2,Col2],Cont1,Rf),!.
ataqueDiagonal([_|B],Ren1,[Ren2,Col2],Cont,Rf):-
	Ren_sig is Ren1 + 1,
	ataqueDiagonal(B,Ren_sig,[Ren2,Col2],Cont,Rf).



%Auxiliar de Ataque en diagonal, calcula pendiente = 1
%atkDiag([4,2],[6,4],R).
%R = 1.
%Regresa 1 si hay colicion (Pendiente = 1), 0 si no la hay.
% ([Renglon1,Columna1], [Renglon2,Columna2], Resultado).
atkDiag([R1,C1],[R2,C2],1):-
	Aux1 is abs(R1 - R2),
	Aux2 is abs(C1 - C2),
	igual(Aux1,Aux2),!.
atkDiag(_,_,0):-!.

igual(I,I).

%                Calculo de inverciones (Un renglon)
%***************************************************************

% demo5([]).
% 0 0 0 R 0 0 0 0
% 0 0 0 R 0 0 0 0
% 0 R 0 0 0 0 0 0
% 0 0 0 0 0 0 R 0
% 0 0 R 0 0 0 0 0
% 0 0 R 0 0 0 0 0
% 0 0 R 0 0 0 0 0
% 0 0 0 0 R 0 0 0
%7
%[[4,[0,0]],[5,[0,1]],[8,[0,2]],[6,[0,4]],[4,[0,5]],[6,[0,6]],[5,[0,7]]]
%true.

demo5([]):-makeBoard(0,Tab),printBoard(Tab),
	getLine(Tab,0,Line0),%<-Calculo de a linea '0'
	getQueen(Line0,0,ColQ),
	ataques(Tab,0,0,Atk),
	write(Atk),nl,
	invLine(Tab,0,0,ColQ,R),
	write(R),!.

%Inverciones por Renglon
% Regresa una lista con listas: [Invercion,[Renglon, Columna]]
%  el atomo tendra la euristica y el movimiento hecho
% (Tablero,#Renglon, ContadorColumnas, ColumnaA_Ignorar, Resultado).

invLine(_,_,8,_,[]):-!.
%Caso en el que la sig columna es donde esta la reina actual:
invLine(Tab,Ren0,Col,Col,Rf):-
	Cont1 is Col + 1,
	invLine(Tab,Ren0,Cont1,Col,Rf),!.
invLine(Tab,Ren0,ContCol,ColIg,[[Eu,[Ren0,ContCol]]|Resto]):-
	moveQueen(ContCol,0,NewLine),% Renglon nuevo
	%Insertar el Renglon Nuevo en el Tablero
	setLine(Tab,0,Ren0,NewLine,NewTab),
	%Atacar
	ataques(NewTab,0,0,Eu),
	   %Eu = Euristica (Cantidad de ataques del tablero)
	Cont1 is ContCol + 1,
	% *** LOOP ***
	invLine(Tab,Ren0,Cont1,ColIg,Resto),!.
invLine(_,_,_,_,['Error']):-!.


%Insertar/Remplaza un Reglon espesifico
% setLine([[1,2],[3,4],[5,6]],0,1,[9,9],R).
% R = [[1, 2], [9, 9], [5, 6]].
% (Tablero, Contador, #RenglonA_Cambiar, Nuevo_Renglon, Resultado).
setLine([],_,_,_,[]):-!.
setLine([_|B],Cont,Cont,NewLine,[NewLine|Rf]):-
	Cont1 is Cont + 1,%<- Realmente no se ocupa, ¡Meh!
	setLine(B,Cont1,Cont,NewLine,Rf),!.
	%setLine(B,1,0,[],Rf),!.%<- 3 valores ya no se ocupan...
setLine([H|B],Cont,Ren,NewLine,[H|Rf]):-
	Cont1 is Cont + 1,
	setLine(B,Cont1,Ren,NewLine,Rf),!.


%Obtener una X linea/Renglon
%getLine([[1,2],[3,4],[5,6]],1,R).
% R = [3, 4].
%(Tablero,LineaBuscada,Resultado)
getLine([H|_],0,H):-!.
getLine([_|B],Cont,R):-
	Cont1 is Cont - 1,
	getLine(B,Cont1,R),!.
getLine(_,_,[]):-!.



%                Calculo de inverciones (Todo el Tablero,56)
%***************************************************************


demo6([]):- makeBoard(0,Tab),printBoard(Tab),
	invTab(Tab,Rf),
	%makeSort(Rf,[],[Rf1]),%<-Por que modifique el 'sort'
	% al
	%doSort(Rf,Rf1),
	nl,nl,write(Rf),!.

%Inverciones de TODO el Tablero.
%(Tablero,ListaInverciones)
%  lista de listas = [ [Eu[Pos/Movi]], ... ]
invTab(Tab,Rf1):-
	invTabAux(Tab,0,[],Rf),
	doSort(Rf,Rf1),!.


%Auxiliar de Inverciones de Tablero
% (Tab , Cont/Renglon , Frontera , Resultado)
invTabAux(_,8,Rf,Rf):-!.
invTabAux(Tab,Cont,Front,Rf):-
	getLine(Tab,Cont,Line0),
	getQueen(Line0,0,ColQ),
	invLine(Tab,Cont,0,ColQ,Eu),
	Cont1 is Cont + 1,
	concatenar(Front,Eu,NewFront),
	% ^- Mejor ordeno al Final
	%makeSort(Eu,Front,NewFront),%<- Insertar en orden!
	%nl,write(NewFront),nl,
	invTabAux(Tab,Cont1,NewFront,Rf),!.

concatenar([],L1,L1).
concatenar([H|C],L2,[H|R]):-concatenar(C,L2,R).


%Para cuando se quiere que un X arreglo se ordene
%   - No combina y ordena
doSort(Tab,Rf):-makeSort(Tab,[],[Rf]),!.

%Hace el Ordenamiendo
%   - Combina y Ordena 2 Listas
%(NuevaPorAgragar,Vieja,Final)
makeSort([],L,L):-!.
makeSort([H|B],[],[Rf]):-
	makeSort(B,[H],Rf),!.%<- Si no es lista el primer
%atomo de la Euristica no es una lista 'Eu,[Pos]'-> [Eu,[Pos]]
makeSort([Hn|Bn],Old,Rf):-
	sort(Hn,Old,Re),
	makeSort(Bn,Re,Rf).


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
	concatenar([Atom],L2,R1),
	sort([],R1,R),!.

euMay([E1,_],[E2,_]):- E1>E2.

%                Ciclo Que Tome la Mejor Opcion
%                       (Hill Climbing)
%***************************************************************

demo7([]):-makeBoard(0,Tab),printBoard(Tab),nl,
	makeMove(Tab,7,0,NewTab),nl,write('Nuevo Tablero'),
	printBoard(NewTab),!.

%1) Seleccionar la mejor opcion
%2) Hacer el cambio de estado (movimiento)

hillClimbing([]):-
	write('Tablero Inicial:'),nl,
	makeBoard(0,Tab),printBoard(Tab),
	ataques(Tab,0,0,Atk),
	write('Euristica = '),write(Atk),nl,nl,
	auxHC(Tab,99,_),!.

%Auxiliar Hill Climbing
%auxHC(Edo/Tab, EuristicaInicial, Resultado).
auxHC(Edo, 0, Edo):-
	write('La Solucion encontrada es:'),nl,
	printBoard(Edo),!.
auxHC(Edo, Eu, Rf):-
	invTab(Edo,Inv),
	% Tomo el mejor Movimiento
	hB(Inv,[B_Eu,[Ren,Col]],_),
	B_Eu < Eu,
	makeMove(Edo,Ren,Col,NewEdo),
	auxHC(NewEdo,B_Eu,Rf),!.
auxHC(Edo,Eu,Edo):-
	write('No se encontro Solucion'),nl,
	write('El mejor estado, con la Euristica ('),
	write(Eu),write('), fue:'),nl,
	printBoard(Edo),!.

%Cabeza y Cuerpo
hB([H|B],H,B).

% MakeMove
% (Tablero, Renglon, Columna, Resultado)
makeMove(Tab, Ren, Col, Rf):-
	moveQueen(Col, 0, NewLine),
	setLine(Tab, 0, Ren, NewLine, Rf),!.
