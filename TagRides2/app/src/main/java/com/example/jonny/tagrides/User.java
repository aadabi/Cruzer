package com.example.jonny.tagrides;

import java.lang.reflect.Array;
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
    public Date currLogin;
    public String userEmail;


  //constructors
   public User(String myId, String name, Date currLogin, String email)
   {
       this.userID = myId;
       this.name = name;
       this.currLogin = currLogin;
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
   public void setUserID(String id)
   {
       this.userID = id;
   }
   public void setName(String name) {
       this.name = name;
   }
   public void setUserEmail(String email)
   {
       this.userEmail = email;
   }


    //getters
    public String getUserID()
    {
        return this.userID;
    }
    public String getName() {
       return this.name;
    }
    public String getUserEmail()
    {
        return this.userEmail;
    }
    public String getCurrLogin()
    {
        return Calendar.getInstance().getTime().toString();
    }


}
