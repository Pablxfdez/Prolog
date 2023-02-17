/*  Uso del punto y coma ";": DISYUNCIÓN e IF-THEN-ELSE

La disyunción lógica en un predicado se suele representar usando una regla para cada
alternativa, como en

descendiente(X,Y) :- progenitor(Y,X).
descendiente(X,Y) :- progenitor(Y,Z), descendiente(X,Z).

Ahora bien, también es posible hacerlo usando ; Por ejemplo: */

descendiente(X,Y) :- progenitor(Y,X) ; progenitor(Y,Z), descendiente(X,Z).

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

/*

Podemos definir una estructura IF-THEN-ELSE sacando partido del corte:

siPEntoncesQSiNoR(X) :- P(X), !, Q(X).
siPEntoncesQSiNoR(X) :- R(X).

Cuando se cumple P(X), eliminamos la segunda regla, y nos quedamos como única opción con Q(X).
Por contra, si P(X) termina y falla, entonces no evaluamos ni el corte ni Q(X), nos quedamos
simplemente con la opción de R(X).
Prolog incorpora una notación especial para estos casos:
    P(X) -> Q(X) ; R(X)

Recordemos el ejemplo

sumaNumeros([],0).
sumaNumeros([X|Xs],Z) :- number(X), !, sumaNumeros(Xs,Y), Z is X+Y.
sumaNumeros([_|Xs],Z) :- sumaNumeros(Xs,Z).

podemos reescribirlo como
*/

sumaNumeros([],0).
sumaNumeros([X|Xs],Z) :- number(X) -> sumaNumeros(Xs,Y), Z is X+Y ; sumaNumeros(Xs,Z).