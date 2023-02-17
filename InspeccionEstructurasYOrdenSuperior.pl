/* 6.4. INSPECCIÓN DE ESTRUCTURAS Y ORDEN SUPERIOR

INSPECCIÓN DE ESTRUCTURAS

Existen predicados que nos permiten acceder tanto a los functores como a los argumentos de
cualquier término:

  functor(T,F,A) tiene éxito si el nombre del functor de T es F y además su aridad es A.
      -Puede usarse pasando T como entrada para que nos devuelva tanto F como A como salida
      -Puede usarse pasando F, A como entrada para que nos devuelva T como salida
      -Puede usarse pasando los tres parámetros de entrada
      
  arg(N,T,A) tiene éxito si el N-ésimo argumento del término T es A.
      -Puede usarse pasando N, T como entrada para que nos devuelva A como salida.
      -Puede usarse pasando los tres parámetros de entrada
      -En SWI también puede usarse pasando T como entrada para que devuelva N, A como salida
      
  T=..L tiene éxito si L es una lista que contiene como primer elemento el functor de T y como
  resto de elementos todos los argumentos de T.
      -Puede usarse pasando T como entrada para que nos devuelva L
      -Puede usarse pasando L como entrada para que nos devuelva T
      -Puede usarse pasando tanto T como L de entrada
      
ORDEN SUPERIOR

El predicado call/1 es la base para permitir introducir orden superior en Prolog.
call(X) evalúa el término X como se evaluaría cualquier objetivo, unificando variables si fuera preciso.      

¿Cómo sacamos partido de call/1 para el orden superior? Supongamos que dado un cierto predicado,
queremos ver si todos los elementos de una lista cumplen dicho predicado o no:
*/

todosCumplen(_,[]).
todosCumplen(P,[X|Xs]) :- Objetivo=..[P,X], call(Objetivo), todosCumplen(P,Xs). 
%En algunos entornos está permitido hacer directamente Objetivo=P(X)

/* 
La idea general para usar orden superior será usar =.. para construir el objetivo que queramos a partir
del functor que nos pasen como parámetro del predicado de orden superior, así como a partir de los parámetros
que tengamos que pasar a dicho predicado. Una vez construido el objetivo, lo invocamos.
*/ 


% Veamos otro ejemplo donde haremos algo equivalente al filter de Haskell: 
filter(_,[],[]).
filter(P,[X|Xs],[X|Ys]) :- Objetivo=..[P,X], call(Objetivo), !, filter(P,Xs,Ys).
filter(P,[_|Xs],Ys) :- filter(P,Xs,Ys).
% Nótese que el corte nos asegura que si llegamos a la tercera regla es porque estamos seguros de que no se cumplía P(X).

% Otro ejemplo:
takeWhile(P,[X|Xs],[X|Ys]) :- Objetivo=..[P,X], call(Objetivo), !, takeWhile(P,Xs,Ys).
takeWhile(_,_,[]).

hombre(anacleto).
hombre(bonifacio).
% Se puede probar filter(hombre,[anacleto,bonifacio,maria,bonifacio],L)