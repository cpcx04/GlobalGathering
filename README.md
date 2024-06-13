# GlobalGathering

## Descripción
Este proyecto es una aplicación completa que consta de tres partes: una API backend, un frontend web, y una aplicación móvil. A continuación, se describen los pasos para configurar y ejecutar cada parte del proyecto.

## Prerrequisitos
Asegúrate de tener instalados los siguientes programas en tu sistema:

- Docker
- Docker Compose
- Maven
- Node.js y npm
- Angular CLI
- Flutter

## Configuración del Backend (API)

1. Clonar el repositorio y cambiar a la rama `develop-api`:
   ```sh
   git clone https://github.com/cpcx04/GlobalGathering.git
   cd GlobalGathering
   git checkout develop-api
    ```

2. Levantar el contenedor Docker:
    
    ```sh
    docker-compose up -d
    
    ```
    
3. Instalar las dependencias y compilar la API:
    
    ```sh
    mvn install
    
    ```
    
3. Ejecutar la API:
    
    ```sh
    mvn spring-boot:run
    
    ```
    

## Configuración del Frontend (Web)

1. Clonar el repositorio y cambiar a la rama `develop-web`:
    
    ```sh
    git clone https://github.com/cpcx04/GlobalGathering.git
    cd GlobalGathering
    git checkout develop-web
    
    ```
    
2. Navegar al directorio del frontend:
    
    ```sh
    cd frontend
    
    ```
    
3. Instalar las dependencias:
    
    ```sh
    npm install
    
    ```
    
4. Ejecutar la aplicación web:
    
    ```sh
    ng serve
    
    ```
    

## Configuración de la Aplicación Móvil

1. Clonar el repositorio y cambiar a la rama `develop-mobile`:
    
    ```sh
    git clone https://github.com/cpcx04/GlobalGathering.git
    cd GlobalGathering
    git checkout develop-mobile
    
    ```
    
2. Navegar al directorio de la aplicación móvil:
    
    ```sh
    cd mobile
    
    ```
    
3. Limpiar el proyecto Flutter:
    
    ```sh
    flutter clean
    
    ```
    
4. Obtener las dependencias:
    
    ```sh
    flutter pub get
    
    ```
    
5. Ejecutar la aplicación en el dispositivo deseado:
    
    ```sh
    flutter run
    
    ```
    

## Estructura del Proyecto

- **develop-api/**: Contiene el código fuente de la API.
- **develop-web/**: Contiene el código fuente del frontend web.
- **develop-mobile/**: Contiene el código fuente de la aplicación móvil.

## Contribución

Si deseas contribuir a este proyecto, por favor sigue los siguientes pasos:

1. Haz un fork del repositorio.
2. Crea una nueva rama (`git checkout -b feature/nueva-funcionalidad`).
3. Realiza los cambios necesarios y haz commit (`git commit -m 'Añadir nueva funcionalidad'`).
4. Sube los cambios a tu fork (`git push origin feature/nueva-funcionalidad`).
5. Abre un Pull Request.

## Contacto

Para cualquier duda o sugerencia, por favor contacta al autor del proyecto.
