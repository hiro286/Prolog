%*****   Abecedario   *****
abecedario(a).%1
abecedario(b).
abecedario(c).
abecedario(d).
abecedario(e).%5
abecedario(f).
abecedario(g).
abecedario(h).
abecedario(i).
abecedario(j).%10
abecedario(k).
abecedario(m).
abecedario(n).
abecedario(l).
abecedario(o).%15
abecedario(p).
abecedario(q).
abecedario(r).
abecedario(s).
abecedario(t).%20
abecedario(u).
abecedario(v).
abecedario(w).
abecedario(x).
abecedario(y).%25
abecedario(z).
abecedario(ñ).

%*****   NUMEROS   *****
numero(0).
numero(1).
numero(2).
numero(3).
numero(4).
numero(5).
numero(6).
numero(7).
numero(8).
numero(9).

%**********   ASCII   ***********
abcascii(10,'nl').% nl (otro renglon)
abcascii(32,' ').%(space)
abcascii(33,'!').
abcascii(34,'"').% " (comillas dobles)
abcascii(35,'#').
abcascii(36,'$').
abcascii(37,'%').
abcascii(38,'&').
abcascii(39,' ').% ' (comilla simple)
abcascii(40,'(').
abcascii(41,')').
abcascii(42,'*').
abcascii(43,'+').
abcascii(44,',').% , (coma)
abcascii(45,'-').
abcascii(46,'.').
abcascii(47,'/').
%*****   Numeros   *****
abcascii(48,0).
abcascii(49,1).
abcascii(50,2).
abcascii(51,3).
abcascii(52,4).
abcascii(53,5).
abcascii(54,6).
abcascii(55,7).
abcascii(56,8).
abcascii(57,9).

abcascii(58,':').
abcascii(59,';').
abcascii(60,'<').
abcascii(61,'=').
abcascii(62,'>').
abcascii(63,'?').
abcascii(64,'@').

%*****   Mayusculas   *****
abcascii(65,a).
abcascii(66,b).
abcascii(67,c).
abcascii(68,d).
abcascii(69,e).
abcascii(70,f).
abcascii(71,g).
abcascii(72,h).
abcascii(73,i).
abcascii(74,j).
abcascii(75,k).
abcascii(76,m).
abcascii(77,m).
abcascii(78,n).
abcascii(79,o).
abcascii(80,p).
abcascii(81,q).
abcascii(82,r).
abcascii(83,s).
abcascii(84,t).
abcascii(86,u).
abcascii(87,v).
abcascii(88,w).
abcascii(89,x).
abcascii(90,y).

