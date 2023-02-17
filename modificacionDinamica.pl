/*  6.6 MODIFICACIÓN DINÁMICA DEL PROGRAMA

Un programa Prolog puede modificarse a sí mismo, lo cual es especialmente útil si queremos
implementar sistemas expertos a los que se van añadiendo nuevas reglas dinámicamente. Puede 
resultar bastante útil, pero debe hacerse con mucho cuidado, pues puede ser muy complicado 
entender qué implicaciones tienen dichas modificaciones.

Recordemos que un programa Prolog es un conjunto de reglas. Para modificar dinámicamente 
un programa se proporcionan predicados que permiten añadir o eliminar reglas:

  asserta(C) añade la cláusula C al principio del conjunto de reglas del predicado correspondiente a C
  assertz(C) añade la cláusula C al final del conjunto de reglas del predicado correspondiente a C
  retract(C) elimina la primera cláusula que unifica con C
  retractall(C) elimina todas las cláusulas que unifican con C

*/

% Para que un predicado que aparece en un programa pueda ser modificado dinámicamente
% es necesario definirlo como dinámico:
:- dynamic progenitor/2.
progenitor(luis,maria).
progenitor(ana,maria).
progenitor(luis,alberto).
progenitor(ana,alberto).
progenitor(maria,carlos).
progenitor(juan,carlos).

/*

Para ver cómo se va modificando dinámicamente la definición de un predicado, podemos usar el predicado
listing. Por ejemplo

  ?listing(progenitor/2).

nos mostrará la definición actual del predicado progenitor  
Si después vamos haciendo modificaciones, podremos ir viendo los cambios si llamamos otra vez a listing(progenitor/2).

  ?asserta(progenitor(maria,belen)).
  
  ?listing(progenitor/2).
  
  ?retract(progenitor(luis,X)).

  ?listing(progenitor/2).
  
  ?retractall(progenitor(X,carlos)).
  
El uso de estos predicados se puede complicar tanto como queramos, haciendo definiciones retorcidas 
del estilo
  ?assertz((p(A):-assertz(p(A)),fail)).  
  ?p(a).
  ?p(X),p(b).
*/

/*
Puede ser útil para almacenar conocimiento que vayamos calculando. Por ejemplo, podemos calcular 
fácilmente la tabla de multiplicar utilizando un "bucle de fallo":
*/

tabla(L):-member(X,L), member(Y,L), Z is X*Y, assertz(mult(X,Y,Z)), fail.

/*
Si evaluamos 
  ?tabla([1,2,3,4,5,6,7,8,9,10]).
obtnemos que se genera todo el conocimiento de la tabla de multiplicar, que podemos ver con
  ?listing(mult/3).
*/

/*
Uno de los ejemplos más típicos de uso es mejorar la definición típica de fibonacci
almacenando resultados intermedios para evitar que se repitan:
*/

:-dynamic fibAux/2.
fibAux(0,1).
fibAux(1,1).

fib(N,F) :- fibAux(N,F), !.
fib(N,F) :- N1 is N-1, N2 is N-2, fib(N1,F1), fib(N2,F2), F is F1+F2, assertz(fibAux(N,F)).

/* Nótese que la definición de fib es muy similar a la definición trivial de fibonacci,
pero delegando todos los casos base en un predicado auxiliar fibAux. Inicialmente solo 
tenemos dos casos base recogidos en fibAux, pero a medida que se van calculando nuevos
valores de fibonacci, el assertz correspondiente va añadiendo "casos base" a fibAux, de
modo que no sea necesario repetir ningún cómputo. Nótese también que usamos un corte al
final de la primera regla de fib para no buscar más alternativas una vez que ya tenemos
un caso base. 
Nótese finalmente que el único predicado dinámico es fibAux, mientras que fib no lo es.
*/


/* Otro ejemplo simple de uso de modificación dinámica del programa puede ser el siguiente,
donde lo que hacemos es crear un contador que lleve la cuenta de cuántas veces hemos 
llamado al predicado contar/1 */

:-dynamic contador/1.
contador(0).

contar :- contador(X), Y is X+1, retract(contador(X)), asserta(contador(Y)).