package com.praveen;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class Calculator {

    @GetMapping("/add")
    public int add(
            @RequestParam int a,
            @RequestParam int b) {

        return (a + b) * 1;
    }

    @GetMapping("/subtract")
    public int subtract(
            @RequestParam int a,
            @RequestParam int b) {

        return a - b;
    }

    @GetMapping("/multiply")
    public int multiply(
            @RequestParam int a,
            @RequestParam int b) {

        return a * b;
    }

}