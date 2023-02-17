/*  NEGACIÓN POR FALLO

¿Es posible definir un predicado que se comporte como la negación de otro?
NO, pero podemos hacer algo parecido sacando partido tanto del corte como del
predicado predefinido fail/0 que siempre falla:

p(X) :- q(X), !, fail.
p(_).

Si q(X) tiene éxito, entonces ponemos un corte para no poder dar marcha atrás,
pero justo después de eliminar el resto de opciones gracias a dicho corte, decimos
explícitamente que queremos fallar, por lo que p(X) fallará.

Si q(X) TERMINA sin tener éxito, entonces la primera regla falla sin llegar al
corte, por lo que sigue probando con la segunda regla, que sí que tiene éxito, por
lo que p(X) resulta que sí tiene éxito.

Nótese que si q(X) no termina, entonces p(X) tampoco termina. Por eso, p no es
exactamente la negación de q. La negación por fallo es una aproximación a la negación
lógica, PERO NO ES LA NEGACIÓN LÓGICA.


Podemos generalizar la idea si usamos el predicado call, que permite invocar un 
objetivo desde el programa:

not(Objetivo) :- call(Objetivo), !, fail.
not(_).

Nótese que la negación por fallo nunca puede instanciar variables, lo cual tiene
implicaciones a la hora de usarlo. Veamos un ejemplo:
*/


adulto(anacleto).
hombre(anacleto).
hombre(bonifacio).

hombreYMenor(X) :- hombre(X), not(adulto(X)).

menorYHombre(X) :- not(adulto(X)), hombre(X).

/* 
menorYHombre y hombreYMenor se comportan igual si el parámetro de entrada ya está completamente
instanciado. Ahora bien, menorYHombre se comporta de forma muy diferente a hombreYMenor si el parámetro
es una variable libre.

hombreYMenor(X) se interpreta como: hay un hombre X que además no es adulto,
que en nuestro caso se cumple con X=bonifacio

Ahora bien, menorYHombre(X) se interpreta como: no hay ningún adulto, y además hay un hombre,
pero como sí que hay al menos un adulto (anacleto), entonces menorYHombre(X) falla.
*/