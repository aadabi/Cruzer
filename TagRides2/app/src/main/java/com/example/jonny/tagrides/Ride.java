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
    public boolean driverArrived;
    public boolean rideCompleted;
    public boolean rideInProgress;

    public Ride() {
        this.riderID = "";
        this.driverID = "";
        this.destination = "";
        this.driverArrived = false;
        this.rideCompleted = false;
    }
    public boolean hasDriver() { return !(this.driverID == ""); }

    public void setRiderID(String id)
    {
        this.riderID = id;
    }

    public void setDriverID(String id) {
        this.driverID = id;
    }

    public void setDestination(String destination)  {
        this.destination = destination;
    }
    public boolean isRideCompleted()
    {
        return this.rideCompleted;
    }
    public void setDriverArrived(boolean arrived) { this.driverArrived = arrived; }
   //getters
    public void completeRide() { this.rideCompleted = true; }
    public String getRiderID()
    {
        return this.riderID;
    }
    public String getDriverID()
    {
        return this.driverID;
    }
    public String getDestination()
    {
        return this.destination;
    }


}