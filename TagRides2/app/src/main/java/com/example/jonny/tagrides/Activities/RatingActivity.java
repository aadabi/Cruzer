package com.example.jonny.tagrides;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.RatingBar;
import android.widget.TextView;
import android.widget.Toast;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;

public class RatingActivity extends AppCompatActivity {
    private final String TAG = "RatingActivity";

    private String rideID;
    private float currRating;
    private int numRates;
    private String currUserName;
    private String currUserID;

    private final DatabaseReference database = FirebaseDatabase.getInstance().getReference();
    private final FirebaseUser currUser = FirebaseAuth.getInstance().getCurrentUser();

    private ValueEventListener driverRateListener;      // rider rating the driver, driver's rating
    private ValueEventListener rateDataListener;        // rate model

    private Ride ride;

    private Rate currRate;

    private ArrayList<Float> currRateList = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_rating);

        final RatingBar ratingBar = (RatingBar) findViewById(R.id.ratingBar);
        Button btnSubmit = (Button) findViewById(R.id.btnSubmit);
        final TextView rating = (TextView) findViewById(R.id.rating);

        // gets current ride id from previous layout
        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            rideID = extras.getString("RIDE_ID");
            Log.d(TAG, rideID);
        } else {
            Log.e(TAG, "No ride ID received");
        }

        // rider rates driver, driver rates rider
        rateUser(btnSubmit, rating, ratingBar);

    }

    /* This function gets current ride info and rate info. Listens for submit button
     * to be pressed to update driver's or rider's rating. First ValueEventListener is to get
     * ride data, inner ValueEventListener is to get current rate data about the
     * to be rated user.
     *
     */
    public void rateUser(Button btnSubmit, TextView rating_, RatingBar ratingBar_) {
        // to pass variable into onclick listener
        final TextView rating = rating_;
        final RatingBar ratingBar = ratingBar_;
        // database listener for rides model
        driverRateListener = new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                ride = dataSnapshot.getValue(Ride.class);

                // if the current user is a rider, get driver info to be rated
                if (currUser.getUid().equals(ride.getRiderID())) {
                    currUserID = ride.getDriverID();
                    currUserName = ride.getDriverName();
                    // otherwise, current user is driver, get rider info to be rated
                } else if (currUser.getUid().equals(ride.getDriverID())){
                    currUserID = ride.getRiderID();
                    currUserName = ride.getRiderName();
                } else {
                    System.out.println("some error in finding person to rate");
                }

                // database listener for rate model
                rateDataListener = new ValueEventListener() {
                    @Override
                    public void onDataChange(DataSnapshot dataSnapshot) {
                        // check if rate object exists
                        if (dataSnapshot.exists()) {
                            currRate = dataSnapshot.getValue(Rate.class);
                            // otherwise create new rate object for user
                        } else {
                            Rate temp = new Rate();
                            currRate = temp;
                        }

                        // get number of ratings and list of ratings from current user (driver)
                        numRates = currRate.getNumRates();
                        currRateList = currRate.getRatingsList();

                    }

                    @Override
                    public void onCancelled(DatabaseError databaseError) {
                        Log.w(TAG, databaseError.toException());
                    }
                };

                database.child("rate").child(currUserID).addValueEventListener(rateDataListener);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                Log.w(TAG, databaseError.toException());
            }
        };
        database.child("rides").child(rideID).addValueEventListener(driverRateListener);

        // listens for submit button to be pressed in layout
        btnSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                currRating = ratingBar.getRating();
                rating.setText("You gave a rating: " + currRating);
                submitRate(currRating);

            }
        });
    }

    /* This function is called to store the rate model into the database.
     * It sets the current user name (driver or rider) to be rated by the rider.
     * It sets the current user id (driver id or rider id) into the rate model.
     * Then it sets the number of ratings from the current user (previous ratings).
     * It gets an array list of all previous ratings and adds the new ratings given
     * to the list of all ratings for this current user (driver or rider). Finally, it
     * sets the new rating of the user (driver or rider) to be the average of values in
     * the array list. Once the values are set, the rate object is stored into
     * the rate model for the current user (driver or rider).
     *
     */
    public void submitRate(float newRating) {
        currRate.setUserName(currUserName);
        currRate.setUserID(currUserID);

        currRate.setNumRates(numRates);
        currRate.setRatingsList(currRateList);
        currRate.addRatings(newRating);

        currRate.setRating(currRate.calcRatings());

        database.child("rate").child(currRate.getUserID()).setValue(currRate);

        Toast.makeText(RatingActivity.this,"Submitted RatingActivity of " + String.valueOf(newRating), Toast.LENGTH_SHORT).show();

        // sends user back to pick rider/driver page
        Intent back = new Intent(RatingActivity.this, PickRiderDriverActivity.class);
        startActivity(back);
    }

}
