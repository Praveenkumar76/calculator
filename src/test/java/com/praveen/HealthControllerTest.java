package com.praveen;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class HealthControllerTest {

    @Test
    void testHealth() {
        HealthController controller = new HealthController();
        assertEquals("UP", controller.health());
    }
}