#imagen a instalar
FROM python:3.9

#usamos el directorio de trabajo
WORKDIR /src/TCA

#ESTABLECER VARIABLES DEL ENTORNO 
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

#ACTUALIZAR PIP
RUN pip install --upgrade pip

#actualizar e instalar mysql
RUN apt-get update && apt-get install -y gcc libpq-dev python3-dev musl-dev libmariadb-dev mariadb-client


RUN apt-get install -y locales locales-all
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

#Copiar el proyecto entero
COPY . /src/TCA

#Copiar los requisitos del sistema
# COPY ./req.txt ./
#instalar dependencias 
RUN pip install -r req.txt

# RUN pip install google-cloud-storage

#se crea el directorio para los archivos Staticos de django
# RUN mkdir /static

VOLUME /usr/TCA/data

EXPOSE 8080

# RUN echo $GOOGLE_APPLICATION_CREDENTIALS
#se ejecuta el archivo
#ENTRYPOINT ["/usr/src/django_proj/entrypoint.sh"]
# RUN python manage.py collectstatic --noinput

CMD python manage.py runserver 0.0.0.0:8080
# CMD gunicorn --bind 0.0.0.0:8080 tablero_control.wsgi