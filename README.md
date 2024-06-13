# GlobalGathering
<p align="center">
  <img src="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/fondo.png" alt="GLOBAL GATHERING" width="300"/>
</p>
> Globar Gathering para viajar acompañado - Divertido y económico
</br>
</br>
</br>

<p align="center">
  <img src="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/login.png" alt="Descripción de la primera imagen" width="300"/>
  <img src="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/registre.png" alt="Descripción de la segunda imagen" width="300"/>
  <img src="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/homePage.png" alt="Descripción de la tercera imagen" width="300"/>
</p>

<p align="center">
   <img src="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/makeAcomment.png" alt="Descripción de la primera imagen" width="300"/>
  <img src="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/travelPage.png" alt="Descripción de la cuarta imagen" width="300"/>
   <img src="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/qrticket.png" alt="Descripción de la primera imagen" width="300"/>
</p>



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

### Flutter Packages App

| Dependencias | Version | Descripcion |
| --- | --- | --- |
| `flutter` | >=3.2.3 <4.0.0 | Flutter inicial |
| `cupertino_icons` | ^1.0.2 | Iconos para IOS |
| `http` | ^1.2.0 | Se utiliza para realizar peticiones |
| `flutter_bloc` | ^8.1.3 | Utilizamos los blocs para organizar el código de manera mas limpia y legible |
| `transparent_image` | ^2.0.1 | Esto lo realizamos para hacer que las imagenes sean transparentes |
| `flutter_animate` | ^4.5.0 | Animaciones básicas |
| `flip_card` | ^0.7.0 | Dar vuelta alas cartas |
| `webview_flutter` | ^4.5.0 | Para redirecciones a webs | 
| `shared_preferences` | ^2.2.2 | Para guardar atributos como el token o el nombre de usuario |
| `flutter_svg` | ^2.0.10+1 | Este lo importamos para pasar imagenes a vectores facilmente | 
| `google_maps_flutter` | ^2.5.3 | Este es el paquete de Google Maps para poder ver en el mapa los eventos |
| `google_maps_flutter_web` | ^0.5.4+3 | Paquete que nos permite ver el mapa en le web |
| `cached_network_image` | ^3.3.1 | Guarda imagenes de internet en el caché |
| `table_calendar` | ^3.1.0 | Para los calendarios y manejo de fechas |
| `google_fonts` | ^5.1.0 | Paquete para controlar las fuentes utilizadas en la aplicación |
| `ticket_widget` | ^1.0.2 | Este paquete no suministra un widget de Ticket |
| `qr_flutter` | ^4.1.0 | Este paquete nos permite crear qr's con información |
| `pdf` | ^3.10.8 | Este paquete nos permite crear pdfs dentro de la aplicación |
| `url_launcher` | ^6.0.13 | Este paquete es para lanzar urls dentro de la aplicación |
| `scroll_to_index` | ^2.0.0 | Scrolls editables |
| `flutter_test` | sdk: flutter | Tests de flutter | 
| `flutter_lints` | ^2.0.0 | Paquete para manejo de Dart |


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
 -Logueo,creacion de comentario y de eventos 
 <p align="center">
<a href="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/gifLogin.gif" target="_blank"><img src="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/gifLogin.gif" alt="Demostración de Uso" width="300"></a>
<a href="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/createAcommentGif.gif" target="_blank"><img src="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/createAcommentGif.gif" alt="Demostración de Uso" width="300"></a>
  <a href="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/createAEvent.gif" target="_blank"><img src="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/createAEvent.gif" alt="Demostración de Uso" width="300"></a>
</p>

-Mapas,Reserva de viaje y de eventos

 <p align="center">
<a href="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/tripGif.gif" target="_blank"><img src="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/tripGif.gif" alt="Demostración de Uso" width="300"></a>
<a href="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/ticket.gif" target="_blank"><img src="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/ticket.gif" alt="Demostración de Uso" width="300"></a>
  <a href="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/profilePage.gif" target="_blank"><img src="https://github.com/cpcx04/GlobalGathering/blob/main/globalGatheringMobile/global_gathering_application_1/assets/icons/profilePage.gif" alt="Demostración de Uso" width="300"></a>
</p>

## 🌏 Browser Support

| <img src="https://user-images.githubusercontent.com/1215767/34348387-a2e64588-ea4d-11e7-8267-a43365103afe.png" alt="Chrome" width="16px" height="16px" /> Chrome | <img src="https://user-images.githubusercontent.com/1215767/34348590-250b3ca2-ea4f-11e7-9efb-da953359321f.png" alt="IE" width="16px" height="16px" /> Internet Explorer | <img src="https://user-images.githubusercontent.com/1215767/34348380-93e77ae8-ea4d-11e7-8696-9a989ddbbbf5.png" alt="Edge" width="16px" height="16px" /> Edge | <img src="https://user-images.githubusercontent.com/1215767/34348394-a981f892-ea4d-11e7-9156-d128d58386b9.png" alt="Safari" width="16px" height="16px" /> Safari | <img src="https://user-images.githubusercontent.com/1215767/34348383-9e7ed492-ea4d-11e7-910c-03b39d52f496.png" alt="Firefox" width="16px" height="16px" /> Firefox |
| :---------: | :---------: | :---------: | :---------: | :---------: |
| Yes | 11+ | Yes | Yes | Yes |

### Lanzar

Clonar `main`

```sh
$ git clone https://github.com/cpcx04/GlobalGathering/tree/main
$ cd globalGatheringMobile/global_gathering_application_1
$ flutter pub get
$ flutter run
```
