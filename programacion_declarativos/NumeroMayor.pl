mayor([H|T],Max):- encuentraMax(T,H,Max).

encuentraMax([],Max,Max).
encuentraMax([H|T],N,Max):- H=<N , encuentraMax(T,N,Max).
encuentraMax([H|T],N,Max):- H>N , encuentraMax(T,H,Max).

