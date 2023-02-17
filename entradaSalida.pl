/*  6.7 ENTRADA/SALIDA

Los predicados más básicos de Prolog para realizar entrada/salida son los siguientes:

  read(T) lee un término de la entrada estándar y lo unifica con T. El término debe escribirse acabando con un punto.
  write(T) escribe el término T en la salida estándar
  display(T) escribe el término T en la salida estándar
  writeq(T) y displayq(T) también escriben en la salida estándar pero añaden comillas si hace falta
  nl escribe un salto de línea
  
*/

buscaProgenitor :- write('Dime el nombre del hijo: '), read(H), nl, progenitor(P,H), write('Su progenitor es '),
                   write(P), nl.

progenitor(luis,maria).
progenitor(ana,maria).
progenitor(luis,alberto).
progenitor(ana,alberto).
progenitor(maria,carlos).
progenitor(juan,carlos).

/*
Para leer y escribir en fichero, una forma sencilla es modificar la entrada estándar y/o la salida estándar
para que sean el fichero que queramos.
  
   see(Archivo) hace que a partir de ahora todas las lecturas de la entrada estándar (ejem read(T)) se hagan desde Archivo
   seeing(Archivo) devuelve en Archivo cuál es el archivo que se está usando ahora como entrada estándar (devuelve
                   user si se está usando realmente la entrada estándar)
   seen/0 cierra la entrada estándar actual, dejando como entrada estándar la que tuviéramos antes del último see/1
   tell(Archivo) hace que a partir de ahora todas las escrituras de la entrada estándar se hagan a Archivo
   telling(Archivo) devuelve en Archivo cuál es el archivo que se está usando ahora como salida estándar (user si estándar real)
   told/0 cierra la salida estándar actual, dejando como salida estándar la que tuviéramos antes del último tell/1
   
*/


escribeEnFichero :- write('Dime nombre de fichero:'), read(Nombre), tell(Nombre), write('Estoy escribiendo'), told,
                    writeq('Y ahora escribo en la pantalla').
                    
/* 
También es posible abrir varios ficheros de lectura o varios de escritura sin necesidad de perder acceso a la
entrada o a la salida estándar. Como en la mayor parte de lenguajes, existen predicados para abrir fichero, para
leer o escribir de fichero y para cerrar fichero:

   open(Fichero,Modo,Acceso) abre el fichero Fichero en modo Modo (que puede ser read, write o append). Fichero y Modo
                             deben ser datos de entrada. Devuelve en Acceso acceso al fichero, que podrá usarse con los
                             siguientes predicados.
   read(Acceso,Termino) write(Acceso,Termino) nl(Acceso) se comportan como read, write, nl pero leyendo del fichero 
                             al que tenemos acceso a través de Acceso
   close(Acceso) cierra el acceso al fichero Acceso
   
*/

otroEscribeTablaEnFichero:-open('tabla2.txt',write,F), (tabla(F,[1,2,3,4,5,6,7,8,9,10]);close(F)).

escribeTablaEnFichero:-open('tabla.txt',write,F), escribeCon(F).
escribeCon(F):-tabla(F,[1,2,3,4,5,6,7,8,9,10]).
escribeCon(F):-close(F).
tabla(F,L):-member(X,L), member(Y,L), Z is X*Y, write(F,X*Y=Z), nl(F), fail.   