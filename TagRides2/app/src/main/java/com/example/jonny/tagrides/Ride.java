package com.example.jonny.tagrides;

/**
 * Created by jonny on 2/16/2018.
 */

public class Ride
{
    //global variables for our Rides class
    public String riderID;
    public String driverID;
    public String destination;

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
