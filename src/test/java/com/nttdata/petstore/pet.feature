Feature: Gestión de mascotas en PetStore
  Como usuario de la API
  Quiero añadir, consultar y modificar mascotas
  Para mantener el registro actualizado

  Background:
    * url 'https://petstore.swagger.io/v2'
    * def headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }

  @HappyPath
  Scenario: Crear, consultar y modificar la mascota

    # ----------------------------------------------------------------
    # 1. Añadir una mascota a la tienda
    # ----------------------------------------------------------------
    Given path '/pet'
    And request
    """
    {
      "id": 0,
      "category": {
                    "id": 1,
                    "name": "Perros"
                    },
      "name": "Tato",
      "photoUrls": ["http://foto.com/perro.jpg"],
      "tags": [
          {
       "id": 1,
       "name": "tierno"
       }
       ],
      "status": "available"
    }
    """
    When method post
    Then status 200
    # Capturamos el ID generado para usarlo después
    * def petId = response.id
    * print 'Mascota creada con ID:', petId

    # ----------------------------------------------------------------
    # 2. Consultar la mascota ingresada previamente (Búsqueda por ID)
    # ----------------------------------------------------------------
    Given path '/pet', petId
    When method get
    Then status 200
    And match response.name == 'Firulais'
    And match response.id == petId

    # ----------------------------------------------------------------
    # 3. Actualizar nombre y estatus a "sold"
    # ----------------------------------------------------------------
    Given path '/pet'
    And request
    """
    {
      "id": #(petId),
      "category": { "id": 1, "name": "Perros" },
      "name": "Firulais Vendido",
      "photoUrls": ["http://foto.com/perro.jpg"],
      "tags": [{ "id": 1, "name": "tierno" }],
      "status": "sold"
    }
    """
    When method put
    Then status 200
    And match response.status == 'sold'
    And match response.name == 'Firulais Vendido'

    # ----------------------------------------------------------------
    # 4. Consultar la mascota modificada por estatus "sold"
    # ----------------------------------------------------------------
    Given path '/pet/findByStatus'
    And param status = 'sold'
    When method get
    Then status 200
    # Validamos que NUESTRO id esté dentro de la lista que devuelve el servicio
    # Karate permite buscar en arrays con "match response[*].id contains petId"
    And match response[*].id contains petId
    * print 'Validación exitosa: La mascota', petId, 'está en la lista de vendidos.'