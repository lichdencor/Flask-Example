# Imagen base liviana
FROM python:3.12-slim

# Crear un usuario sin privilegios
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Establecer directorio de trabajo
WORKDIR /app

# Copiar dependencias primero
COPY requirements.txt .

# Instalar dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el código de la app
COPY . .

# Ajustar permisos (necesario si luego se monta un volumen)
RUN chown -R appuser:appgroup /app

# Exponer puerto
EXPOSE 8000

# Variables de entorno
ENV PORT=8000
ENV FLASK_ENV=production
ENV PYTHONUNBUFFERED=1

# Cambiar al usuario no root
USER appuser

# Comando de inicio
CMD ["python", "run.py"]

