/*  6.5 PREDICADOS DE AGREGACIÓN 

Los predicados de agregación nos permiten recolectar todas las soluciones que satisfacen un objetivo
  findall(T,Objetivo,L) devuelve en L la lista de todos los términos T que satisfacen Objetivo
Por ejemplo
  findall(X,hermanos(X,maria),L).
devolvería en L la lista de todos los hermanos de maria
  findall(pareja(X,Y),descendiente(X,Y),L).
devolvería en L la lista de todas las parejas (X,Y) tales que X es descendiente de Y.
  findall(X,(hombre(X),adulto(X)),L).
devolvería en L la lista de todos los hombres adultos.

El predicado setof/3 se comporta básicamente igual que findall/3 con la única diferencia de que 
setof/3 devuelve la lista ordenada y sin repeticiones.

*/

progenitor(luis,maria).
progenitor(ana,maria).
progenitor(luis,alberto).
progenitor(ana,alberto).
progenitor(luis,pepe).
progenitor(ana,pepe).
progenitor(maria,carlos).
progenitor(juan,carlos).
hombre(luis).
hombre(carlos).
mujer(maria).
mujer(ana).
hermanos(X,Y):- progenitor(Z,X), progenitor(Z,Y), X\=Y.

hijos(X,L) :- setof(Y,progenitor(X,Y),L).
misHermanos(X,L) :- setof(Y,hermanos(X,Y),L).
misHermanosConRepeticiones(X,L) :- findall(Y,hermanos(X,Y),L).