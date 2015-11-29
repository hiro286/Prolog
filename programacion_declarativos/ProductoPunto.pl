%productoPunto([1,2],[2,1],R).
% R=4
% (1*2)+(2*1)=4

productoPunto([],[],0).
productoPunto([H1|T1],[H2|T2],PP):- productoPunto(T1,T2,PP1),
	                            PP2 is H1*H2,
				    PP is PP2+PP1.
