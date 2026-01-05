Feature: Gestión de mascotas en PetStore

  Background:
    * url 'https://petstore.swagger.io/v2'
    # Definimos un objeto con todos los datos de prueba
    * def petData =
    """
    {
      "initialName": "Tato",
      "updatedName": "Firulais Vendido",
      "category": "Perros",
      "status": "available",
      "updatedStatus": "sold"
    }
    """

  @HappyPath
  Scenario: Flujo completo de vida de una mascota
    # ----------------------------------------------------------------
    # 1. Añadir una mascota a la tienda
    # ----------------------------------------------------------------
    Given path '/pet'
    And request
    """
    {
      "id": 0,
      "category": { "id": 1, "name": "#(petData.category)" },
      "name": "#(petData.initialName)",
      "photoUrls": ["http://foto.com/perro.jpg"],
      "tags": [{ "id": 1, "name": "tierno" }],
      "status": "#(petData.status)"
    }
    """
    When method post
    Then status 200
    * def petId = response.id
    * print 'Mascota creada con ID:', petId

    # ----------------------------------------------------------------
    # 2. Consultar la mascota ingresada (Validación de creación)
    # ----------------------------------------------------------------
    Given path '/pet', petId
    When method get
    Then status 200
    And match response.name == petData.initialName
    And match response.id == petId

    # ----------------------------------------------------------------
    # 3. Actualizar nombre y estatus a "sold"
    # ----------------------------------------------------------------
    Given path '/pet'
    And request
    """
    {
      "id": #(petId),
      "category": { "id": 1, "name": "#(petData.category)" },
      "name": "#(petData.updatedName)",
      "photoUrls": ["http://foto.com/perro.jpg"],
      "tags": [{ "id": 1, "name": "tierno" }],
      "status": "#(petData.updatedStatus)"
    }
    """
    When method put
    Then status 200
    And match response.status == petData.updatedStatus
    And match response.name == petData.updatedName

    # ----------------------------------------------------------------
    # 4. Consultar la mascota modificada por estatus "sold"
    # ----------------------------------------------------------------
    Given path '/pet/findByStatus'
    # Usamos la variable de estatus actualizado
    And param status = petData.updatedStatus
    When method get
    Then status 200
    # Verificamos ID dinámico esté en la lista de resultados
    And match response[*].id contains petId
    * print 'Validación exitosa: La mascota con ID', petId, 'aparece como', petData.updatedStatus