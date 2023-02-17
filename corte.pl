/* 6.3. CONTROL MEDIANTE CORTE Y NEGACIÓN

El predicado de corte es fundamental en Prolog, pero es un predicado impuro, es decir, 
está fuera de la programación lógica. 

-Es un predicado sin parámetros
-Se escribe !
-Siempre tiene éxito
-Como efecto lateral "poda" alternativas del árbol de búsqueda

Supongamos que tenemos algo así como

predicado :- ...
predicado :- p1, p2, ..., pn, !, q1, q2, ..., qm.
predicado :- ...

Si intentamos evaluar predicado, todo funcionará como habitualmente, haciendo backtracking
si hiciera falta tanto con la primera regla como con los pasos pi de la segunda regla. 
Ahora bien, si llegamos al corte, entonces descartaríamos todas las reglas relativas a 
predicado que vengan después (en nuestro ejemplo, la tercera regla) e impediríamos que el
backtracking volviera a las pi o a las reglas anteriores correspondientes a predicado.

Podemos interpretar el corte como una compuerta que es trivial de pasar de izquierda a derecha
(siempre tiene éxito) pero que es imposible de pasar de derecha a izquierda (una vez que la 
cruzamos, ya no podemos dar marcha atrás para probar otras alternativas).

Cabe destacar que una vez cruzada la compuerta del corte, sí podremos seguir haciendo 
backtracking entre las qi, probando tantas alternativas como haga falta entre las qi, pero
no podemos volver a antes del corte.

*/

%Recordemos el problema que vimos anteriormente que generaba más soluciones de la cuenta.
%Ahora podemos asegurarnos de que la última regla solo se aplica si X no es un número:
sumaNumeros([],0).
sumaNumeros([X|Xs],Z) :- number(X), !, sumaNumeros(Xs,Y), Z is X+Y.
sumaNumeros([_|Xs],Z) :- sumaNumeros(Xs,Z).

%Nos puede valer para no seguir probando opciones si sabemos que no será necesario:
maximo(X,Y,X) :- X>Y, !.
maximo(X,Y,Y) :- X=<Y.

%Pero debemos tener mucho cuidado para no hacer cosas incorrectas como la siguiente:
max(X,Y,X) :- X>Y, !.
max(X,Y,Y).
%que nos daría un resultado incorrecto en algunas situaciones en las que instanciamos
%los tres parámetros, por ejemplo: ?max(2,1,1). nos devolvería que es cierto.

/* En general, el corte nos permitirá reducir considerablemente los árboles de búsqueda,
y nos facilitará determinadas tareas, pero deberemos ser muy cuidadosos porque nos cambiará
radicalmente el comportamiento de nuestros programas. 

Por ejemplo, supongamos que queremos reescribir el predicado que nos decía si un elemento
pertenecía a una lista, de modo que no queramos seguir buscando en cuanto hayamos encontrado
que sí pertenece. Entonces podremos hacer lo siguiente:
*/

pertenece(X,[X|Xs]) :- !.
pertenece(X,[_|Xs]) :- pertenece(X,Xs).

/* Ahora bien, el predicado anterior valdrá para ver si un elemento pertenece a una lista,
pero  si preguntamos
? pertenece(X,[1,2,3]),pertenece(X,[2,3]).
nos devolverá que no, porque en cuanto el primer pertenece encuentra que con X=1 se satisface,
ya no se permite probar con otro valor para la X, así que no llegamos a probar con X=2, que 
sería el primer valor que cumpliría los dos pertenece. */


