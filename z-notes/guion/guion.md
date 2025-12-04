# Guión Pruebas de Seguridad

Pendiente: Definir contexto de la API: API de tienda de instrumentos musicales o libros.

## SQL Injection

Tenemos un reto, vamos a analizar una aplicación vulnerable llamada Go-Vulnerable-API para identificar algunas vulnerabilidades. 


En un escenario real, se podria buscar la información de la API en la documentación proporcionada por la empresa para ahorrar tiempo y evitar buscar endpoints o generar alertas en los controles de seguridad.

(TiendaDeMusica)

Comencemos, analizando la documentacion o archivo swagger vemos que es una API de <instrumentosMusicales|Libros>, es claro existe una ruta para gestionar los instrumentos, analizaremos los endpoints con el fin de determinar si alguno es vulnerable a SQL Injection.

Inicialmente validaremos los endpoints de consulta, y funcionan con normalidad. [DESDE POSTMAN]

Ahora analicemos con burpsuite las solicitudes y respuestas para ver que encontramos. Tomemos el endpoint de listar instrumento porID (GetInstrumentByID)
Funciona bien, ¿Que pasa si agregamos una comilla simple?

Observemos el error del servidor, es un codigo 500 es un mal indicio. Un valor o caracter invalido no debería hacer fallar el servidor internamente. Además el mensaje muestra un error directamente desde la base de datos, [ERROR: unterminated quoted string at or near "'5''"]

Este mensaje significa que la comilla rompió la consulta SQL. El código del servidor tomó la entrada (es decir el número 5 junto con la comilla simple) y la pegó directamente en la consulta de la DB, sin limpiarla ni validarla.

Ademas si agregamos los caracteres de comentario SQL en la solicitud al final (--) le indican al motor de la base de datos que ignore todo el texto restante en esa linea de la consulta. Vemos como funciona de nuevo correctamente la consulta. Este paso fue fundamental para corroborar que estamos ante una vulnerabilidad SQL Injection, ya que se ha logrado manipular la estructura de la consulta original para que funcione.

[VISUALIZAR CONSULTA A NIVEL DE DE BASE DE DATOS O IMAGEN]

Este error nos confirma dos cosas:

1. Hay una vulnerabilidad de SQl Injection. El usuario puede manipular la consulta a la base de datos.

2. Se están exponiendo errores internos de la base de datos (como el SQLSTATE 42601).

Ahora intentemos manipular la consulta para extraer informacion de la base de datos, vamos a agregar


Si el comentario confirma la vulnerabilidad, el siguiente payload la explota por completo.  5' OR '1'='1. Se inyecta una condicion clasica para ataques de este tipo que siempre es verdadera ('1'='1'). En la base de datos, la consulta ahora lee: "dame los instrumentos donde el id es 5, o donde verdadero es igual a verdadero".

En lugar de un solo instrumento, se obtienen todos los registros de la tabla. Se evadio al filtro del id y se accedio a todos los datos. [JSON de la respuesta con todos los registros].

Esto nos confirma una vulnerabilidad de inyeccion SQL critica. ! La unica defensa es el código seguro con Consultas parametrizadas!.


VALOR VER EL CODIGO:

Mostrar la mitigacion.



- GetInstrumentByIDSQLiURLParam  La vulnerabilidad funciona por query param
- La API esta configurada como path params?


curl -k "localhost:8081/instruments/vulnerable-sqligetinst?id=1"

curl -k "localhost:8081/instruments/vulnerable-sqligetinst/1"


Considerar query param vs path param



[Analisis]

curl "http://localhost:8081/instruments/vulnerable-sqligetinst?id=16'OR''='"


El error fundamental está aquí: el desarrollador concatenó el input del usuario directamente en la query usando fmt.Sprintf sin sanitizar. Esto permite manipular la lógica de la sentencia SQL."


Exfiltracion de Datos 


Se utiliza el endpoint de para volcar la base de datos (obtener la informacion) **Confidencialidad**

    - payload1


Ahora finalmente el usuario tiene malas intenciones y decide borrar los registros. **Integridad|Disponibilidad**

    - payload2


curl -k -X DELETE "http://localhost:8081/instruments/vulnerable-sqli?id=16'OR''='"



- Los datos se han perdido permanentemente."

- Para prevenir esto en el SDLC, nunca concate strings. Utilicen siempre consultas parametrizadas en sus controladores de Go.




## IDOR


- Requiere crea endpoint de submit, 


contexto
propietario del libro

/books/v1 ??











