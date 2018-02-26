package com.example.jonny.tagrides;

/**
 * Created by jonny on 2/16/2018.
 */

public class Ride
{
    /* I think these have to be public for FireBase right now, but it needs to be looked into
       more. I'm pretty sure they can be private as long as there are public getters for every
       field. */
    public String riderID;
    public String driverID;
    public String destination;
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

   //getters
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


    public boolean hasDriver() { return !(this.driverID == ""); }

    public boolean isDriverArrived() { return this.driverArrived; }

    public boolean isRideCompleted() { return this.rideCompleted; }

    public void setRiderID(String id) { this.riderID = id; }

    public void setDriverID(String id) { this.driverID = id; }

    public void setDestination(String destination) { this.destination = destination; }

    public void setDriverArrived(boolean arrived) { this.driverArrived = arrived; }

    public void completeRide() { this.rideCompleted = true; }
}
