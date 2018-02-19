package com.example.jonny.tagrides;

import java.text.SimpleDateFormat;

/**
 * Created by jonny on 2/16/2018.
 */


class Car {
    //gloabal variables for the car class
    public String car_model;
    public String car_make;
    public int car_year;
    public String licensePlates;
    public String car_nickName;
    public String car_color;

    //constructtors for the object car
    public Car(String name)
    {
       this.car_nickName = name;
    }
    public Car(String model, String make, int year, String licensePlates, String color)
    {
        this.car_make = make;
        this.car_model = model;
        this.car_year = year;
        this.licensePlates = licensePlates;
        this.car_color = color;
    }

    public Car(){}
    //--------------------setter functions------------------------------//

    public void setCarModel(String model)
    {
        this.car_model = model;
    }
    public void setCarMake(String make)
    {
        this.car_make = make;
    }
    public void setCarYear(int year )
    {
        this.car_year = year;
    }
    public void setCarAlias(String aka)
    {
        this.car_nickName = aka;
    }
    public void setCarColor(String color)
    {
        this.car_color =color;
    }
    //--------------------getter functions------------------------------//
    public String getModel()
    {
        return this.car_model;
    }
    public String getCarMake()
    {
        return this.car_make;
    }
    public int getCarYear()
    {
        return this.car_year;
    }
    public String getCarAlias()
    {
        return this.car_nickName;

    }
    public String getCarColor()
    {
        return this.car_color;
    }
}
