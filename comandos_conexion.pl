abrir_conexion:-
    odbc_connect('MSProlog2',_,
                [user(root),
                password('cisco'),
                alias(prolog),
                open(once)]).
cerrar_conexion:-
    odbc_disconnect('prolog').

ingresar_registro1(F):-
    odbc_query('prolog','INSERT INTO vuelos
    VALUES("Mi Casa","Universidad","16:00","17:00","3","El Ingeniero","1001","900")',affected(F)).

ingresar_registro2(F):-
    odbc_query('prolog','INSERT INTO vuelos
    VALUES("Mi Casa","Universidad","16:00","17:00","3","El Ingeniero","1002","900")',affected(F)).

consultar_registro(F):-
    odbc_query('prolog','SELECT * FROM vuelos WHERE origen = "tegucigalpa" && destino = "madrid" ORDER BY precio',F).

eliminar_registro(F):-
    odbc_query('prolog','DELETE FROM vuelos WHERE vuelo = "1002"',F).

actualizar_registro(F):-
    odbc_query('prolog','UPDATE vuelos set aerolinea = "un puntito ingeniero" WHERE vuelo = "1001"',F).

lugares:-
    write('Lugares: '),nl,
    write('Tegucigalpa'),nl,
    write('Tokio'),nl,
    write('Madrid'),nl,
    write('Paris'),nl,
    write('Texas'),nl,
    write('Sidney'),nl,
    write('Roma'),nl,
    write('Pekin'),nl,
    write('CostaRica'),nl,
    write('Ejipto'),nl,
    write('Panama'),nl,
    write('Canada'),nl,
    write('Janeiro'),nl,
    write('Manchester'),nl,
    write('Berlin'),nl,
    write('Taiwan'),nl,
    write('BuenosAires'),nl,nl.

aerolineas:-
    nl,
    write('Aerolineas: '),nl,
    write('Taca'),nl,
    write('Avianca'),nl,
    write('United'),nl,
    write('Emirates'),nl,
    write('El_Ingeniero'),nl,
    write('Un_Puntito'),nl,
    write('Delta'),nl,nl.

viaje_corto(ListaF,ListaG):-
    lugares,aerolineas,
    write('Elija el Origen:'),tab(1),
    read(Origen),
    atom_concat('SELECT * FROM vuelos',' WHERE origen ="',String0),
    atom_concat(String0,Origen,String1),
    atom_concat(String1,'" && destino ="',String2),nl,
    write('Elija Escala: '),
    read(Escala),
    atom_concat(String2, Escala, String3),
    write('Elija la Aerolinea: '),
    read(Aerolinea),
    atom_concat(String3, '" && aerolinea = "',String4),
    atom_concat(String4, Aerolinea, String5),
    atom_concat(String5,'" ORDER BY dia,precio DESC,llegada LIMIT 1', StringFinal),
    odbc_query('prolog',StringFinal,ListaF),nl,
    write('Elija Destino: '),
    read(Destino),
    atom_concat(String0,Escala,String6),
    atom_concat(String6, '" && destino ="',String7),
    atom_concat(String7,Destino,String8),
    atom_concat(String8, '" && aerolinea = "',String9),
    atom_concat(String9, Aerolinea,String10),
    atom_concat(String10,'" && dia != "1" ORDER BY dia,precio DESC,llegada LIMIT 1',StringFinal2),
    odbc_query('prolog',StringFinal2,ListaG).

viaje_barato(ListaF,ListaG):-
    lugares,aerolineas,
    write('Elija el Origen:'),tab(1),
    read(Origen),
    atom_concat('SELECT * FROM vuelos',' WHERE origen ="',String0),
    atom_concat(String0,Origen,String1),
    atom_concat(String1,'" && destino ="',String2),nl,
    write('Elija Escala: '),
    read(Escala),
    atom_concat(String2, Escala, String3),
    write('Elija la Aerolinea: '),
    read(Aerolinea),
    atom_concat(String3, '" && aerolinea = "',String4),
    atom_concat(String4, Aerolinea, String5),
    atom_concat(String5,'" ORDER BY precio,dia DESC LIMIT 1', StringFinal),
    odbc_query('prolog',StringFinal,ListaF),nl,
    write('Elija Destino: '),
    read(Destino),
    atom_concat(String0,Escala,String6),
    atom_concat(String6, '" && destino ="',String7),
    atom_concat(String7,Destino,String8),
    atom_concat(String8, '" && aerolinea = "',String9),
    atom_concat(String9, Aerolinea,String10),
    atom_concat(String10,'" && dia != "1" ORDER BY precio,dia DESC LIMIT 1',StringFinal2),
    odbc_query('prolog',StringFinal2,ListaG).


