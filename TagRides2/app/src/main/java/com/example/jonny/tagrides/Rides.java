package com.example.jonny.tagrides;

/**
 * Created by jonny on 2/16/2018.
 */

public class Rides
{
    //global variables for our Rides class
    public User riderID;
    public User driverID;
    public String rideID;
    public float start_latitude;
    public float start_longitude;
    public float end_latitude;
    public float end_longitude;
    public boolean status_ongoing;

    public Rides(User driver, User rider, String ride_ID)
    {
        this.riderID = rider;
        this.driverID = driver;
        this.rideID = ride_ID;
        this.status_ongoing = false;
    }
    public Rides(String ride_ID)
    {
        this.rideID = ride_ID;
    }
    //setters
    public void setRideID(String rId)
    {
        this.rideID = rId;
    }
    public void setStatusOn(boolean going)
    {
        this.status_ongoing = going;
    }
    public void setStart_latitude(float latitude)
    {
        this.start_latitude = latitude;
    }
    public void setStart_longitude(float longitude)
    {
        this.start_longitude = longitude;
    }
    public void setEnd_latitude(float latitude)
    {
        this.end_latitude = latitude;
    }
    public void setEnd_longitude(float longitude)
    {
        this.end_longitude = start_longitude;
    }
    //getters
    public String getRideID()
    {
        return this.rideID;
    }
    public boolean getStatusOn()
    {
        return this.status_ongoing;
    }
    public float getStart_latitude()
    {
        return this.start_latitude;
    }
    public float setStart_longitude()
    {
        return this.start_longitude;
    }
    public float setEnd_latitude()
    {
        return this.end_latitude;
    }
    public float setEnd_longitude()
    {
        return this.end_longitude;
    }


}
