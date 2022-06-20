package org.vaadin.example;

import java.io.Serializable;

import org.springframework.stereotype.Service;

@Service
public class GreetService extends GreetServiceCore implements Serializable {

    public String greet(String name) {
        return super.greet(name);
    }

}
