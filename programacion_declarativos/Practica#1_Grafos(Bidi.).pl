%byCar(auckland,hamilton).
%byCar(hamilton,raglan).
byCar(ensenada,tijuana).
byCar(ensenada,tecate).
byCar(tijuana,tecate).
byCar(tecate,mexicali).
byCar(mexicali,sanLuis).
byCar(mexicali,sanFelipe).
byCar(ensenada,sanFelipe).
byCar(sonorita,caborca).
byCar(hermosillo,guaymas).
byCar(islaCedros,ensenada).

byCar(mexicali,calexico).
byCar(tijuana,sanDiego).

byCar(maneadero,zorrillo).


%byTrain(metz,frankfurt).
%byTrain(saarbruecken,frankfurt).
byTrain(ensenada,laPaz).
byTrain(laPaz,losCabos).
byTrain(sanLuis,sonorita).
byTrain(caborca,hermosillo).
byTrain(guaymas,losMochis).
byTrain(losMochis,culiacan).
byTrain(culiacan,mazatlan).

byTrain(sanDiego,phoenix).
byTrain(sanDiego,losAngeles).
byTrain(sanDiego,calexico).

byTrain(maneadero,sanVicente).

%byPlane(paris,losAngeles).
%byPlane(bangkok,auckland).
byPlane(tijuana,losCabos).
byPlane(tijuana,chihuahua).
byPlane(tijuana,mexico).
byPlane(laPaz,losMochis).
byPlane(sanDiego,denver).

byPlane(ensenada,maneadero).

% a) Es posible que viajes de un lugar a otro, ya sea por carro, tren, avión o una mezcla.
viaje(A,B):- byCar(A,B).
viaje(A,B):- byTrain(A,B).
viaje(A,B):- byPlane(A,B).
viaje(A,B):- byCar(A,Z), viaje(Z,B).
viaje(A,B):- byTrain(A,Z), viaje(Z,B).
viaje(A,B):- byPlane(A,Z), viaje(Z,B).

% b) El itinerario de ciudades que necesita cruzar para llegar de una ciudad A a otra B.
viajeDesde(A,B,[Z|R]):- byCar(A,Z),viajeDesde(Z,B,R).
viajeDesde(A,B,[Z|R]):- byTrain(A,Z),viajeDesde(Z,B,R).
viajeDesde(A,B,[Z|R]):- byPlane(A,Z),viajeDesde(Z,B,R).
viajeDesde(A,A,[]).

% c) El itinerario de ciudades como en inciso b agregando cómo viajar de una ciudad a otra (carro, tren o avión).
viaje_Desde(A,A,[]).
viaje_Desde(A,B,[Z|R]):- byCar(A,Z),
	               viaje_Desde(Z,B,R).%,
		       viaje_Desde(_,_,byCar).
viaje_Desde(A,A,byTrain).
viaje_Desde(A,B,[Z|R]):- byTrain(A,Z),viaje_Desde(Z,B,R).
viaje_Desde(A,A,byPlane).
viaje_Desde(A,B,[Z|R]):- byPlane(A,Z),viaje_Desde(Z,B,R).

%******************************
%Alternativa Multi-funciones

v_Desde(A,B,X):- v_DesdeCar(A,B,X).
v_Desde(A,B,X):- v_DesdeTrain(A,B,X).
v_Desde(A,B,X):- v_DesdePlane(A,B,X).
v_Desde(A,A,[]).

%v_DesdeCar(_,_,byCar).
v_DesdeCar(A,A,byCar).
v_DesdeCar(A,B,[Z|R]):- byCar(A,Z),v_DesdeCar(Z,B,R).
%v_DesdeCar(A,B,[Z|R]):- byTrain(A,Z),v_DesdeTrain(Z,B,R).
%v_DesdeCar(A,A,[]).

v_DesdeTrain(A,A,byTrain).
v_DesdeTrain(A,B,[Z|R]):- byTrain(A,Z),v_DesdeTrain(Z,B,R).
%v_DesdeTrain(A,B,[Z|R]):- byPlane(A,Z),v_DesdePlane(Z,B,R).


v_DesdePlane(A,A,byPlane).
v_DesdePlane(A,B,[Z|R]):- byPlane(A,Z),v_DesdePlane(Z,B,R).




%*****************************************
%Error de comprencion (ANEXOS)

% b) El itinerario de ciudades que necesita cruzar para llegar de una ciudad A a otra B.
%ViajeDesde:
vDesde(A,[Z|R]):- byCar(A,Z), vDesde(Z,R).
vDesde(A,[Z|R]):- byTrain(A,Z), vDesde(Z,R).
vDesde(A,[Z|R]):- byPlane(A,Z), vDesde(Z,R).
vDesde(_,[]).

% c) El itinerario de ciudades como en inciso b agregando cómo viajar de una ciudad a otra (carro, tren o avión).
c_vDesde(A,[Z|R]):- byCar(A,Z), c_vDesde(Z,R).
c_vDesde(_,en_Carro).

