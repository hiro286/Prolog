
%ncd([1,2,5,3,1],[4,2,3,5,1],0,R).
%R = 3

%Numero de Casillas Diferentes(L1,L2,Contador,Resultado).
ncd([],[],C,C):-!.
ncd([H|T1],[H|T2],C,R):-ncd(T1,T2,C,R),!.
ncd([_|T1],[_|T2],C,R):- C1 is C +1, ncd(T1,T2,C1,R),!.


%sort([[5]],[1,4,8],R).
%R = [1, 4, 5, 8].
% ***Solo se agrega de uno por uno.
%Ordenamiento (L1,L2,R).
sort([],L,L):-!.
sort([H1],[H2|T2],[H2|R]):-
	H1 > H2,
	sort(H1,T2,R),!.
sort([H1],L2,R):-
	concatenar(H1,L2,R1),
	sort([],R1,R),!.

%concatenar (L1,L2,[L1,L2]).
concatenar([],L1,L1):-!.
concatenar([H|C],L2,[H|R]):-concatenar(C,L2,R).
