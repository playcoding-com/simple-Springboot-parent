package org.vaadin.example;

import java.io.Serializable;

//import org.springframework.stereotype.Service;

//@Service
public class GreetServiceCore implements Serializable {

    public String greet(String name) {
        if (name == null || name.isEmpty()) {
            return "Hello anonymous user FROM core project";
        } else {
            return "Hello " + name + " FROM core project";
        }
    }

}
