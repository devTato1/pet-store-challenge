
# 🐶 PetStore API Automation - Karate Framework

Este repositorio contiene la solución automatizada para el **Ejercicio 2** del reto técnico. Se ha implementado un flujo End-to-End (E2E) para la gestión de mascotas en la API de [PetStore Swagger](https://petstore.swagger.io/), utilizando **Karate DSL**.

## 📋 Descripción del Ejercicio

El script automatizado cubre el ciclo de vida completo de una mascota en la tienda, asegurando la integridad de los datos a través de las siguientes operaciones secuenciales:

1.  **Create:** Añadir una nueva mascota a la tienda.
2.  **Read:** Consultar la mascota ingresada previamente (Búsqueda por ID generado dinámicamente).
3.  **Update:** Actualizar el nombre y el estatus de la mascota a "sold".
4.  **Find:** Consultar la mascota modificada filtrando por estatus y validando su presencia en la lista.

## 🛠️ Tech Stack

* **Lenguaje:** Java 11+ (Probado con Java 17)
* **Framework:** [Karate DSL](https://github.com/karatelabs/karate) (v1.4.1)
* **Build Tool:** Maven 3.x
* **Test Runner:** JUnit 5
* **IDE Recomendado:** IntelliJ IDEA

## ⚙️ Prerrequisitos

Asegúrate de tener instalado lo siguiente antes de ejecutar el proyecto:

* **Java JDK 11** o superior configurado en el `JAVA_HOME`.
* **Maven** instalado y configurado en el `PATH`.
* **Git** para clonar el repositorio.

## 🚀 Instalación y Configuración

1.  **Clonar el repositorio:**
    ```bash
    git clone git@github.com:devTato1/pet-store-challenge.git
    ```

2.  **Ir al directorio del proyecto:**
    ```bash
    cd pet-store-challenge
    ```

3.  **Descargar dependencias:**
    ```bash
    mvn clean install -DskipTests
    ```

## ▶️ Ejecución de las Pruebas

### Desde Terminal (Maven)
Para ejecutar el Runner principal y generar los reportes:

```bash
mvn test -Dtest=PetStoreRunner

```

### Desde IntelliJ IDEA

1. Navega a `src/test/java/com/nttdata/petstore/PetStoreRunner.java`.
2. Haz clic derecho sobre el archivo o el método `testParallel()`.
3. Selecciona **"Run 'PetStoreRunner'"**.

## 📊 Reportes de Ejecución

Al finalizar la ejecución, Karate genera automáticamente reportes detallados.

* **Resumen HTML (Karate):**
  `target/karate-reports/karate-summary.html`
* **Reporte Cucumber (JSON):**
  `target/karate-reports/petstore.json`

Para ver el reporte visual, navega a la carpeta `target/karate-reports/` y abre el archivo `karate-summary.html` en tu navegador web.

## 📂 Estructura del Proyecto

```text
src/test/java/com/nttdata/petstore/
├── PetStoreRunner.java      # Ejecutor de pruebas (JUnit 5 + Karate Runner)
└── petstore.feature         # Script Gherkin con los escenarios de prueba

```

## 📝 Notas Técnicas

* **Manejo de Datos Dinámicos:** Se capturan variables de la respuesta (ej. `def petId = response.id`) para reutilizarlas en pasos posteriores, garantizando que siempre se interactúe con el registro creado en la ejecución actual.
* **Validación de Arrays:** Se utiliza la sintaxis de Karate `match response[*].id contains petId` para validar la existencia de un objeto específico dentro de respuestas tipo lista.

---

**Autor:** Leonardo Reascos

