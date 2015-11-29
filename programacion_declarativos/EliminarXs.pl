eliminarX(_,[],[]).
eliminarX(X,[X|Y],Z):- eliminarX(X,Y,Z).
eliminarX(X,[_|Y],[_|Y1]):- eliminarX(X,Y,Y1).
