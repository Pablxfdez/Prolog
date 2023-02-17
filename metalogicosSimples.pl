/* 6.2 PREDICADOS METALÓGICOS

Prolog incluye predicados que no se pueden representar en lógica de primer orden.
Algunos ejemplos son:
integer/1, float/1, number/1: Tienen éxito sii su parámetro está instanciado a un entero, float o a un número, respectivamente.
atomic/1: Tiene éxito sii su parámetro está instanciado a una constante
atom/1: Tiene éxito sii su parámetro está instanciado a a una constante no numérica

En cualquiera de los casos anteriores, si el parámetro fuera una variable no instanciada, el predicado fallaría.
*/

%Podemos usarlos para hacer un poco reversibles algunos predicados:
suma(X,Y,Z) :- number(X), number(Y), Z is X+Y.
suma(X,Y,Z) :- number(X), number(Z), Y is Z-X.
suma(X,Y,Z) :- number(Y), number(Z), X is Z-Y.

%También para tratar solo algunos elementos de una lista, por ejemplo sumando solo los que sean números:
sumaNumeros([],0).
sumaNumeros([X|Xs],Z) :- number(X), sumaNumeros(Xs,Y), Z is X+Y.
sumaNumeros([_|Xs],Z) :- sumaNumeros(Xs,Z).
%aunque la definición anterior tiene un problema que ya resolveremos más adelante usando un "corte"

/* Otros ejemplos de predicados metalógicos:
var/1 tiene éxito sii su parámetro es una variable libre
nonvar/1 tiene éxito sii su parámetro no es una variable libre, aunque pueda tener variables libres, por ejemplo nodo(3,I,D)
ground/1 tiene éxito sii su parámetro no contiene ninguna variable libre
==/2 tiene éxito sii sus dos parámetros son idénticos
\==/2 tiene éxito sii sus dos parámetros no son idénticos


En cualquiera de los casos anteriores, si el parámetro fuera una variable no instanciada, el predicado fallaría.
*/