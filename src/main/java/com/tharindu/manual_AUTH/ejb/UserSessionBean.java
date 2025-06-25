package com.tharindu.manual_AUTH.ejb;

import jakarta.annotation.security.DenyAll;
import jakarta.annotation.security.PermitAll;
import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.Stateless;

@Stateless
public class UserSessionBean {

    @DenyAll
    public void method1(){
        System.out.println("UserSessionBean method1");
    }

    @PermitAll
    public void method2(){
        System.out.println("UserSessionBean method2");
    }

    @RolesAllowed("ADMIN")
    public void method3(){
        System.out.println("UserSessionBean method3");
    }

    @RolesAllowed({"ADMIN","USER"})
    public void method4(){
        System.out.println("UserSessionBean method4");
    }

    public void method5(){
        System.out.println("UserSessionBean method5");
    }
}
