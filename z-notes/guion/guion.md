# Guión

Definir contexto de la API: API de tienda de instrumentos musicales o libros.


## SQL Injection

Tenemos un reto, vamos a analizar una aplicacion vulnerable llamada Go-Vulnerable-API para identificar algunas vulnerabilidades. En un escenario real, se podria buscar la información de la API en la documentación proporcionada por la empresa para ahorrar tiempo y evitar buscar endpoints o generar alertas en los controles de seguridad.

(TiendaDeMusica)

Comencemos, analizando la documentacion o archivo swagger vemos que es una API de <instrumentosMusicales|Libros>, es claro existe una ruta para gestionar los instrumentos, analizaremos los endpoints con el fin de determinar si alguno es vulnerable a SQL Injection.

Considerar query param vs path param


- GetInstrumentByIDSQLiURLParam  La vulnerabilidad funciona por query param
- La API esta configurada como path params?


curl -k "localhost:8081/instruments/vulnerable-sqligetinst?id=1"

curl -k "localhost:8081/instruments/vulnerable-sqligetinst/1"



[Analisis]

bajo el supuesto 

curl "http://localhost:8081/instruments/vulnerable-sqligetinst?id=16'OR''='"



un endpoint escrito en Golang que sufre de SQL Injection."

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











