package com.example.jonny.tagrides.Models;

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
    public String currentLocation;
    public String riderName;
    public String driverName;
    public boolean driverArrived;
    public boolean rideCompleted;
    public boolean rideInProgress;
    public double longitude;
    public double latitude;


    public Ride() {
        this.riderID = "";
        this.driverID = "";
        this.currentLocation = "";
        this.destination = "";
        this.riderName = "";
        this.driverArrived = false;
        this.rideCompleted = false;
        this.rideInProgress = false;
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
    public String getRiderName() {
        return this.riderName;
    }
    public double getLatitude()
    {
        return this.latitude;
    }
    public double getLongitude()

    {
        return this.longitude;
    }
    public String getDriverName() {
        return this.driverName;
    }



    public boolean isRideInProgress() {
        return this.rideInProgress;
    }

    public boolean hasDriver() { return !this.driverID.equals(""); }

    public boolean isDriverArrived() { return this.driverArrived; }

    public boolean isRideCompleted() { return this.rideCompleted; }

    public void setLatitude(double locationY)
    {
        this.latitude = locationY;
    }
    public void setLongitude(double locationX)
    {
        this.longitude = locationX;
    }
    public void setRiderID(String id) { this.riderID = id; }
    public void setDriverName(String name) {
        this.driverName = name;
    }

    public void setRiderName(String name) {
        this.riderName = name;
    }

    public void setDriverID(String id) { this.driverID = id; }

    public void setDestination(String destination) { this.destination = destination; }

    public void setDriverArrived(boolean arrived) { this.driverArrived = arrived; }

    public void completeRide() { this.rideCompleted = true; }

    public void setCurrentLocation(String currentLocation) {
        this.currentLocation = currentLocation;
    }

    public String getCurrentLocation() {
        return this.currentLocation;
    }

}
