# Requests

- curl -X GET http://localhost:8080/instruments

- curl -X GET http://localhost:8080/instruments/1

-  curl -X POST http://localhost:8081/instruments -H "Content-Type: application/json" -d '{"name": "Guitarra", "description": "Instrumento de cuerda", "price": 450.0}'

- curl -X PUT http://localhost:8081/instruments/26 -H "Content-Type: application/json" -d '{"name": "Guitarra Acústica", "description": "6 cuerdas, madera de abeto", "price": 500.0}'

- curl -X DELETE http://localhost:8081/instruments/1