abcascii(91,'[').
abcascii(92,'/').% \ ( '/' invertida)
abcascii(93,']').
abcascii(94,'^').
abcascii(95,'_').
abcascii(96,'`').% `(acento invertido)

%*****   Minisculas   *****
abcascii(97,a).
abcascii(98,b).
abcascii(99,c).
abcascii(100,d).
abcascii(101,e).
abcascii(102,f).
abcascii(103,g).
abcascii(104,h).
abcascii(105,i).
abcascii(106,j).
abcascii(107,k).
abcascii(108,l).
abcascii(109,m).
abcascii(110,n).
abcascii(111,o).
abcascii(112,p).
abcascii(113,q).
abcascii(114,r).
abcascii(115,s).
abcascii(116,t).
abcascii(117,u).
abcascii(118,v).
abcascii(119,w).
abcascii(120,x).
abcascii(121,y).
abcascii(122,z).

abcascii(123,'{').
abcascii(123,'|').
abcascii(123,'}').
abcascii(123,'~').


% en Listas
palSis([i,n,t]).
palSis([f,l,o,a,t]).
palSis([c,h,a,r]).
%palSis([b,o,o,l,e,a,n]).
palSis([f,o,r]).
palSis([w,h,i,l,e]).
palSis([d,o]).
palSis([i,f]).

palSis(tipoDato(_)).

tipoDato([i,n,t]).
tipoDato([f,l,o,a,t]).
tipoDato([c,h,a,r]).
tipoDato([l,o,n,g]).
tipoDato([d,o,u,b,l,e]).


variable(int,i).


%inform(X,Y) :-
%       writenl([move,a,disk,from,the,X,pole,to,Y,pole]).
%    write(X),
%    write(' hacia la torre '),

%**********************************************************
%**********************************************************
%*************  DECLARACIOON DE VARIABLES  ****************
%**********************************************************
%**********************************************************

%Declaracion de Variables  ENTERAS (Sin Decimales)
% int dato;
decVar(X,RestoFinal):-
       tipoDato(S),
       sublista(X,S,[' '|R]),
%       nombreSpc(R,Nom,RestoFinal),
       identificador(R,Nom,Res),
       compPyc(Res,RestoFinal),
       nl,write('Decraracion de la variable:'),
       write(Nom),
       write(' es correcta.'),nl,
       !.

% int dato=23;
decVar(X,RestoFinal):-
       tipoDato(S),
       sublista(X,S,[' '|R]),
       nombreSigual(R,Nom,R1),
       esNum(R1,Num,[';'|RestoFinal]),
       compNum(Num),
%       compPyC(RestoFinal),
       nl,write('La variable:'),
       write(Nom),
       write([con,valor,Num]),
       writeln(' a sido declarada corractamente.'),
       write([resto,RestoFinal]),nl,
       !.
% int (declaracion multiple...)
decVar(X,Rf):-
       tipoDato(S),
       sublista(X,S,[' '|R]),
       multiDec(R,Rf),
       !.

%Declaracion Multiple
% int i, o=1, p, op=10;
% id,
multiDec(Li,Rf):-
	identificador(Li,_,R),
	compComa(R,R2),
	multiDec(R2,Rf),
	!.
% id;
multiDec(Li,Rf):-
	identificador(Li,_,R),
	borrarSpc(R,[';'|Rf]),
	!.

% id= NUMERO
multiDec(Li,Rf):-
	identificador(Li,_,R),
	compIgual(R,R1),
	compNumero(R1,_,R2),
	compComa(R2,R3),
	multiDec(R3,Rf),
	!.
% id = NUMRO ;
multiDec(Li,Rf):-
	identificador(Li,_,R),
	compIgual(R,R1),
	compNumero(R1,_,R2),
	borrarSpc(R2,[';'|Rf]),
	!.

%**********************************************************
%**********************************************************



cicloFor(X):-
	sublista(X,[f,o,r],R),
	sublista(R,[' '],R1),
	tipoDato(D),
	sublista(R1,D,_),
	!.

%condIf().

%Todo nombre con el que se identifica una variable
% (Lista, Nombre, Resto)
identificador(Lista,[H|Id],Resto):-
	borrarSpc(Lista,[H|T]), %<- Borra Espacios
	abecedario(H),
	id(T,Id,Resto),
	!.

%Complementa "identificador"
% (Lista, ID, Resto)
id([H|T],[H|T1],R):-
	abecedario(H),
	id(T,T1,R),!.
id([H|T],[H|T1],R):-
	numero(H),
	id(T,T1,R),!.
id(['_'|T],['_'|T1],R):-
	id(T,T1,R),!.
id(R,[],R):-!.



%Nombre sin el punto y coma
% False si no hay un ';'
%?- nombreSpc([h,o,l,a,;,o,p],Nombre,Resto).
%Nombre = [h, l, a],
%Resto = [o, p].
nombreSpc([';'|R],[],R):-!.
nombreSpc([H|T],[H|R],Resto):- abecedario(H),
	nombreSpc(T,R,Resto),!.

%nombre sin el sigono de '='
% False si no hay un '='
%?- nombreSigual([d,a,n,y,'=',s,w,a,g],Nom,Resto).
%Nom = [d, a, n, y],
%Resto = [s, w, a, g].
nombreSigual(['='|R],[],R):-!.
nombreSigual([H|T],[H|R],Resto):-
	abecedario(H),
	nombreSigual(T,R,Resto),!.

% (Litas , Lista sin espacios iniciales)
borrarSpc([' '|T],R):- borrarSpc(T,R),!.
borrarSpc(R,R):-!.
%borrar0(X,[H|T],[H|Resto]):- borrar0(X,T,Resto),!.


%?-sublista([1,a,2,b,3,c,4],[2,b,3],R).
%R=[c,4].
%sublista(ListaPrincipal,SubLista,RestoListaP).
sublista(R,[],R):-!.
%sublista([' '|T],L,R):-sublista(T,L,R).
sublista([X|T1],[X|T2],R):-sublista(T1,T2,R),!.
sublista([_|T1],L,R):- sublista(T1,L,R).
%R= al Resto, loque resta de la lista



%Numero Flotante/Decimal (solo suporta un '.')
%?- esNumF([1,2,3,4,.,5,1,2,3,a,r,as,1,2,3],Numero,Resto).
%Numero = [1, 2, 3, 4, '.', 5, 1, 2, 3],
%Resto = [a, r, as, 1, 2, 3].
esNumF([H|T],[H|Rn],R):- numero(H),
	esNumF(T,Rn,R),!.
esNumF(['.'|T],['.'|Rn],R):- esNum(T,Rn,R),!.
esNumF(R,[],R):-!.

%transAscii([H|T],[Z|R]).
%Trduce una lsita de ASCII a vobcabulario
transAscii([],[]):-!.
transAscii([H|T],[Z|R]):-
	abcascii(H,Z),
	transAscii(T,R),!.


%Lista - Cabeza - Cuerpo
lcc([H|T],H,T).

%Compureba que haya un numero
% *** Borrar Espacios
% (Lista, Numero, Resto)
compNumero(L,Num,Res):-
	borrarSpc(L,L2),
	esNum(L2,Num,Res),
	compNum(Num),
	!.


%esNum(Lista,Numero,Resto).
%*****   Debe empezar con un numero.    *****
%?- esNum([1,2,3,4,5,1,2,3,a,r,as,1,2,3],Numero,Resto).
%Numero = [1, 2, 3, 4, 5, 1, 2, 3],
%Resto = [a, r, as, 1, 2, 3].
esNum([H|T],[H|Rn],R):-
	numero(H),
	esNum(T,Rn,R),!.
esNum(R,[],R):-!.

%Compureba si hay un numero al principio (1 digito).
compNum([H|_]):-
	numero(H),
	!.


%Comprueba si hay un punto y coma al principio.
%compPyC([';'|_]).

%Comprueba Punto y Coma ";"
% *** ELIMINA Espacios
% (Lista, Resto)
compPyc(L,Res):-
	borrarSpc(L,[';'|R]),
	borrarSpc(R,Res),
	!.

%Comprueba  Coma ","
% *** ELIMINA Espacios
% (Lista, Resto)
compComa(L,Res):-
	borrarSpc(L,[','|R]),
	borrarSpc(R,Res),
	!.

%Comprueba Igual "="
% *** ELIMINA Espacios
% (Lista, Resto)
compIgual(L,Res):-
	borrarSpc(L,['='|R]),
	borrarSpc(R,Res),
	!.



%***********   Lectura de Ficheros   **************
%                 (Learn Prolog)

%Captura palabra por palabra (o con que haya espacio)
mainText:-
         open('prueba1.txt',read,Str),
         readText(Str,[Palabras]),
         close(Str),
%         write(Palabras),nl,
	 transAscii(Palabras,Res),
	 writeln(Res),nl,
	 decVar(Res,R1),
	 decVar(R1,_),
	 !.

readText(InputStream, []):- at_end_of_stream(InputStream).
readText(InputStream, [Word|Words]):-
	readWord(InputStream, Word),
%	write(Word),nl,nl,
	readText(InputStream, Words).

%readWord(InStream,W):-
readWord(InStream,Chars):-
         get_code(InStream,Char),
         checkCharAndReadRest(Char,Chars,InStream).
%         atom_codes(W,Chars).

%checkCharAndReadRest(10,[],_):-  !.
%checkCharAndReadRest(32,[],_):-  !.
checkCharAndReadRest(-1,[],_):-  !.
checkCharAndReadRest(end_of_file,[],_):-  !.
checkCharAndReadRest(Char,[Char|Chars],InStream):-
%	 abcascii(Char,X),%Traduce mientras analiza?
         get_code(InStream,NextChar),
%	 write(NextChar),nl,
         checkCharAndReadRest(NextChar,Chars,InStream).
