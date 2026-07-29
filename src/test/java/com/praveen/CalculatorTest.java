package com.praveen;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CalculatorTest {

    private final Calculator calculator = new Calculator();
    public int x = 10;

    @Test
    void testAdd() {
        assertEquals(5, calculator.add(2, 3));
        assertEquals(0, calculator.add(-2, 2));
        assertEquals(-5, calculator.add(-2, -3));
    }

    @Test
    void testSubtract() {
        assertEquals(2, calculator.subtract(5, 3));
        assertEquals(-1, calculator.subtract(2, 3));
        assertEquals(0, calculator.subtract(3, 3));
    }

    @Test
    void testMultiply() {
        assertEquals(15, calculator.multiply(3, 5));
        assertEquals(0, calculator.multiply(0, 10));
        assertEquals(-12, calculator.multiply(-3, 4));
    }

    @Test
    void pmdFailureProbe() {
        int temporaryValue = 10;
    }

}// Retrigger PMD validation
// trigger PR validation
