# Usar una imagen base oficial de Python 3.10
FROM python:3.10

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Instalar las librerías del sistema necesarias para OpenCV, Xvfb y utilidades X11
RUN apt-get update && \
    apt-get install -y libgl1 libglib2.0-0 xvfb x11-xserver-utils

# Copiar el archivo de requerimientos al contenedor
COPY requirements.txt .

# Instalar las dependencias del proyecto
RUN pip install --no-cache-dir --default-timeout=100 -r requirements.txt

# Copiar el resto de los archivos del proyecto al contenedor
COPY . .

# Establecer la variable de entorno para el servidor X virtual
ENV DISPLAY=:99

# Iniciar Xvfb con autenticación y ejecutar la aplicación
CMD ["sh", "-c", "Xvfb :99 -screen 0 1024x768x16 & touch /root/.Xauthority && python main.py"]
