/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package codigo;

import java.awt.List;
import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author alexander
 */
public class conexion_consulta {

    static Connection conexion = null;
    static Statement sentencia;
    static ResultSet resultado;

    public static void conectar() {
        String ruta = "jdbc:mysql://localhost/dbprolog_project";
        String user = "root";
        String pass = "cisco";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conexion = DriverManager.getConnection(ruta, user, pass);
            sentencia = conexion.createStatement();
            System.out.println("Conectado");
        } catch (Exception e) {
            System.out.println("No conectado");
        }
    }

    public static void llenarDB() {
        String insertar = "";
        ArrayList<String> Lista_Lugar = new ArrayList<String>();
        Lista_Lugar.add("Tegucigalpa");
        Lista_Lugar.add("Tokio");
        Lista_Lugar.add("Madrid");
        Lista_Lugar.add("Paris");
        Lista_Lugar.add("Los Angeles");
        Lista_Lugar.add("Sidney");
        Lista_Lugar.add("Roma");
        Lista_Lugar.add("Hong Kong");
        Lista_Lugar.add("Costa Rica");
        Lista_Lugar.add("Ejipto");
        Lista_Lugar.add("Panama");
        Lista_Lugar.add("Canada");
        Lista_Lugar.add("Rio de Janeiro");
        Lista_Lugar.add("Manchester");
        Lista_Lugar.add("Berlin");
        Lista_Lugar.add("Taiwan");
        Lista_Lugar.add("Buenos Aires");
        
        ArrayList<String> Hora = new ArrayList<String>();
        Hora.add("06:00"); //13 items
        Hora.add("07:00");
        Hora.add("08:00");
        Hora.add("09:00");
        Hora.add("10:00");
        Hora.add("11:00");
        Hora.add("12:00");
        Hora.add("13:00");
        Hora.add("14:00");
        Hora.add("15:00");
        Hora.add("16:00");
        Hora.add("17:00");
        Hora.add("18:00");
        ArrayList<String> Precios = new ArrayList<String>();
        Precios.add("500");
        Precios.add("450");
        Precios.add("475");
        Precios.add("550");
        Precios.add("600");
        Precios.add("675");
        Precios.add("800");
        Precios.add("900");
        Precios.add("300");
        Precios.add("200");
        ArrayList<String> Aerolineas = new ArrayList<String>();
        Aerolineas.add("Taca");
        Aerolineas.add("Avianca");
        Aerolineas.add("United");
        Aerolineas.add("Emirates");
        Aerolineas.add("El Ingeniero");
        Aerolineas.add("Un puntito");
        Aerolineas.add("Delta");
        int elegir_origen, elegir_destino, elegir_salida, elegir_llegada, elegir_dia, elegir_aerolinea, elegir_precio, rango_hora;
        boolean seguir = true;
        for (int i = 1; i <= 1000; i++) {
            seguir = true;
            while (seguir) {
                elegir_origen = (int) (Math.random() * Lista_Lugar.size());
                elegir_destino = (int) (Math.random() * Lista_Lugar.size());
                elegir_salida = (int) (Math.random() * (Hora.size() - 2));
                rango_hora = Hora.size() - elegir_salida;
                elegir_llegada = (int) (Math.random() * rango_hora);
                elegir_llegada += elegir_salida;
                elegir_dia = (int) (Math.random() * 6) + 1;
                elegir_aerolinea = (int) (Math.random() * Aerolineas.size());
                elegir_precio = (int) (Math.random() * Precios.size());
                if (elegir_origen != elegir_destino) {
                    if (elegir_salida != elegir_llegada) {
                        insertar = "INSERT INTO vuelos VALUES('" + Lista_Lugar.get(elegir_origen) + "','"
                                + Lista_Lugar.get(elegir_destino) + "','"
                                + Hora.get(elegir_salida) + "','"
                                + Hora.get(elegir_llegada) + "','"
                                + String.valueOf(elegir_dia) + "','"
                                + Aerolineas.get(elegir_aerolinea) + "','"
                                + String.valueOf(i) + "','"
                                + Precios.get(elegir_precio) + "')";
                        ejecutar(insertar);
                        seguir = false;
                    }
                }
            }
        }
    }

    public static void ejecutar(String insertar) {
        try {
            sentencia.executeUpdate(insertar);
            System.out.println("Correcto");
        } catch (Exception e) {
            System.out.println("Error");
        }
    }

    public static variables buscar_reg(String Nombre) {
        variables r = null;
        String q = "SELECT * FROM Datos" + " WHERE Nombre='" + Nombre + "'";
        try {
            resultado = sentencia.executeQuery(q);
            System.out.println("Correcto");
        } catch (Exception e) {
            System.out.println(" No Correcto");
        }
        r = asignar();
        return r;

    }

    public static variables asignar() {
        variables r = null;
        String Nombre;
        String Apellido;
        try {
            if (resultado.last()) {
                Nombre = resultado.getString("Nombre");
                Apellido = resultado.getString("Apellido");
                r = new variables(Nombre, Apellido);
            }
        } catch (Exception e) {
        }

        return r;

    }
}
