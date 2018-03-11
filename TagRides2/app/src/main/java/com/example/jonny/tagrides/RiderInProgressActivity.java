package com.example.jonny.tagrides;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.Button;
import android.view.View;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

public class RiderInProgressActivity extends AppCompatActivity {

    private final String TAG = "RiderInProgressActivity";

    private String rideID;
    private DatabaseReference database;
    private ValueEventListener rideListener;
    private Ride ride;
    private String driverID;

    Button rideEndButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_rider_in_progress);

        rideEndButton = (Button) findViewById(R.id.button2);
        database = FirebaseDatabase.getInstance().getReference();

        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            rideID = extras.getString("RIDE_ID");
            Log.d(TAG, rideID);
        } else {
            Log.e(TAG, "No ride ID received");
        }

        rideListener = new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                ride = dataSnapshot.getValue(Ride.class);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                Log.w(TAG, databaseError.toException());
            }
        };
        database.child("rides").child(rideID).addValueEventListener(rideListener);
    }

    public void endRide(View v) {
        database.child("rides").child(rideID).child("rideInProgress").setValue(false);
        database.child("rides").child(rideID).child("rideCompleted").setValue(true);
        Intent intent = new Intent(this, Rating.class);
        intent.putExtra("RIDE_ID", rideID);
        startActivity(intent);
    }
}
