package com.example.jonny.tagrides;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

public class DriverRideInProgress extends AppCompatActivity {

    private final String TAG = "Driver Ride in Progress";
    private String rideID;
    private DatabaseReference database;
    private ValueEventListener rideListener;
    private Button driverArrivedButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_driver_ride_in_progress);

        database = FirebaseDatabase.getInstance().getReference();
        driverArrivedButton = (Button) findViewById(R.id.button);

        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            rideID = extras.getString("RIDE_ID");
            Log.d(TAG, rideID);
        } else {
            Log.e(TAG, "No ride ID received");
        }
        driverArrivedButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                database.child("rides").child(rideID).child("driverArrived").setValue(true);
            }
        });
        rideListener = new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                Ride ride = dataSnapshot.getValue(Ride.class);
                Log.d(TAG, Boolean.toString(ride.isRideCompleted()));
                if (ride.isRideCompleted()) {
                    sendToRatingActivity();
                }
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                Log.w(TAG, databaseError.toException());
            }
        };
        database.child("rides").child(rideID).addValueEventListener(rideListener);
    }

    private void sendToRatingActivity() {
        Intent intent = new Intent(this, Rating.class);
        intent.putExtra("RIDE_ID", rideID);
        startActivity(intent);
    }
}
