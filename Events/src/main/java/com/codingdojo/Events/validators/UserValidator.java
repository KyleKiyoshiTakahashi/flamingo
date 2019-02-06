package com.codingdojo.Events.validators;

import org.springframework.stereotype.Component;


import com.codingdojo.Events.models.User;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component
public class UserValidator implements Validator {

    @Override
    public boolean supports(Class<?> clazz) {
        return User.class.equals(clazz);
    }
    
    @Override 
    //  validation: checks at registration that the password and confirmed password is the same.  if not it sends an error that uses the messages.properties file   
    //  info on validation errors ->  https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/validation/Errors.html
    public void validate(Object target, Errors errors) {
        User user = (User) target; 
        System.out.println("user.getConfirmPassword() "+ user.getConfirmPassword() );
        System.out.println("user.getPassword() "+user.getPassword());
        if (!user.getConfirmPassword().equals(user.getPassword())) {
            errors.rejectValue("confirmPassword", "Match");
            System.out.println("asdfl;adsjafdl;asdf");
        }         
    }	
}
