package com.example.jonny.tagrides;

import android.content.Intent;
import android.os.SystemClock;
import android.provider.ContactsContract;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.RatingBar;
import android.widget.TextView;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;

public class Rating extends AppCompatActivity {
    private final String TAG = "Rating";

    private String rideID;
    private float currRating;
    private int numRates;
    private String currUserName;
    private String currUserID;

    private final DatabaseReference database = FirebaseDatabase.getInstance().getReference();

    private ValueEventListener driverRateListener;  // rider rating the driver, driver's rating
    private ValueEventListener rateData;

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


        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            rideID = extras.getString("RIDE_ID");
            Log.d(TAG, rideID);
        } else {
            Log.e(TAG, "No ride ID received");
        }

        driverRateListener = new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                ride = dataSnapshot.getValue(Ride.class);

                currUserName = ride.getDriverName();
                currUserID = ride.getDriverID();

                rateData = new ValueEventListener() {
                    @Override
                    public void onDataChange(DataSnapshot dataSnapshot) {
                        currRate = dataSnapshot.getValue(Rate.class);

                        numRates = currRate.getNumRates();
                        currRateList = currRate.getRatingsList();

                    }

                    @Override
                    public void onCancelled(DatabaseError databaseError) {
                        Log.w(TAG, databaseError.toException());
                    }
                };

                database.child("rate").child(currUserID).addValueEventListener(rateData);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                Log.w(TAG, databaseError.toException());
            }
        };
        database.child("rides").child(rideID).addValueEventListener(driverRateListener);


        btnSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                rating.setText("You gave a rating: " + ratingBar.getRating());
                currRating = ratingBar.getRating();
                submitDriverRate(currRating);

            }
        });
    }

    public void submitDriverRate(float newRating) {
        currRate.setUserName(currUserName);
        currRate.setUserID(currUserID);

        currRate.setNumRates(numRates);
        currRate.setRatingsList(currRateList);
        currRate.addRatings(newRating);

        currRate.setRating(currRate.calcRatings());

        database.child("rate").child(currRate.getUserID()).setValue(currRate);

        Utils.toastMessage("Submited Rating of "+ String.valueOf(newRating), Rating.this);
        Intent back = new Intent(Rating.this, Pick_RD.class);
        startActivity(back);
    }
}
