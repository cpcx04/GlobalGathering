# GlobalGathering
<p align="center">
  <img src="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/fondo.png" alt="GLOBAL GATHERING" width="300"/>
</p>
> Globar Gathering para viajar acompañado - Divertido y económico
</br>
</br>
</br>

## 🚩 Table of Contents

- [Descripción](#-descripcion)
- [Por qué Global Gathering?](#-why-global-gathering)
- [Estado](#-estado)
- [Ejemplo de uso](#-USO)
- [Despliegue](#-despliegue)
- [Tecnologias](#-tecnologias)
- [Personas desarrolladoras](#-colaboradores)
- [Licencia](#-licencia)

## 📘 Descripcion
### Spring Boot Dependecy

| Nombre | Descripción |
| --- | --- |
| [spring-boot-starter-data-jpa](https://docs.spring.io/spring-boot/docs/current/reference/html/using.html#using.build-systems.dependencies.starter) | Inicio para usar Spring Data JPA con Hibernate. |
| [spring-boot-starter-validation](https://docs.spring.io/spring-boot/docs/current/reference/html/using.html#using.build-systems.dependencies.starter) | Inicio para utilizar la validación de Java Bean con Hibernate Validator. |
| [spring-boot-starter-web](https://docs.spring.io/spring-boot/docs/current/reference/html/using.html#using.build-systems.dependencies.starter) | Inicio para construir aplicaciones web con Spring MVC. |
| [spring-boot-starter-security](https://docs.spring.io/spring-boot/docs/current/reference/html/using.html#using.build-systems.dependencies.starter) | Inicio para usar Spring Security. |
| [spring-security-test](https://docs.spring.io/spring-security/site/docs/current/reference/html5/#test) | Soporte de prueba para Spring Security. |
| [h2](https://www.h2database.com/html/main.html) | H2 Database, una base de datos en memoria. |
| [postgresql](https://jdbc.postgresql.org/) | Controlador JDBC para PostgreSQL. |
| [lombok](https://projectlombok.org/) | Lombok, una biblioteca para simplificar el código Java. |
| [jjwt-api](https://github.com/jwtk/jjwt) | Java JWT: Token Web JSON para Java y Android. |
| [jjwt-impl](https://github.com/jwtk/jjwt) | Implementación de Java JWT: Token Web JSON para Java y Android. |
| [jjwt-jackson](https://github.com/jwtk/jjwt) | Implementación de Jackson para Java JWT: Token Web JSON para Java y Android. |
| [spring-boot-starter-test](https://docs.spring.io/spring-boot/docs/current/reference/html/using.html#using.build-systems.dependencies.starter) | Inicio para probar aplicaciones Spring Boot. |
| [springdoc-openapi-starter-webmvc-ui](https://springdoc.org/) | Springdoc OpenAPI UI para Spring Web MVC. |
| [swagger-annotations-jakarta](https://swagger.io/specification/) | Anotaciones Swagger para Jakarta API. |

### Características Principales

- **Descubrimiento de Eventos:** Explora una amplia gama de eventos categorizados por temas, ubicación y fecha.
- **Creación de Eventos:** Organiza y anuncia tus propios eventos, ya sea una conferencia, una reunión social o una actividad local.
- **Interacción Global:** Conecta con participantes de todo el mundo a través de salas de chat, transmisiones en vivo y funciones interactivas.
- **Seguridad y Autenticación:** Garantizamos la seguridad de los usuarios mediante autenticación segura y encriptación de datos.
- **Perfil Personalizado:** Crea un perfil único, destacando tus intereses, eventos pasados y contribuciones a la comunidad.

### Objetivos

- Facilitar la conexión entre personas con intereses comunes.
- Romper las barreras geográficas y fomentar la colaboración global.
- Proporcionar una plataforma segura y fácil de usar para la organización de eventos.


## 🌐 Por qué Global Gathering?

- **Descubrimiento de Eventos:** Explora una amplia gama de eventos categorizados por temas, ubicación y fecha.
- **Creación de Eventos:** Organiza y anuncia tus propios eventos, ya sea una conferencia, una reunión social o una actividad local.
- **Interacción Global:** Conecta con participantes de todo el mundo a través de salas de chat, transmisiones en vivo y funciones interactivas.
- **Seguridad y Autenticación:** Garantizamos la seguridad de los usuarios mediante autenticación segura y encriptación de datos.
- **Perfil Personalizado:** Crea un perfil único, destacando tus intereses, eventos pasados y contribuciones a la comunidad.


## 🚀 Estado

Actualmente en desarrollo activo. 
Hasta el momento las funcionalidades de las cuales goza mi proyecto son los siguiente ; 

# ClientController API

Este controlador maneja las operaciones relacionadas con los usuarios en la aplicación Global Gathering.

## Registro de Usuario

Registra un nuevo usuario en la aplicación.

**URL:** `/auth/register`

**Método:** `POST`

**Parámetros del cuerpo de la solicitud:**
- `username`: Nombre de usuario del cliente.
- `password`: Contraseña del cliente.
- `email`: Correo electrónico del cliente.
- `nombre`: Nombre completo del cliente.

**Respuestas:**
- 201 Created: Registro exitoso. Devuelve los detalles del usuario y un token JWT.
- 400 Bad Request: Error en la solicitud.

Ejemplo de cuerpo de solicitud:
```json
{
  "username": "cristian",
  "password": "contrasena123",
  "email": "cristian@gmail.com",
  "nombre": "Cristian Pulido"
}
```
### Autenticación de Usuario
Autentica al usuario y genera un token JWT.

**URL:** `/auth/login`

**Método:** `POST`

**Parámetros del cuerpo de la solicitud:**

`username`: Nombre de usuario del cliente.
`password`: Contraseña del cliente.
**Respuestas:**

- 201 Created: Autenticación exitosa. Devuelve los detalles del usuario y un token JWT.
- 400 Bad Request: Credenciales inválidas.
Ejemplo de cuerpo de solicitud:

```json
{
  "username": "cristian",
  "password": "contrasena123"
}
```
### Control de Comentarios

- **Listar Comentarios:**
  - Método: `GET /comments/singleComments`
  - Descripción: Obtiene una lista de comentarios individuales.
  - Ejemplo de Respuesta:
    ```json
    [
      {
        "avatar": "enlace_avatar",
        "username": "cristianpc",
        "content": "Los mejores 20 euros invertidos en mi vida fueron la excursión al parque de bolas"
      },
      {
        "avatar": "enlace_avatar",
        "username": "cristianpc",
        "content": "El viaje a Croacia nos ayudó a desconectar #CroaciaMola #Trips"
      }
    ]
    ```

- **Agregar Comentario:**
  - Método: `POST /comments/new`
  - Descripción: Crea un nuevo comentario.
  - Ejemplo de Solicitud:
    ```json
    {
      "avatar": "enlace_avatar",
      "username": "cristianpc",
      "content": "Me parece increíble la calva de Pedro"
    }
    ```
  - Ejemplo de Respuesta:
    ```json
    {
      "avatar": "enlace_avatar",
      "username": "cristianpc",
      "content": "Me parece increíble la calva de Pedro"
    }
    ```
- **Eliminar Comentario:**
  - Método: `DELETE /comments/delete`
  - Descripción: Elimina un comentario.
  - Devuelve un no content
### Control de Eventos

- **Listar Eventos:**
  - Método: `GET /event/allEvents`
  - Descripción: Obtiene una lista de todos los eventos.
  - Ejemplo de Respuesta:
    ```json
    [
      {
        "name": "Tour RSP",
        "description": "Tour por la casa del Sevilla FC",
        "url": "enlace_imagen",
        "latitude": 37.38719483261625,
        "longitude": -5.971153027846458,
        "price": 12.0,
        "createdBy": "cristianpc",
        "city": null
      },
      {
        "name": "Catedral de Sevilla",
        "description": "Visita a la famosa Catedral de Sevilla",
        "url": "enlace_imagen",
        "latitude": 37.39357029098547,
        "longitude": -5.992938705028886,
        "price": 10.0,
        "createdBy": "cristianpc",
        "city": "Sevilla"
      }
    ]
    ```

- **Obtener Detalles de Evento:**
  - Método: `GET /event/{uuid}`
  - Descripción: Obtiene detalles de un evento específico.
  - Ejemplo de Respuesta:
    ```json
    {
      "name": "Catedral de Sevilla",
      "date": "2024-02-26 15:20:24",
      "url": "enlace_imagen",
      "city": "Sevilla",
      "price": "10.0",
      "participants": []
    }
    ```

- **Listar Eventos por Ubicación:**
  - Método: `GET /event/location/{ciudad}`
  - Descripción: Obtiene una lista de eventos en una ubicación específica.
  - Ejemplo de Respuesta:
    ```json
    [
      {
        "name": "Tour RSP",
        "date": "2024-02-29",
        "url": "enlace_imagen",
        "city": "Sevilla",
        "price": "12.0",
        "participants": [
          {
            "id": "e062bb13-56e8-43ff-94d8-59adea71a0c6",
            "username": "cristianpc"
          }
        ]
      },
      {
        "name": "Catedral de Sevilla",
        "date": "2024-02-29",
        "url": "enlace_imagen",
        "city": "Sevilla",
        "price": "10.0",
        "participants": [
          {
            "id": "e062bb13-56e8-43ff-94d8-59adea71a0c6",
            "username": "cristianpc"
          }
        ]
      },
      {
        "name": "Parque de Maria Luisa",
        "date": "2024-02-29",
        "url": "enlace_imagen",
        "city": "Sevilla",
        "price": "15.0",
        "participants": []
      }
    ]
    ```

- **Inscribir a un Participante:**
  - Método: `PUT /event/apuntar/me/{uuid}`
  - Descripción: Suscribe al cliente actual a un evento.
  - Ejemplo de Respuesta:
    ```json
    {
      "name": "Catedral de Sevilla",
      "date": "2024-02-29",
      "url": "enlace_imagen",
      "city": "Sevilla",
      "price": "10.0",
      "participants": [
        {
          "id": "e062bb13-56e8-43ff-94d8-59adea71a0c6",
          "username": "cristianpc"
        }
      ]
    }
    ```

- **Listar Mis Eventos Inscritos:**
  - Método: `GET /event/get/assigned`
  - Descripción: Obtiene una lista de eventos a los que el cliente actual está inscrito.
  - Ejemplo de Respuesta:
    ```json
    [
      {
        "name": "Catedral de Sevilla",
        "description": "Visita a la famosa Catedral de Sevilla",
        "url": "enlace_imagen",
        "latitude": 37.39357029098547,
        "longitude": -5.992938705028886,
        "price": 10.0,
        "createdBy": "cristianpc",
        "city": "Sevilla"
      }
    ]
    ```

- **Crear un Nuevo Evento:**
  - Método: `POST /event/new`
  - Descripción: Crea un nuevo evento.
  - Ejemplo de Solicitud:
    ```json
    {
      "name": "Paracaidismo Torre Pelli",
      "description": "Paracaidismo desde 1500m sobre la torre Pelli",
      "url": "enlace_imagen",
      "latitude": 37.3955175804586,
      "longitude": -6.011312152239021,
      "price": 120.0,
      "city": "Sevilla",
      "date": "2024-03-04"
    }
    ```
  - Ejemplo de Respuesta:
    ```json
    {
      "id": "b582965b-0a66-47a1-b0d4-ca1b8c77ce96",
      "name": "Paracaidismo Torre Pelli",
      "description": "Paracaidismo desde 1500m sobre la torre Pelli",
      "url": "enlace_imagen",
      "latitude": 37.3955175804586,
      "longitude": -6.011312152239021,
      "price": 120.0,
      "createdBy": "cristianpc",
      "city": "Sevilla",
      "date": "2024-03-04"
    }
    ``
## 🌏 Browser Support

| <img src="https://user-images.githubusercontent.com/1215767/34348387-a2e64588-ea4d-11e7-8267-a43365103afe.png" alt="Chrome" width="16px" height="16px" /> Chrome | <img src="https://user-images.githubusercontent.com/1215767/34348590-250b3ca2-ea4f-11e7-9efb-da953359321f.png" alt="IE" width="16px" height="16px" /> Internet Explorer | <img src="https://user-images.githubusercontent.com/1215767/34348380-93e77ae8-ea4d-11e7-8696-9a989ddbbbf5.png" alt="Edge" width="16px" height="16px" /> Edge | <img src="https://user-images.githubusercontent.com/1215767/34348394-a981f892-ea4d-11e7-9156-d128d58386b9.png" alt="Safari" width="16px" height="16px" /> Safari | <img src="https://user-images.githubusercontent.com/1215767/34348383-9e7ed492-ea4d-11e7-910c-03b39d52f496.png" alt="Firefox" width="16px" height="16px" /> Firefox |
| :---------: | :---------: | :---------: | :---------: | :---------: |
| Yes | 11+ | Yes | Yes | Yes |

### Lanzar

#### SpringBoot
``` sh
$ git clone "url"
$ cd globalGatheringAPI
$ cd globalgathering
$ mvn clean
$ mvn install
$ mvn spring-boot : run
```

## 📜 License

This software is licensed under the [APACHE](https://github.com/cpcx04/GlobalGathering/blob/main/LICENSE) ©.


---

<p align="center">
  ¡Únete a nosotros en la construcción de un mundo más conectado y colaborativo!
</p>


