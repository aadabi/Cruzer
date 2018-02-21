package com.example.jonny.tagrides;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Calendar;

/**
 * Created by jonny on 2/15/2018.
 */

public class User{
   //global variables for helper class
    public String userID;
    public String name;
    public String stateIssuedId;
    public Date idExperationDate;
    public boolean driver;
    public boolean rider;
    public String user_license;
    public String userEmail;
    public float longitude;
    public float latitude;

    public Car userCar;

    //this is the format we want for our day
    public static SimpleDateFormat sdf  = new SimpleDateFormat("MMddyyyy");


  //constructors
   public User(String myId, String name, String stateLicense,String idState, Date idExpires, String email )
   {
       this.userID = myId;
       this.name = name;
       this.stateIssuedId = idState;
       this.driver = false;
       this.rider = false;
       this.idExperationDate = idExpires;
       this.user_license = stateLicense;
       this.userEmail = email;
   }

   public User(String userid)
   {
       this.userID = userid;

   }
   public User()
   {

   }
   //setters
   public void set_latitude(float locationY)
   {
       this.latitude = locationY;
   }
   public void set_longitude(float locationX)
   {
       this.longitude = locationX;
   }
   public void setUserID(String id)
   {
       this.userID = id;
   }
   public void setName(String name) {
       this.name = name;
   }
   public void setDriver()
   {
     this.driver =true;
   }
   public void setRider()
   {
       this.rider = true;
   }
   public void setUserEmail(String email)
   {
       this.userEmail = email;
   }
   public void setUser_license(String license)
   {
       this.user_license = license;
   }
   public void setStateIssuedId(String state_id)
   {
       this.stateIssuedId = state_id;
   }
   public void setIdExperationDate(Date expires)
   {
       this.idExperationDate = expires;
   }

   //getters
   public float get_latitude()
   {
        return this.latitude;
   }
   public float get_longitude()

    {
        return this.longitude;
    }
    public String getUserID()
    {
        return this.userID;
    }
    public String getName() {
       return this.name;
    }
    public boolean getDriver()
    {
        return this.driver;
    }
    public boolean getRider()
    {
        return this.rider;
    }
    public String getUser_license()
    {
        return this.user_license;
    }
    public String getStateIssuedId()
    {
        return this.stateIssuedId;

    }
    public String getUserEmail()
    {
        return this.userEmail;
    }
    public String getExpiration()
    {
        // wasn't compiling with this
        //return sdf.format(idExperationDate);
        return Calendar.getInstance().getTime().toString();
    }
    //methods for the user to add a vehicle
    public  void setCarMake (String Make)
    {
        userCar.setCarMake(Make);
    }
    public void setCarModel(String model)
    {
        userCar.setCarModel(model);
    }
    public void setCarYear(int year)
    {
        userCar.setCarYear(year);
    }
    public void setCarColor(String color)
    {
        userCar.setCarColor(color );
    }
}
