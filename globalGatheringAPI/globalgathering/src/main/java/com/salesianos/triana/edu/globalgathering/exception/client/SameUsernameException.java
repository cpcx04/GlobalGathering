package com.salesianos.triana.edu.globalgathering.exception.client;

public class SameUsernameException extends RuntimeException{

    public SameUsernameException(){super("You cant delete or ban your own user");}
}