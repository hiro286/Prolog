%            8 Reinas por Algoritmo Genetico
%                      Basado en:
%	   Hill Climbing, Simulated Annealing
%		  & Algoritmo Genetico
%
%
%	  Universidad Autonoma de Baja California
%      Facultad de Ingenieria Arquitectura y Diseño
%	        Ingenieria en Computacion
%	              6to Semestre
%	    Héctor Humberto Hernández Zamora
%		         334938
%
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

makeTab(Tab):-makeBoard(0,Tab),!.

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


setReina(Col,Res):-moveQueen(Col,0,Res),!.

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

%Crea un numero Entero Aleatorio de 0 a 7
aleat(A):-
	random(Ran),%<- de 0.0 hasta 1.0
	Aux is 7 * Ran ,%<- Aqui limito el maximo
	A is integer(Aux).%<- Elimino Decimales


%     *****     Imprimir Tablero     *****

%Imprime el Tablero
printBoard([]):-!.
printBoard([H|B]):-
	printLine(H),
	printBoard(B),!.

%Imprime un Renglon (una lista) del tablero.
printLine([]):- nl,!.
printLine([0|B]):-
	write(' '),write('0'),
	printLine(B),!.
printLine([1|B]):-
	write(' '),write('R'),
	printLine(B),!.


demo([]):- tablero_inicial(TI), printBoard(TI),!.

demo1([]):- makeBoard(0,NewBoard), printBoard(NewBoard),!.


%     *****     Deteccion de reinas     *****
%
getReina(Ren,Col):-getQueen(Ren,0,Col),!.

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

atks(Tab,Rf):-ataques(Tab,0,0,Rf),!.

%Suma los ataques del Tablero (EURISTICA)
% Regresa la cantidad de ataques del tablero.
% ataques([[0,1,0],[1,0,0],[0,1,0]],0,0,R).
% R = 3
%(Tablero, RenglonActual, ContadorAtaques, Resultado).
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


setRenglon(Tab,NumRen,Ren,NewTab):-
	setLine(Tab,0,NumRen,Ren,NewTab),!.
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


%		      (Algoritmo Genetico)
%***************************************************************
%***************************************************************
%***************************************************************

% Se implementaran cuatro parametros granerales, que asu vez se divin en
% especificos:
%    *Cantidad		    -> Cant
% - Tamaño poblacion
% - Numero de Generaciones  -> N_gen
%   ^- En el inicio del programa esta aqui
%
%    *Porcentaje	    -> Prcen
% - Elite                   -> Elit
% - Cruzamiento             -> Cruz
% - Mutacion		    -> Muta
%
%    *Tipos                 -> Tipo
% - de Seleccion            -> Tsele
% 1 -> Ranking
% 2 -> Ruleta
% 3 -> Estado Continuo   * Caso especial.
%
% - de Cruzamiento          -> Tcruz
% 1 -> 1 Punto
% 2 -> 2 Puntos
% 3 -> Uniforme
% 4 -> Aritmetico  *Un solo hijo
%
%    *Poblacion             -> Pob
% ~ atomos [Heu,Tab]:
%  ° Heuristica
%  ° Tablero


%algoritmoGenetico(TamPob,NumGen,Elit,Cruz,Muta,Tcruz,Tselec):-
	%

%Porcentaje a Entero
%porc_ent(80,25,N).
%N=3.             <- Redondea!!!!
%(Total,Porcentaje,Resultado)
porc_ent(Total,Porce,Entero):-
	Porc1 is Porce / 100,
	Sub1 is Total * Porc1,
	Entero is integer(Sub1),!.

