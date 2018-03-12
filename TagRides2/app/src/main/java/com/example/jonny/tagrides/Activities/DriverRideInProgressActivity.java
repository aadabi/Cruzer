package com.example.jonny.tagrides;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

public class DriverRideInProgressActivity extends AppCompatActivity {

    private final String TAG = "Driver Ride in Progress";
    private String rideID;
    private String startLocation;
    private String destinationLocation;
    private DatabaseReference database;

    private Button driverArrivedButton;
    private TextView startLocationView;
    private TextView destinationLocationView;

    private ValueEventListener rideListener = new ValueEventListener() {
        @Override
        public void onDataChange(DataSnapshot dataSnapshot) {
            if (dataSnapshot.getValue() == null) {
                Toast.makeText(DriverRideInProgressActivity.this,"Ride was cancelled", Toast.LENGTH_SHORT).show();
                startActivity(new Intent(DriverRideInProgressActivity.this, PickRiderDriverActivity.class));
            } else {
                Ride ride = dataSnapshot.getValue(Ride.class);
                startLocation = ride.getCurrentLocation();
                destinationLocation = ride.getDestination();
                startLocationView.setText("Start location: " + startLocation);
                destinationLocationView.setText("Destination location: " + destinationLocation);
                if (ride.isRideCompleted()) {
                    sendToRatingActivity();
                }
            }
        }

        @Override
        public void onCancelled(DatabaseError databaseError) {
            Log.w(TAG, databaseError.toException());
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_driver_ride_in_progress);

        database = FirebaseDatabase.getInstance().getReference();
        driverArrivedButton = (Button) findViewById(R.id.button);
        startLocationView = (TextView) findViewById(R.id.startLocation);
        destinationLocationView = (TextView) findViewById(R.id.destLocation);

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
        database.child("rides").child(rideID).addValueEventListener(rideListener);
    }

    private void sendToRatingActivity() {
        Intent intent = new Intent(this, RatingActivity.class);
        intent.putExtra("RIDE_ID", rideID);
        startActivity(intent);
    }
}
