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
    odbc_query('prolog','SELECT * FROM vuelos',F).

eliminar_registro(F):-
    odbc_query('prolog','DELETE FROM vuelos WHERE vuelo = "1002"',F).

actualizar_registro(F):-
    odbc_query('prolog','UPDATE vuelos set aerolinea = "un puntito ingeniero" WHERE vuelo = "1001"',F).

