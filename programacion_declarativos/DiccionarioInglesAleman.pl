tran(eins,one).
tran(zwei,two).
tran(duei,three).
tran(vier,four).
tran(fünf,five).
tran(sechs,six).
tran(sieber,seven).
tran(acht,eigth).
tran(neun,nine).
%tran(X,error).

traduce([],[]).
traduce([X|Y],[Z|Resto]):- tran(X,Z),
			   traduce(Y,Resto).
traduce([X|Y],[Z|Resto]):- tran(Z,X),
			   traduce(Y,Resto).
traduce([_|Y],[error|Resto]):- traduce(Y,Resto).