%Aleatorio N
%Genera un aleatorio de 0 a N (entero).
%aleatN(100,N).
%N = 23.
%aleatN(N,A).[
aleatN(Max,Aleat):-
	random(Ran),
	N1 is Ran * Max,
	Aleat is integer(N1),!.

%Elitismo
%Retornara los primero N atomos de la lista,
% si esta esta ordenara aplicara elitismo.
%elit(Tabs,Cant,Resultado).
elit(_,0,[]):-!.
elit([H|B],Cant,[H|Res]):-
	Cant > 0,
	C1 is Cant - 1,
	elit(B,C1,Res).


%		      (Algoritmo Genetico)
%			  Cruzameinto
%***************************************************************


%Cruza Poblacion
% Se cruza a toda la poblacion, debe ser multiplo de 2
%cruzPob(Pob,TCruz,Hijos).
cruzPob([],_,[]):-!.
cruzPob([Padre,Madre|B],1,[H1,H2|Rf]):- % 1 Punto
	cruz1punto(Padre,Madre,H1,H2),
	cruzPob(B,1,Rf),!.
cruzPob([Padre,Madre|B],1,[H1,H2|Rf]):- % 2 Puntos
	cruz2puntos(Padre,Madre,H1,H2),
	cruzPob(B,1,Rf),!.
cruzPob([Padre,Madre|B],1,[H1,H2|Rf]):- % Uniforme
	cruzUniforme(Padre,Madre,H1,H2),
	cruzPob(B,1,Rf),!.
cruzPob([Padre,Madre|B],1,[H1,H2|Rf]):- % Aritmetico
	cruzAritmetico(Padre,Madre,H1,H2),
	cruzPob(B,1,Rf),!.


demoAG1([]):-
	makeTab(Tab1),atks(Tab1,He1),
	  write(He1),nl,printBoard(Tab1),nl,
	makeTab(Tab2),atks(Tab2,He2),
	  write(He2),nl,printBoard(Tab2),nl,nl,
	cruzUniforme(Tab1,Tab2,Hijo1,Hijo2),%%%%
	printBoard(Hijo1),atks(Hijo1,He3),
	  write(He3),nl,
	nl,printBoard(Hijo2),atks(Hijo2,He4),
	  write(He4),nl,!.


%Dividir en un punto
% Divide un Tab en X punto
% div1_aux([[6],[5],[4],[3],[2],[1],[0]],3,R1,R2).
%R1 = [[6], [5], [4]],
%R2 = [[3], [2], [1], [0]].
%div1(Tab,Div,Inicio,Fin)
div1_aux(Res,0,[],Res):-!.
div1_aux([H|B],Div,[H|R1],R2):-
	Div > 0,
	Div1 is Div - 1,
	div1_aux(B,Div1,R1,R2),!.

%cruz1p(Tab1,Tab2,H1,H2):-cruz1punto(Tab1,Tab2,H1,H2),!.
%Cruzamiento en 1 Punto
%cruz1punto([[a],[b],[c],[d],[e],[f],[g],[h]],[[7],[6],[5],[4],[3],[2],[1],[0]],N_T1,N_T2).
%N_T1 = [[a], [b], [c], [d], [e], [2], [1], [0]],
%N_T2 = [[7], [6], [5], [4], [3], [f], [g], [h]].
%cruz1punto().
%cruz1punto(Tab1,Tab2,[T1_1,T2_2],[T2_1,T1_2]):-
cruz1punto(Tab1,Tab2,H1,H2):-
	aleatN(5,Ran),
	N is Ran + 1,
	div1_aux(Tab1,N,T1_1,T1_2),
	div1_aux(Tab2,N,T2_1,T2_2),
	concatenar(T1_1,T2_2,H1),
	concatenar(T2_1,T1_2,H2),!.

%Cruzamiento en 2 Puntos
% cruz2puntos([[a],[b],[c],[d],[e],[f],[g],[h]],[[7],[6],[5],[4],[3],[2],[1],[0]],N_T1,N_T2).
%N_T1 = [[a], [b], [5], [4], [e], [f], [g], [h]],
%N_T2 = [[7], [6], [c], [d], [3], [2], [1], [0]].
%cruz2puntos(Tab1,Tab2,[T1_1,T2_2,T1_3],[T2_1,T1_2,T2_3]):-
cruz2puntos(Tab1,Tab2,Hijo1,Hijo2):-
	p_div2(P1,P2),
	div1_aux(Tab1,P1,T1_1,Res),
	div1_aux(Res,P2,T1_2,T1_3),
	div1_aux(Tab2,P1,T2_1,Res1),
	div1_aux(Res1,P2,T2_2,T2_3),
	concatenar(T1_1,T2_2,H1),
	concatenar(T2_1,T1_2,H2),
	concatenar(H1,T1_3,Hijo1),
	concatenar(H2,T2_3,Hijo2),!.

%Puntos de Dividion en dos puntos
% C2 < 0, (C2 + C3) < 6
p_div2(C2,C3):-
	dosNdMmU(N1,N2),
	may_men(N1,N2,C1,C2),
	C3 is C1 - C2,!.

%Dos Numero Diferente, Mas y Menos Uno
% Genera dos numeros entre 1 y 6, que sean diferentes y diferentes con
% diferencia de mas/menos uno
% dosNdMmU(N1,N2).
%N1 = 4,
%N2 = 6.
dosNdMmU(N1,N2):-
	aleatN(5,Ran),
	N1 is Ran + 1,%Asi va de 1 a 6,
	dosNdMmU_aux(N1,N2),!.

dosNdMmU_aux(N1,N2):-
	aleatN(5,Ran),
	N2 is Ran + 1,
	difMmU(N1,N2),!.
dosNdMmU_aux(N1,N2):-
	dosNdMmU_aux(N1,N2),!.


%Diferente (=, +1 y -1)
difMmU(N1,N2):-
	N1 =\= N2,
	C1 is N2 + 1,
	C2 is N2 - 1,
	N1 =\= C1,
	N1 =\= C2,!.

%Mayo y menor
%may_men(N1,N2,May,Men).
may_men(N1,N2,N1,N2):-
	N1 > N2,!.
may_men(N1,N2,N2,N1):-!.


%%% Cruzamiento Uniforme
cruzUniforme(Ind1,Ind2,Hijo1,Hijo2):-
	cruzUniAux(Ind1,Ind2,0,Hijo1,Hijo2),!.

%cruzUniAux([1,2,3,4,5,6,7,8],[a,b,c,d,e,f,g,h],0,H1,H2).
%H1 = [1, b, 3, 4, e, 6, 7, 8],
%H2 = [a, 2, c, d, 5, f, g, h].
cruzUniAux(_,_,8,[],[]):-!.
cruzUniAux([H1|B1],[H2|B2],N,[H1|R1],[H2|R2]):-
	N > -1,
	random(Ran),
	Ran > 0.5,
	N1 is N + 1,
	cruzUniAux(B1,B2,N1,R1,R2),!.
cruzUniAux([H1|B1],[H2|B2],N,[H2|R1],[H1|R2]):-
	N > -1, N1 is N + 1,
	cruzUniAux(B1,B2,N1,R1,R2),!.


%Cruzameinto Aritmetico
%(Tablero1,Tablero2,Hijo1,Hijo2)
cruzAritmetico(T1,T2,Hijo1,Hijo2):-
	cruzAritAux(T1,T2,0,Hijo1,Hijo2),!.

%(Tab1,Tab2,Cont_ren,Hijo).
cruzAritAux(_,_,8,[],[]):-!.
cruzAritAux(T1,T2,Ren,[H1|Res1],[H2|Res2]):-
	getLine(T1,Ren,RenT1),
	getReina(RenT1,ColT1),
	getLine(T2,Ren,RenT2),
	getReina(RenT2,ColT2),
	C3 is ColT1 + ColT2,
	C3_1 is C3 + 1,
	C4_1 is ColT1 - ColT2,%%%
	%C4_1 is C4 - 1,%%%
	ColHijo1 is mod(C3_1,8),
	setReina(ColHijo1,H1),
	ColHijo2 is mod(C4_1,8),%%%
	setReina(ColHijo2,H2),%%
	Ren1 is Ren + 1,
	cruzAritAux(T1,T2,Ren1,Res1,Res2),!.

%modu(15,8,R).
%R = 7.
modu(N1,Mod,Rf):-
	Rf is mod(N1,Mod),!.


%		      (Algoritmo Genetico)
%			  Seleccion
%***************************************************************

%  *****   Ruleta   *****
% Retorna El lugar del ganador (empezando de 0)
%selecN_Ruleta([[1,a],[2,a],[7,a],[15,a],[18,a]],2,Win).
%Win = [[15, a], [2, a]].
selecN_Ruleta(Pob,N,Winners):-
	lastVec(Pob,[He_May|_]),
	makeVec_Ruleta(Pob,0,He_May,[],VecRul),
	longVec(VecRul,LongVecR),
	LongVecR1 is LongVecR - 1,
	%aleatN(LongVecR1,WinVec),
	%getN_inVec(VecRul,WinVec,Win),
	getN_Alet_inVec(VecRul,LongVecR1,N,Win),
	getWinners(Pob,Win,Winners),
	!.


longVec(Vec,Long):-long_Vec(Vec,0,Long),!.
%Longitud de un vector
%longVec([0,1,2,3,4,5,6,7,8],0,R).
%R = 9.
long_Vec([],N,N):-!.
long_Vec([_|B],Cont,Rf):-
	Cont1 is Cont + 1,
	long_Vec(B,Cont1,Rf),!.

lastVec(Vec,Last):-last_Vec(Vec,_,Last),!.
%Ultimo en el vector
%last_Vec([0,1,2,3,4,5,6,7,8],_,R).
%R = 8.
last_Vec([],Last,Last):-!.
last_Vec([H|B],_,Rf):-
	last_Vec(B,H,Rf),!.

%Primero en el vector
first_Vec([H|_],H):-!.

%Obetener N lugar del Vector
%getN_inVec([[0],[1],[2],[3],[4],[5],[6],[7],[8]],3,R).
%R = [3].
getN_inVec([H|_],0,H):-!.
getN_inVec([_|B],N,Rf):-
	N1 is N - 1,
	getN_inVec(B,N1,Rf),!.

%Obetiene los N primeros del Vector
%getNFirts_inVec([[0],[1],[2],[3],[4],[5],[6],[7],[8]],3,R).
%R = [[0], [1], [2]].
getNFirst_inVec(_,0,[]):-!.
getNFirst_inVec([H|B],N,[H|Rf]):-
	N1 is N - 1,
	getNFirst_inVec(B,N1,Rf),!.


%makeVecRuleta(Pob):-
%Crear el Vector del sorteo de la ruleta
% Retorna Vector Con Boletos referentes a la posiscion de la Poblacion
%makeVecRuleta([[1,a],[2,a],[5,a]],0,5,[],R).
%R = [0, 0, 0, 0, 0, 1, 1, 2].
%(Pob,Cont,He_May,VecActual,Resultado)
makeVec_Ruleta([],_,_,Vec,Vec):-!.
makeVec_Ruleta([[He|_]|B],Cont,He_May,VecA,RF):-
	Num is  He_May // He,
	makeSubVecAux(Cont,Num,Boletos),
	concatenar(VecA,Boletos,NewVec),
	Cont1 is Cont + 1,
	makeVec_Ruleta(B,Cont1,He_May,NewVec,RF),!.


%Crea un Vector Con Algo N veces dentro del Vector
%makeSubVecAux([algo],5,R).
%R = [[algo], [algo], [algo], [algo], [algo]].
makeSubVecAux(_,0,[]):-!.
makeSubVecAux(Algo,N,[Algo|Resto]):-
	N1 is N - 1,
	makeSubVecAux(Algo,N1,Resto),!.


demoAG1_1(N):- makeN_Tabs(N,Tabs),addHeu(Tabs,TabsH),
	printTabsHe(TabsH),selecN_Ruleta(TabsH,2,TabsM),nl,nl,
	printTabsHe(TabsM),!.


%  *****   N From Ranking   *****
%selecN_Ranking([[1,a],[2,a],[5,a],[20,a]],2,Win).
%Win = [[5, a], [1, a]].
selecN_Ranking(Pob,N,Winners):-
	%lastVec(Pob,[He_May|_]),
	longVec(Pob,LongPob),
	makeVec_Ranking(Pob,0,LongPob,[],VecRul),
	longVec(VecRul,LongVec1),
	LongVec is LongVec1 - 1,
	getN_Alet_inVec(VecRul,LongVec,N,Win),
	getWinners(Pob,Win,Winners),
	!.

makeVec_Ranking([],_,_,Vec,Vec):-!.
makeVec_Ranking([_|B],Cont,Cant,VecA,RF):-
	%Num is  He_May // He,
	makeSubVecAux(Cont,Cant,Boletos),
	concatenar(VecA,Boletos,NewVec),
	Cont1 is Cont + 1,%Contador de la ubicacion de jugador de la ruleta.
	Cant1 is Cant - 1,%Cantidad de voletos, o %
	makeVec_Ranking(B,Cont1,Cant1,NewVec,RF),!.

%Obtener N aleatorios del Vector
% Para N ganadores / seleccionados de un vector Ruleta o Tanking
getN_Alet_inVec(_,_,0,[]):-!.
getN_Alet_inVec(Vec,LongVec,N,[Win|Rf]):-
	aleatN(LongVec,WinVec),
	getN_inVec(Vec,WinVec,Win),
	N1 is N - 1,
	getN_Alet_inVec(Vec,LongVec,N1,Rf),
	!.

%Retorna los ganadores de la seleccion
% Busca en la poblacion los que estan en los lugares contenido en el
% vector de boletos de ganadores
getWinners(_,[],[]):-!.
getWinners(Pob,[N|Resto],[Win|Rf]):-
	getN_inVec(Pob,N,Win),
	getWinners(Pob,Resto,Rf),!.

%		      (Algoritmo Genetico)
%			    Mutacion
%***************************************************************

demoAG2([]):- makeTab(Tab),printBoard(Tab),nl,
	mutacion(Tab,TabMuta),printBoard(TabMuta),!.

demoAG2_1(N):- makeN_Tabs(N,Tabs),addHeu(Tabs,TabsH),
	printTabsHe(TabsH),mutaPob(TabsH,1,TabsM),nl,nl,
	printTabsHe(TabsM),!.

%Muta Poblacion
%mutaPob(Poblacion, NumeroRenglonesMutados, Resultado).
mutaPob([],_,[]):-!.
mutaPob([[_,Tab]|B],N,[[Heu,Muta]|Rf]):-
	random(Ran),
%Indice de mutacion! ***************************************************
	Ran < 0.001,
	n_Mutaciones(Tab,N,Muta),
	atks(Muta,Heu),
	mutaPob(B,N,Rf),!.
mutaPob([H|B],N,[H|R]):-
	mutaPob(B,N,R),!.

%Aplica N veces mutacion a un Tablero
n_Mutaciones(Muta,0,Muta):-!.
n_Mutaciones(Tab,N,Rf):-
	N1 is N - 1,
	mutacion(Tab,Muta),
	n_Mutaciones(Muta,N1,Rf),!.

%Mutacion
% Muta en un solo renglon
% (Tab,TabMutado).
mutacion(Tab,TabMutado):-
	aleat(N_Ren),
	aleat(N_Col),
	setReina(N_Col,NewRen),
	setRenglon(Tab,N_Ren,NewRen,TabMutado),!.

%		      (Algoritmo Genetico)
%		         Estado Continuo
%***************************************************************

%Crea N tableros Aleatorios
%makeN_Tabs(N,Tabs).
makeN_Tabs(0,[]):-!.
makeN_Tabs(N,[Tab|Resto]):-
	makeTab(Tab),
	N1 is N - 1,
	makeN_Tabs(N1,Resto),!.

%Imprime N Tableros
%printNTabs(Tabs).
printNTabs([]):-!.
printNTabs([H|B]):-
	printBoard(H),
	printNTabs(B),!.

%Agrega la Heuristica a los tableros
%addHeu(Tabs,TabsHeu).
addHeu([],[]):-!.
addHeu([H|B],[[Heu,H]|Res]):-
	atks(H,Heu),
	addHeu(B,Res),!.

%Imprime todos los tableros con sus heuristicas al inicio
%printTabsHe(Tabs).
printTabsHe([]):-!.
printTabsHe([[He,Tab]|B]):-
	write('Heu: '),write(He),nl,
	printBoard(Tab),nl,
	printTabsHe(B),!.

%Imprime solo N tableros con sus Heuristicas
%printNTabsHe(N,Tabs).
printNTabsHe(_,0):-!.
printNTabsHe([[He,Tab]|B],N):-
	write('Heu: '),write(He),nl,
	printBoard(Tab),nl,
	N1 is N - 1,
	printNTabsHe(B,N1),!.

demoAG3(N):-
	makeN_Tabs(N,Tabs),
	addHeu(Tabs,TabsHe),
	printTabsHe(TabsHe),!.


demoAG4(N):-
	makeN_Tabs(N,Tabs),
	addHeu(Tabs,TabsHe),doSort(TabsHe,TabsHe1),
	printTabsHe(TabsHe1),nl,nl,
	N1 is N / 2,
	N1int is integer(N1),
	Nm is N - 1,
	estadoContinuo(TabsHe1,Nm,N1int,1,Res),
	%addHeu(Res,HijosHeu),
	%printTabsHe(HijosHeu),
	printTabsHe(Res),
	!.


%Estado Continuo
% Toma los primeros 'Ncruz' tabs de 'Pob'
%  NPob es el tamaño de la poblacion a retornar
%  obiamente igual o menor a la cantidad de Pob
estadoContinuo(Pob,NPob,Ncruz,Tcruz,Rf):-
	N is Ncruz / 2,
	Nciclos is integer(N),
%Nciclos es el numero de parejas (2) de hijos que retorna
	chldsCruz(Pob,Nciclos,Tcruz,Hijos),
	N1 is NPob - Ncruz,
	N1int is integer(N1),
	addHeu(Hijos,HijosHeu),
	doSort(HijosHeu,HijosOrden),
%nl,write('N1int '),write(N1int),nl,write('Ncruz '),write(Ncruz),
%nl,write('Hijos Orden Heu.'),nl,printTabsHe(HijosOrden),nl,
	getNFirst_inVec(Pob,N1int,R1),%N1 elementos
%nl,write('R1'),nl,printTabsHe(R1),nl,
	getNFirst_inVec(HijosOrden,Ncruz,R2),%Ncruz elementos
%nl,write('R2'),nl,printTabsHe(R2),nl,nl,
	makeSort(R1,R2,Rf),
%write('Rf'), nl,printTabsHe(Rf),
	!.

%Genera los hijos del cruzamiento
%chldsEdCont(PoblacionA_Cruzar, NumeroHijosPares, TipoCruzam, Hijos).
chldsCruz(_,0,_,[]):-!.
%1 Punto
chldsCruz([[_,Padre],[_,Madre]|Resto],N,1,[H1,H2|Resto1]):-
	cruz1punto(Padre,Madre,H1,H2),
	N1 is N - 1,
	chldsCruz(Resto,N1,1,Resto1),!.
%2 Puntos
chldsCruz([[_,Padre],[_,Madre]|Resto],N,2,[H1,H2|Resto1]):-
	cruz2puntos(Padre,Madre,H1,H2),
	N1 is N - 1,
	chldsCruz(Resto,N1,2,Resto1),!.
%Uniforme
chldsCruz([[_,Padre],[_,Madre]|Resto],N,3,[H1,H2|Resto1]):-
	cruzUniforme(Padre,Madre,H1,H2),
	N1 is N - 1,
	chldsCruz(Resto,N1,3,Resto1),!.
%Aritmetico
chldsCruz([[_,Padre],[_,Madre]|Resto],N,4,[H1,H2|Resto1]):-
	cruzAritmetico(Padre,Madre,H1,H2),
	N1 is N - 1,
	chldsCruz(Resto,N1,4,Resto1),!.


%		        Funcion Principal
%		      (Algoritmo Genetico)
%***************************************************************


algoritmoGenetico(TamPob,NoGen,Pelit,Pcruz,Pmuta,Tsel,Tcruz):-
	makeN_Tabs(TamPob,Tabs),%Tabs
	addHeu(Tabs,TabsHe),
	doSort(TabsHe,TabsHe1),
	%write('Primera Gneracion: '),nl,printTabsHe(TabsHe1),
	porc_ent(TamPob,Pelit,Nelit),
	porc_ent(TamPob,Pcruz,Ncruz),
	porc_ent(8,Pmuta,Nmuta),%El 100% serian los 8 renglones.
% Nresto = (Tamaño_Poblacion) - (Cantidad_Elitismo)
	Nsel is TamPob - Nelit,
	displayAG(TamPob,NoGen,Nelit,Ncruz,Nmuta,Tsel,Tcruz),
%write('Nseleccionados = '),write(Nsel),nl,nl,
	agAux(TabsHe1,NoGen,Nelit,Nsel,Ncruz,Nmuta,Tsel,Tcruz,_),
	!.

%Se encarga de hacer el ciclo de cada generacion
agAux([[0,Tab]|_],_,_,_,_,_,_,_,Tab):-
	nl,write('Solucion Encontrada: '),nl,printBoard(Tab),!.
agAux([[He,Tab]|_],0,_,_,_,_,_,_,Tab):-
	nl,write('La mejor solucion encontrada fue: '),nl,
	printBoard(Tab),nl,write('Con Heuristica: '),
	write(He),!.
agAux(Pob,NoGen,Nelit,Nsel,Ncruz,Nmuta,Tsel,Tcruz,Rf):-
	write('Generacion numero: '),write(NoGen),write('    '),
	doSort(Pob,PobOrd),
cabeza(PobOrd,[Heu|_]),
write('Best Tab W/Heu:  '),%nl,
write(Heu),nl,
	%printTabsHe([H]),nl,%nl,
	elit(PobOrd,Nelit,TabsElit),
	%Nresto is Nsel - Ncruz,
	selecN_Cruz(Pob,Tsel,Nsel,Tcruz,Ncruz,SelNCruz),
%write('Post selecN_Cruz'),nl,
	mutaPob(SelNCruz,Nmuta,PobMut),
	makeSort(TabsElit,PobMut,NewPob),
	NG1 is NoGen - 1,
	doSort(NewPob,NewPob1),
	agAux(NewPob1,NG1,Nelit,Nsel,Ncruz,Nmuta,Tsel,Tcruz,Rf),!.

cabeza([H|_],H).

printNL([]):-!.
printNL([H|B]):-
	write(H),nl,
	printNL(B),!.

%mutaPob(Poblacion, NumeroRenglonesMutados, Resultado).

%  Ncruz debe ser multiplo de 2

%algoritmoGenetico(8,3,20,50,15,1,1).
%******************************************************************
%*************************************************************
%vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

%Seleccion y Cruzamiento
%(Poblacion,TipoCruz,NumeroDeSeleccionados,NumDeCruzados,Resultado)
selecN_Cruz(Pob,3,Nsel,Tcruz,Ncruz,Rf):-
	estadoContinuo(Pob,Nsel,Ncruz,Tcruz,Rf),!.
selecN_Cruz(Pob,Tsel,Nsel,Tcruz,Ncruz,Rf):-
	numACruzar(Ncruz,N),%trace,
	N2 is N * 2,
	seleccionados(Tsel,Pob,N2,ACruzar),%Parte que se cruza
	%write(N),%trace,
%write('Tabs a Cruzar:   '),write(N),nl,%write(),
%write(ACruzar),nl,
%printTabsHe(ACruzar),nl,
%chldsCruz se le envia la cantidad de "parejas" de hijos a retonrar
	%chldsCruz(ACruzar,Tcruz,N,Cruzados),%N
	chldsCruz(ACruzar,N,Tcruz,Cruzados),%N
%write('Post chldsCruz'),nl,% write(Cruzados),nl,
	addHeu(Cruzados,CruzHeu),
%write('ChldsCruz'),nl,%write(CruzHeu),nl,
%cabeza(CruzHeu,H),printTabsHe([H]),nl,
	seleccionados(Tsel,Pob,Nsel,Selec),%Parte que NO se Cruza
	makeSort(Selec,CruzHeu,Rf),!.

%numACruzar(5,N).
%N = 6.
numACruzar(N,X1):-
	X is N / 2,
	X1 is integer(X),
	%X2 is X1 * 2, %
	!.

seleccionados(1,Pob,N,Rf):-%Ranking
	selecN_Ranking(Pob,N,Rf),!.
seleccionados(2,Pob,N,Rf):-%Ranking
	selecN_Ruleta(Pob,N,Rf),!.


displayAG(TamPob,NoGen,Nelit,Ncruz,Nmuta,Tsel,Tcruz):-
	nl,write('Algoritmo Genetico para 8 Rinas.'),nl,nl,
	write('Tamaño de Poblacion:     '),write(TamPob),nl,
	write('Numero de Generaciones:  '),write(NoGen),nl,
	write('Cantidad de Elitismo:    '),write(Nelit),nl,
	write('Cantidad de Cruzamiento: '),write(Ncruz),nl,
	write('Cantidad de Mutacion:    '),write(Nmuta),nl,
	dispSelec(Tsel),dispCruz(Tcruz),nl,nl,
	!.

dispSelec(1):- write('Seleccion por Ranking.'),nl,!.
dispSelec(2):- write('Seleccion por Ruleta.'),nl,!.
dispSelec(3):- write('Seleccion por Estado Continuo.'),nl,!.

dispCruz(1):- write('Cruzamiento por 1 Punto.'),nl,!.
dispCruz(2):- write('Cruzamiento por 2 Puntos.'),nl,!.
dispCruz(3):- write('Cruzamiento por Uniforme.'),nl,!.
dispCruz(4):- write('Cruzamiento por Aritmetico.'),nl,!.


%***************************************************************
%***************************************************************
%                Ciclo Que Tome la Mejor Opcion
%                       (Hill Climbing)
%***************************************************************
%***************************************************************
%***************************************************************
%
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


%***************************************************************
%***************************************************************
%***************************************************************
%                Ciclo Que Tome la Mejor Opcion
%                     (Simulated Annealing)
%***************************************************************
%***************************************************************
%***************************************************************
%
simulatedAnnealing(Tmp):-
%simulatedAnnealing(Tmp,Eu):-
	write('Tablero Inicial:'),nl,
	makeTab(Tab),printBoard(Tab),atks(Tab,Eu),
	write('Euristica = '),write(Eu),nl,nl,
	auxSA(Tab,Eu,Tmp,_),!.


%Auxiliar Simulated Annaeling
%auxSA(Tab, Eu, Temperatura, Resultado).
auxSA(Tab,0,_,Tab):-aSA1(Tab),!.%<- Euristica = 0
auxSA(Tab,_,0,Tab):-aSA2(Tab),!.%<- Temperatura = 0
auxSA(_,Eu,Temp,Rf):-
	Temp1 is Temp - 1,
	makeTab(NewTab),
	atks(NewTab,NewEu),
	NewEu < Eu,
	auxSA(NewTab,NewEu,Temp1,Rf),!.
auxSA(_,Eu,Temp,Rf):-
	makeTab(NewTab),
	atks(NewTab,NewEu),
	energia(Eu,NewEu,Temp,E),
	random(Ran),%Aleatorio de 0.0 a 1.0
	Ran < E,
	Temp1 is Temp - 1,
	auxSA(NewTab,NewEu,Temp1,Rf),!.
auxSA(Tab,Eu,Temp,Rf):-
	Temp1 is Temp - 1,
	auxSA(Tab,Eu,Temp1,Rf),!.


aSA1(Tab):-
	write('Solucion Encontrada!'),nl,
	printBoard(Tab),!.
aSA2(Tab):-
	write('NO se encontro solucion.'),nl,
	write('Mejor estado:'),nl,
	printBoard(Tab),atks(Tab,Eu),
	write('Euristica = '),write(Eu),nl,!.

%Energia
%energia(Numero1, Numero2, Temperatura, Resultado/Energia)
energia(N1,N2,Temp,E):-
	Num is N1 - N2,
	%write(Num),nl,
	Exp is Num / Temp,
	%write(Exp),nl,
	E is exp(Exp),
	%write(E),
	!.

