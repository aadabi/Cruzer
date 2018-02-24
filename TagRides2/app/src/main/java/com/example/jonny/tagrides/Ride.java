package com.example.jonny.tagrides;

/**
 * Created by jonny on 2/16/2018.
 */

public class Ride
{
    //global variables for our Rides class
    private String riderID;
    private String driverID;
    private String destination;

    public Ride() {
        this.riderID = "";
        this.driverID = "";
        this.destination = "";
    }

    public void setRiderID(String id) {
        this.riderID = id;
    }

    public void setDriverID(String id) {
        this.driverID = id;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }
}
