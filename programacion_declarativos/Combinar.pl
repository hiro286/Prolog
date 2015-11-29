%Combinar(L1,L2,R).
%?combinar([1,2,3],[a,b,c],R).
%R=[1,a,2,b,3,c].

combinar0([],[],[]).
combinar0([H1|T1],[H2|T2],[H1|[H2|R]]):-combinar0(T1,T2,R).
%combinar([H1,T1],[H2,T2],[H1,H2|R]):-combinar(T1,T2,R).

%?combinar([1,2,3],[a,b,c],R).
%R=[[1,a],[2,b],[3,c]].

combinar1([],[],[]).
combinar1([H1|T1],[H2|T2],[[H1,H2]|R]):-combinar1(T1,T2,R).

%?combinar([1,2,3],[a,b,c],R).
%R=[j(1,a),j(2,b),j(3,c)].

combinar2([],[],[]).
combinar2([H1|T1],[H2|T2],[j(H1,H2)|R]):-combinar2(T1,T2,R).
