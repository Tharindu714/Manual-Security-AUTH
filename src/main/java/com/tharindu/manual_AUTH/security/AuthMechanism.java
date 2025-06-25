package com.tharindu.manual_AUTH.security;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.security.enterprise.AuthenticationException;
import jakarta.security.enterprise.AuthenticationStatus;
import jakarta.security.enterprise.authentication.mechanism.http.AutoApplySession;
import jakarta.security.enterprise.authentication.mechanism.http.HttpAuthenticationMechanism;
import jakarta.security.enterprise.authentication.mechanism.http.HttpMessageContext;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.security.enterprise.identitystore.CredentialValidationResult;
import jakarta.security.enterprise.identitystore.IdentityStore;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@AutoApplySession
@ApplicationScoped
public class AuthMechanism implements HttpAuthenticationMechanism {
    @Inject
    private IdentityStore identityStore;

    @Override
    public AuthenticationStatus validateRequest(HttpServletRequest Request,
                                                HttpServletResponse Response,
                                                HttpMessageContext context)
            throws AuthenticationException {
        System.out.println("AuthMechanism validateRequest called");
        String username = Request.getParameter("username");
        String password = Request.getParameter("password");

        if (username != null && password != null) {
            CredentialValidationResult CVR = identityStore.validate(
                    new UsernamePasswordCredential(username, password));

            if (CVR.getStatus() == CredentialValidationResult.Status.VALID) {
                return context.notifyContainerAboutLogin(CVR);
            } else {
                try{
                    Response.sendRedirect(Request.getContextPath() + "/error.jsp");
                } catch (IOException e) {
                    throw new RuntimeException("Redirect to login Failed", e);
                }
                return AuthenticationStatus.SEND_FAILURE;
            }
        }
        if (context.isProtected()) {
            try {
                Response.sendRedirect(Request.getContextPath() + "/login.jsp");
                return AuthenticationStatus.SEND_CONTINUE;
            } catch (IOException e) {
                throw new RuntimeException("Redirect to login Failed", e);
            }
        }
        return context.doNothing();
    }
}
