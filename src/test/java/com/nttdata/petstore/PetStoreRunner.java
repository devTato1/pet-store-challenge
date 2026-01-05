package com.nttdata.petstore;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class PetStoreRunner {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:com/nttdata/petstore")
                .tags("@HappyPath")
                .outputCucumberJson(true)
                .parallel(1);

        // Esto hace que la prueba falle en JUnit si Karate encontró errores
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}