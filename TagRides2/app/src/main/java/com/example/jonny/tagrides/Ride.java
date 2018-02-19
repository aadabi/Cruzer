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

    public Ride(String riderID, String driverID, String destination) {
        this.riderID = riderID;
        this.driverID = driverID;
        this.destination = destination;
    }
}
