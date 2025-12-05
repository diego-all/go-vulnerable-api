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

Ahora probaremos el endpoint para eliminar productos. Recibe un parámetro id para seleccionar el producto a eliminar. Al igual que antes, se intenta provocar un error agregando una comilla simple al valor del id. Análogamente, se observa de nuevo una respuesta de error 500 del servidor. Se confirma que este nuevo endpoint, también es vulnerable a SQL Injection. La comilla simple rompió la consulta DELETE interna de la base de datos. Si la vulnerabilidad existe, se puede utilizar la misma lógica de explotación de antes, pero esta vez con consecuencias mas serías.
Vamos a inyectar el payload que añade una condición siempre verdadera: 'OR'1'='1. En la base de datos, la consulta original de eliminación (que sólo debería borrar el producto con id=4) se transforma en algo como: "Eliminar productos donde el id es 4, o donde verdadero es igual a verdadero". Dado que la condición '1'='1' es siempre verdadera, la consulta afectará a todos los registros de la tabla de productos. La respuesta del servidor es un código 200. !Se ha logrado eliminar todos los productos de la base de datos! Vamos a confirmarlo consultando el endpoint de listar productos.

- + - + - + - + [Imagen Ver el codigo comparativo para mostrar la mitigación] 

La causa raíz está aquí: el desarrollador concatenó el input del usuario directamente en la query usando una función vulnerable sin sanitizar. Esto permite manipular la lógica de la sentencia SQL. Veamos el código y su mitigación.

Hemos pasado de exfiltrar toda la información de la base de datos (afectando la Confidencialidad) a eliminar todos los registros (comprometiendo la Integridad y la Disponibilidad). Una simple falta de validación de entrada transformó un endpoint de consulta y uno de eliminación en un incidente de seguridad crítico.
La única defensa efectiva y duradera es el desarrollo seguro. Recuerda siempre: Utilizar consultas parametrizadas; Es el mecanismo que convierte el código malicioso en simples datos inofensivos.

Video base de datos postgres. select
- + - + - + - +










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













