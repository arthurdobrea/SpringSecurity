package com.calendar.project.validator;

import com.calendar.project.model.User;
import com.calendar.project.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

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
        String firstname = user.getFirstname();
        String lastname = user.getLastname();
        String email = user.getEmail();

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "Required");
        int usernameLength = username.length();
        if (usernameLength < 8 || usernameLength > 32) {
            errors.rejectValue("username", "Size.userForm.username");
        }

        if (userService.exists(username)) {
            errors.rejectValue("username", "Duplicate.userForm.username");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstname", "Required");
        int firstnameLength = firstname.length();
        if (firstnameLength < 2 || firstnameLength > 32) {
            errors.rejectValue("firstname", "Size.userForm.name");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstname", "Required");
        int lastnameLength = lastname.length();
        if (lastnameLength < 2 || lastnameLength > 32) {
            errors.rejectValue("lastname", "Size.userForm.lastname");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "Required");
        int emailLength = email.length();
        if ((emailLength < 10 || emailLength > 32) && (!email.contains("@"))) {
            errors.rejectValue("email", "Size.userForm.email");
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
