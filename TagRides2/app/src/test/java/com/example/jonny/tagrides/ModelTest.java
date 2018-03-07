package com.example.jonny.tagrides;

import org.junit.Test;

import java.util.ArrayList;

import static org.junit.Assert.*;

public class ModelTest {

    @Test
    public void testUserModelName() {
        // set up
        User user = new User();

        // excersise
        user.setName("My Name");

        // assert
        assertEquals(user.getName(), "My Name");
    }

    @Test
    public void testUserModelUserID() {
        // set up
        User user = new User();

        // excersise
        user.setUserID("aaaaaaaaaaaaaaaaaaaaaaa");

        // assert
        assertEquals(user.getUserID(), "aaaaaaaaaaaaaaaaaaaaaaa");
    }

    @Test
    public void testUserModelUserEmail() {
        // set up
        User user = new User();

        // excersise
        user.setUserEmail("example@gmail.com");

        // assert
        assertEquals(user.getUserEmail(), "example@gmail.com");
    }

    @Test
    public void testUserModelRider() {
        // set up
        User user = new User();

        // excersise
        user.setRider();

        // assert
        assertEquals(user.getRider(), true);
    }

    @Test
    public void testUserModelDriver() {
        // set up
        User user = new User();

        // excersise
        user.setDriver();

        // assert
        assertEquals(user.getDriver(), true);
    }

    @Test
    public void testRideRiderName() {
        // set up
        Ride ride = new Ride();

        // excersise
        ride.setRiderName("My Name");

        // assert
        assertEquals(ride.getRiderName(), "My Name");
    }

    @Test
    public void testRideRiderID() {
        // set up
        Ride ride = new Ride();

        // excersise
        ride.setRiderID("aaaaaaaaaaaaaaaaaaaaaaa");

        // assert
        assertEquals(ride.getRiderID(), "aaaaaaaaaaaaaaaaaaaaaaa");
    }

    @Test
    public void testRideRideCurrentLocation() {
        // set up
        Ride ride = new Ride();

        // excersise
        ride.setCurrentLocation("Here");

        // assert
        assertEquals(ride.getCurrentLocation(), "Here");
    }

    @Test
    public void testRideDestination() {
        // set up
        Ride ride = new Ride();

        // excersise
        ride.setDestination("SomewhereElse");

        // assert
        assertEquals(ride.getDestination(), "SomewhereElse");
    }

    @Test
    public void testRideDriverName() {
        // set up
        Ride ride = new Ride();

        // excersise
        ride.setDriverName("My Name");

        // assert
        assertEquals(ride.getDriverName(), "My Name");
    }

    @Test
    public void testRideDriverID() {
        // set up
        Ride ride = new Ride();

        // excersise
        ride.setDriverID("bbbbbbbbbbbbbbb");

        // assert
        assertEquals(ride.getDriverID(), "bbbbbbbbbbbbbbb");
    }

    @Test
    public void testRideRiderLongitude() {
        // set up
        Ride ride = new Ride();

        // excersise
        ride.setLongitude(127.12003);

        // assert
        assertEquals(ride.getLongitude(), 127.12003, 0.000001 );
    }

    @Test
    public void testRideRiderLatitude() {
        // set up
        Ride ride = new Ride();

        // excersise
        ride.setLatitude(66.12003);

        // assert
        assertEquals(ride.getLatitude(), 66.12003, 0.000001 );
    }

    @Test
    public void testRateRating() {
        // set up
        Rate rate = new Rate();

        // excersise
        rate.setRating(5);

        // assert
        assertEquals(rate.getRating(), 5, 0.1);
    }

    @Test
    public void testRateNumRates() {
        // set up
        Rate rate = new Rate();
        ArrayList<Float> list = new ArrayList<>();

        // excersise
        list.add((float) 1);
        list.add((float) 1);
        list.add((float) 1);
        list.add((float) 1);
        list.add((float) 1);

        rate.setRatingsList(list);

        // assert
        assertEquals(rate.getNumRates(), 5, 0.1);
    }

    @Test
    public void testRateUserID() {
        // set up
        Rate rate = new Rate();

        // excersise
        rate.setUserID("ccccccccccccccc");

        // assert
        assertEquals(rate.getUserID(), "ccccccccccccccc");
    }

    @Test
    public void testRateUserName() {
        // set up
        Rate rate = new Rate();

        // excersise
        rate.setUserName("My Name");

        // assert
        assertEquals(rate.getUserName(), "My Name");
    }

    @Test
    public void testRateRatingsList() {
        // set up
        Rate rate = new Rate();
        ArrayList<Float> list = new ArrayList<>();

        // excersise
        rate.setRatingsList(list);

        // assert
        assertEquals(rate.getRatingsList(), list);
    }

    @Test
    public void testRateCalcRatings() {
        // set up
        Rate rate = new Rate();

        // excersise
        rate.ratingsList.add((float)4);
        rate.ratingsList.add((float)5);
        rate.ratingsList.add((float)3);
        rate.ratingsList.add((float)3);

        // assert
        assertEquals(rate.calcRatings(), 3.75, 0.01);
    }


}
