package com.salesianos.triana.edu.globalgathering.exception.client;

public class BannedUserException extends RuntimeException{
    public BannedUserException(){super("You already are in this event");}
}
