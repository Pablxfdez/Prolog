% 6.1 PREDICADOS ARITMÉTICOS EN PROLOG
%
% La aritmética de Prolog se sale de la programación lógica pura
% El elemento clave es el predicado no reversible is/2 que requiere
% que el segundo parámetro esté instanciado antes de llamar a is

factorial(0,1).
factorial(N,F) :- N>0, N1 is N-1, factorial(N1,F1), F is N*F1.

% Dado que is requiere que (N-1) esté instanciado, factorial requerirá que N esté instanciado 
% por lo que factorial tampoco será reversible. Lo mismo pasará con los siguientes ejemplos.

incrementarTodos([],[]).
incrementarTodos([X|Xs],[X1|Ys]) :- X1 is X+1, incrementarTodos(Xs,Ys).

take(0,_,[]).
take(_,[],[]).
take(N,[X|Xs],[X|Ys]) :- N>0, N1 is N-1, take(N1,Xs,Ys).

sumaVectores([],[],[]).
sumaVectores(([X|Xs],[Y|Ys],[Z|Zs]) :- Z is X+Y, sumaVectores(Xs,Ys,Zs).