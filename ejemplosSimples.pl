% Ejemplos con relaciones de parentesco

progenitor(luis,maria).
progenitor(ana,maria).
progenitor(luis,alberto).
progenitor(ana,alberto).
progenitor(maria,carlos).
progenitor(juan,carlos).
hombre(luis).
hombre(carlos).
mujer(maria).
mujer(ana).



hijo(X,Y) :- progenitor(Y,X), hombre(X).

abuela(X,Y) :- progenitor(Z,Y), madre(X,Z).
abuelo(X,Y) :- progenitor(Z,Y), padre(X,Z).

madre(X,Y) :- progenitor(X,Y), mujer(X).
padre(X,Y) :- progenitor(X,Y), hombre(X).

hermanos(X,Y):- progenitor(Z,X), progenitor(Z,Y), X\=Y.

tioa(X,Y) :- progenitor(Z,Y), hermanos(Z,X).

descendiente(X,Y) :- progenitor(Y,X).
descendiente(X,Y) :- progenitor(Y,Z), descendiente(X,Z).



% Aritmética no predefinida

suma(cero,Y,Y).
suma(s(X),Y,s(Z)) :- suma(X,Y,Z).


% Ejemplos con listas

esLista([]).
esLista([_|Ys]) :- esLista(Ys).

pertenece(X,[X|_]).
pertenece(X,[_|Ys]) :- pertenece(X,Ys).


concatenar([],Xs,Xs).
concatenar([X|Xs],Ys,[X|Zs]) :- concatenar(Xs,Ys,Zs).

take(cero,_,[]).
take(_,[],[]).
take(s(N),[X|Xs],[X|Ys]) :- take(N,Xs,Ys).

invertir([],[]).
invertir([X|Xs],Ys) :- invertir(Xs,Zs), concatenar(Zs,[X],Ys).

inv(Xs,Ys) :- inv(Xs,[],Ys).
inv([],Xs,Xs).
inv([X|Xs],Ys,Zs) :- inv(Xs,[X|Ys],Zs).


% Ejemplos con árboles binarios

esArbol(avacio).
esArbol(nodo(_,I,D)) :- esArbol(I), esArbol(D).

perteneceArbol(X,nodo(X,_,_)).
perteneceArbol(X,nodo(_,I,_)) :- perteneceArbol(X,I).
perteneceArbol(X,nodo(_,_,D)) :- perteneceArbol(X,D).

preOrden(avacio,[]).
preOrden(nodo(X,I,D),[X|L]) :- preOrden(I,LI), preOrden(D,LD), append(LI,LD,L).

inOrden(avacio,[]).
inOrden(nodo(X,I,D),L) :- inOrden(I,LI), inOrden(D,LD), append(LI,[X|LD],L).

postOrden(avacio,[]).
postOrden(nodo(X,I,D),L) :- postOrden(I,LI), postOrden(D,LD), append(LD,[X],LD2), append(LI,LD2,L).
