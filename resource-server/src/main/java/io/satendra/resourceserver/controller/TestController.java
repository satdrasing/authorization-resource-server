package io.satendra.resourceserver.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.Collection;

@RestController
public class TestController {

    @GetMapping("/test")
    public Collection<String> getNames(HttpServletRequest httpServletRequest) {

        String username = httpServletRequest.getUserPrincipal().getName();

        return Arrays.asList("one", "two", "three", "four",username);

    }
}
