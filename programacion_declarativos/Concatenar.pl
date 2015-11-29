
concatenar([],L1,L1).
concatenar([H|C],L2,[H|R]):-concatenar(C,L2,R).
