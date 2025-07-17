// Clase de configuración en: src/main/java/com/example/demo/config/WebConfig.java
package com.final_proyect.app.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")  // Permite todas las rutas
                .allowedOrigins("*")  // Permite cualquier origen (Flutter)
                .allowedMethods("GET", "POST", "PUT", "DELETE");  // Métodos permitidos
    }
}