package com.example.jonny.tagrides.Models;

import java.util.ArrayList;

public class Rate {
    public String userName;
    public float rating;
    public int numRates;
    public String userID;


    public ArrayList<Float> ratingsList;

    public Rate () {
        this.userName = "";
        this.rating = 0;
        this.ratingsList = new ArrayList<>();
        this.numRates = 0;
        this.userID = "";

    }
    //set
    public void setRating(float rate) {
        this.rating = rate;
    }
    public void setUserID(String uid) {
        this.userID = uid;
    }
    public void setUserName(String name) {
        this.userName = name;
    }
    public void setRatingsList(ArrayList<Float> list) {
        this.ratingsList = list;
    }
    public void setNumRates(int num) {
        this.numRates = num;
    }

    //get
    public float getRating() {
        return this.rating;
    }
    public ArrayList<Float> getRatingsList() {
        return this.ratingsList;
    }
    public String getUserID() {
        return this.userID;
    }
    public String getUserName() {
        return this.userName;
    }
    public int getNumRates() {
        return ratingsList.size();
    }

    // functions
    public float calcRatings() {
        float sum = 0;
        for (int i = 0; i < ratingsList.size(); i++ ) {
            sum += ratingsList.get(i);
        }
        float num = (float) ratingsList.size();
        float res = (sum / num);
        return res;
    }
    public void addRatings(float rate) {
        this.numRates = this.numRates + 1;
        ratingsList.add(rate);
    }


}
