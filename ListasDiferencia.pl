/*  6.8 LISTAS DIFERENCIA

En Prolog se pueden usar "estructuras incompletas" para mejorar la eficiencia de algunos programas.
El ejemplo típico de estructura incompleta es la definición y uso de listas diferencia.
La idea básica es aprovechar las variables lógicas para representar punteros a partes aún no definidas.

Recordemos la definición de append para concatenar listas:  
*/

concatenar([],Ys,Ys).
concatenar([X|Xs],Ys,[X|Zs]) :- concatenar(Xs,Ys,Zs).

/*
La definición anterior funciona perfectamente. Ahora bien, supongamos que queremos concatenar una primera
lista de 1000 elementos con otra de 10. Para ello, la definición que hemos dado tendrá que dar 1000 pasos 
para ir procesando todos los elementos de la primera lista.
¿Sería posible hacerlo (mucho) más rápido?
En imperativo, la idea pasaría por representar las listas de otra forma, teniendo acceso no solo al primer
elemento de la lista, también al último (usando un puntero para acceder a cada extremo de la lista). 
Si tenemos esa opción, para concatenar dos listas solo tenemos que dar un paso para acceder al último elemento,
luego enlazar el último elemento de la primera lista con el primero de la segunda y finalmente indicar que el
nuevo final de la lista es el que antes era el final de la segunda lista.

En Prolog podemos hacer algo parecido, usando una variable lógica abierta a modo de puntero (aunque realmente
no es un puntero) a través del cual completar el resto de la lista. Dicha variable irá al final de la lista,
como si la lista no estuviera completamente definida (porque de hecho no está completamente definida).
Una lista diferencia se representará como un par donde el primer elemento es la lista completa y el segundo
elemento es la parte final de la lista que todavía está "abierta":
   ([a,b,c,d|Resto),Resto)
Nótese que si ahora unificamos Resto con cualquier lista, por ejemplo, [e,f], no necesitamos recorrer la lista
[a,b,c,d] para llegar hasta Resto, porque ya tenemos acceso directo a Resto. Así pues, directamente obtendríamos
   ([a,b,c,d,e,f],[e,f])
de forma más rápida que con append.

Normalmente representaremos listas diferencia como L-R o como L\R, siendo L la lista completa y R el "hueco" para
completar el resto de la lista.

Veamos cómo hacer la concatenación de listas diferencia:
*/

appendDif(L1-R1,L2-R2,L3-R3) :- R1=L2, L3=L1, R3=R2.

% O más corto todavía:

otroAppendDif(L1-R1,R1-R2,L1-R2).

% Podéis probarlo con appendDif([1,2,3|X]-X,[4,5|Y]-Y,L-R).


/*
Recordemos que no podemos usar appendDif ni otroAppendDif con listas normales, porque solo está definido para
listas diferencias, no para listas. Ahora bien, podemos convertir las listas diferencia en listas normales, 
unificando el resto de la lista con []. Es decir, si unificamos [a,b,c|R]-R con L-R nos queda en L una lista
normal [a,b,c].
Y las listas normales también las podemos convertir en listas diferencia:
*/

listaAListaDif([],L-L).
listaAListaDif([X|Xs],[X|Y]-Z) :- listaAListaDif(Xs,Y-Z).
% Probadlo con listaAListaDif([1,2,3,4],L-R).

/* Como ejemplo final, supongamos que queremos hacer una rotación de modo que el primer elemento de la lista
pase a ser el último. Con listas normales tendríamos que hacer algo así: */

rotacion([],[]).
rotacion([X|Xs],Ys) :- append(Xs,[X],Ys).

/* Que lógicamente tiene coste O(n) porque requiere pasar por todos los elementos de la lista para añadir 
uno al final. Sin embargo, con listas diferencia tendría coste O(1): */

rotacionDif(L-L,L-L) :- var(L), !.
rotacionDif([X|Xs]-R,Xs-R1) :- R=[X|R1].
% Probadlo con rotacionDif([1,2,3,4|R]-R,L-M).

/* O incluso más corto: */

otraRotacionDif(L-L,L-L) :- var(L), !.
otraRotacionDif([X|Xs]-[X|R1],Xs-R1).
