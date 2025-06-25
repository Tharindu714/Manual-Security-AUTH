package com.tharindu.manual_AUTH.security;

import com.tharindu.manual_AUTH.model.User;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.security.enterprise.credential.Credential;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.security.enterprise.identitystore.CredentialValidationResult;
import jakarta.security.enterprise.identitystore.IdentityStore;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

@ApplicationScoped
public class AppIdentifyStore implements IdentityStore {

    private static final Map<String, User> USERS = new HashMap<>();

    static {
        USERS.put("Stephani", new User("Stephani8754", Set.of("ADMIN")));
        USERS.put("Shane", new User("Shane@23", Set.of("ADMIN", "USER")));
        USERS.put("Alberto", new User("Alberto234", Set.of("USER")));
    }

    @Override
    public CredentialValidationResult validate(Credential credential) {
        System.out.println("AppIdentifyStore validate called");

        if (credential instanceof UsernamePasswordCredential) {
            UsernamePasswordCredential UserPassCredential = (UsernamePasswordCredential) credential;
            User user = USERS.get(UserPassCredential.getCaller());

            if (user != null && user.getPassword().equals(UserPassCredential.getPasswordAsString())) {
                return new CredentialValidationResult(UserPassCredential.getCaller(), user.getRoles());
            }
        }
        return CredentialValidationResult.INVALID_RESULT;
    }
}
