# Guión Pruebas de Seguridad

Pendiente: Definir contexto de la API: API de tienda de instrumentos musicales o libros.



('OR'1'='1)
## SQL Injection

Tenemos un reto, vamos a analizar una aplicación vulnerable llamada Go-Vulnerable-API para identificar algunos riesgos de seguridad.Podríamos utilizar alguna herramienta para buscar los endpoints de la API, pero aprovechemos la documentación que nos suministran. Comencemos, analizando el archivo Swagger se trata de una API de un comercio, existe una ruta para gestionar los productos. Al validar los endpoints de consulta desde Postman, funcionan con normalidad y retornan la información solicitada. 

Ahora analicemos con Burpsuite las solicitudes y respuestas, veamos que encontramos. Tomemos el endpoint de listar producto por ID. Funciona bien, ¿Que pasa si agregamos una comilla simple a la solicitud? Observemos el error del servidor, un código 500 es un mal indicio. Un valor o carácter inválido no debería hacer fallar el servidor internamente. Además el mensaje muestra un error directamente desde la base de datos: [ERROR: unterminated quoted string at or near "'5''"]

Este mensaje significa que la comilla rompió la consulta SQL. El código del servidor tomó la entrada (es decir el número 5 junto con la comilla simple) y la pegó directamente en la consulta hacia la base de datos, sin sanitizarla ni validarla. Además si agregamos los caracteres de comentario sql (--) al final de la solicitud, se le indica al motor de la base de datos que ignore todo el texto restante en esa línea de la query; Ahora vemos como funciona correctamente la consulta de nuevo. Hemos corroborado que estamos ante una vulnerabilidad SQL Injection, ya que se ha logrado manipular la estructura de la consulta original para que funcione de otra manera.

Este error nos confirma dos cosas:
1. Hay una vulnerabilidad de SQL Injection. Es posible manipular la consulta a la base de datos.
2. Se están exponiendo errores internos de la base de datos (como el SQLSTATE 42601).

Ahora intentemos manipular la consulta para extraer información de la base de datos. Si el comentario confirma la vulnerabilidad, el siguiente payload la explota por completo. Se inyecta una condicion clásica para ataques de este tipo con OR que siempre es verdadera ('1'='1'). En la base de datos, la consulta ahora se interpreta asi: "retorna los productos donde el id es 5, o donde verdadero es igual a verdadero". En lugar de un solo producto, se obtienen todos los registros de la tabla. Se evadió el filtro del id y se accedió a todos los datos. Esto nos confirma una vulnerabilidad de SQL injection crítica. 

- + - + - + - + [Imagen Ver el codigo comparativo para mostrar la mitigación] 

El error fundamental está aquí: el desarrollador concatenó el input del usuario directamente en la query usando una función vulnerable sin sanitizar. Esto permite manipular la lógica de la sentencia SQL. Veamos el código.


Ahora probaremos el endpoint para eliminar productos. 






Los datos se han perdido permanentemente.
Para prevenir esto en el SDLC, nunca concate strings. Utilicen siempre consultas parametrizadas en sus controladores de Go.

Exfiltracion de Datos 
Se utiliza el endpoint de para volcar la base de datos (obtener la informacion) **Confidencialidad**
!La unica defensa es el código seguro con Consultas parametrizadas!.



Ahora finalmente el usuario tiene malas intenciones y decide borrar los registros. **Integridad|Disponibilidad**

    - payload2


curl -k -X DELETE "http://localhost:8081/instruments/vulnerable-sqli?id=16'OR''='"




- GetInstrumentByIDSQLiURLParam  La vulnerabilidad funciona por query param
- La API esta configurada como path params?
Considerar query param vs path param

curl -k "localhost:8081/instruments/vulnerable-sqligetinst?id=1"
curl -k "localhost:8081/instruments/vulnerable-sqligetinst/1"

curl "http://localhost:8081/instruments/vulnerable-sqligetinst?id=16'OR''='"


## IDOR


- Requiere crea endpoint de submit, 


contexto
propietario del libro
/books/v1 ??
cambio de instruments a products
cualquier entidad con usuarios.













