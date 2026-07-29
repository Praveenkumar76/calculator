package com.praveen;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest({Calculator.class, HealthController.class})
class ControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void testAddEndpoint() throws Exception {
        mockMvc.perform(get("/api/add")
                        .param("a", "2")
                        .param("b", "3"))
                .andExpect(status().isOk())
                .andExpect(content().string("5"));
    }

    @Test
    void testSubtractEndpoint() throws Exception {
        mockMvc.perform(get("/api/subtract")
                        .param("a", "5")
                        .param("b", "3"))
                .andExpect(status().isOk())
                .andExpect(content().string("2"));
    }

    @Test
    void testMultiplyEndpoint() throws Exception {
        mockMvc.perform(get("/api/multiply")
                        .param("a", "3")
                        .param("b", "5"))
                .andExpect(status().isOk())
                .andExpect(content().string("15"));
    }

    @Test
    void testHealthEndpoint() throws Exception {
        mockMvc.perform(get("/health"))
                .andExpect(status().isOk())
                .andExpect(content().string("UP"));
    }
}