package com.calendar.project.validator;

import com.calendar.project.model.User;
import com.calendar.project.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.util.regex.Pattern;

@Component
public class UserValidator implements Validator {

    @Autowired
    private UserService userService;

    @Override
    public boolean supports(Class<?> aClass) {
        return User.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        User user = (User) o;
        String username = user.getUsername();

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "Required");
        int usernameLength = username.length();
        if (usernameLength < 8 || usernameLength > 32) {
            errors.rejectValue("username", "Size.userForm.username");
        }

        if (userService.exists(username)) {
            errors.rejectValue("username", "Duplicate.userForm.username");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstname", "Required");
        if (!Pattern.matches("^([A-Za-z]+[,.]?[ ]?|[A-Za-z]+['-]?)+$", user.getFirstname())){
            errors.rejectValue("firstname", "FirstName.userForm.name");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lastname", "Required");
        if (!Pattern.matches("^[\\p{L} .'-]+$", user.getLastname())){
            errors.rejectValue("lastname", "LastName.userForm.lastname");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "Required");
        if(!Pattern.matches("(?:[a-z0-9!#$%&'*+\\=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+\\=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])", user.getEmail())){
            errors.rejectValue("email", "Mail.userForm.email");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "Required");
        int passwordLength = user.getPassword().length();
        if (passwordLength < 8 || passwordLength > 32) {
            errors.rejectValue("password", "Size.userForm.password");
        }

        if (!user.getConfirmPassword().equals(user.getPassword())) {
            errors.rejectValue("confirmPassword", "Different.userForm.password");
        }
    }
}