%multipEscalar([3,5,7],2,R).
%	R=[6,10,14].

multipEscalar([],_,[]).
multipEscalar([X|Y],M,[Z|R]):- Z is X*M , multipEscalar(Y,M,R).






















