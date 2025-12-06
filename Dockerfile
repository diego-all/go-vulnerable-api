# Usa una imagen base de Go directamente
FROM golang:1.23.2-alpine

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos go.mod y go.sum para descargar las dependencias
COPY go.mod .
COPY go.sum .
RUN go mod download

# *** CAMBIO CLAVE AQUÍ: Copiar los archivos de la API a su ubicación final ***
# Copia la carpeta cmd/api (que contiene main.go y routes.go) y las demás carpetas
COPY cmd/ ./cmd/
COPY handlers/ ./handlers/
COPY models/ ./models/
COPY db/ ./db/

#COPY cert/ ./cert/
#COPY cert/key.pem .

# Construye la aplicación Go
# La bandera -o especifica la ruta de salida. El binario se llamará 'api'
# y se colocará en el directorio raíz del contenedor /app
# El paquete a construir es ./cmd/api
RUN GOOS=linux go build -o api ./cmd/api

# Expone el puerto en el que la aplicación Go escuchará
EXPOSE 8081

# Comando para iniciar la aplicación cuando el contenedor se inicie
# *** CAMBIO CLAVE AQUÍ: Ejecutar el binario compilado 'api' ***
CMD ["./api"]