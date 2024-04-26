package com.salesianos.triana.edu.globalgathering.exception.client;

public class SameUsernameException extends RuntimeException{

    public SameUsernameException(){super("You cant delete your own user");}
}