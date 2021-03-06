package com.example.jonny.tagrides.Activities;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import android.content.Intent;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.example.jonny.tagrides.Models.Ride;
import com.example.jonny.tagrides.R;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

public class RiderStatusActivity extends AppCompatActivity {

    private final String TAG = "RiderStatusActivity";

    private String rideID;
    private DatabaseReference database;
    private Ride ride;

    TextView statusTextView;
    Button rideStartButton;
    Button cancelButton;

    private ValueEventListener rideListener = new ValueEventListener() {
        @Override
        public void onDataChange(DataSnapshot dataSnapshot) {
            ride = dataSnapshot.getValue(Ride.class);
            updateUI();
        }

        @Override
        public void onCancelled(DatabaseError databaseError) {
            Log.w(TAG, databaseError.toException());
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_rider_status);

        statusTextView = (TextView) findViewById(R.id.textView);
        rideStartButton = (Button) findViewById(R.id.button);
        cancelButton = (Button) findViewById(R.id.cancelButton);

        statusTextView.setText("Matching you with a driver...");
        rideStartButton.setVisibility(View.INVISIBLE);

        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            rideID = extras.getString("RIDE_ID");
            Log.d(TAG, rideID);
        } else {
            Log.e(TAG, "No ride ID received");
        }
        database = FirebaseDatabase.getInstance().getReference();
        database.child("rides").child(rideID).addValueEventListener(rideListener);
    }

    private void updateUI() {
        if (ride == null) {
            return;
        }

        // TODO: These string DEFINITELY shouldn't be hardcoded
        if (!ride.hasDriver()) {
            // The ride still needs to be accepted by a driver
            statusTextView.setText("Matching you with a driver...");
        } else if (!ride.isDriverArrived()) {
            // The ride has a driver, and the driver is on their way
            statusTextView.setText("Your driver is on the way...");
        } else {
            // The driver is waiting to pick up the passenger
            statusTextView.setText("Your driver has arrived!");
            rideStartButton.setVisibility(View.VISIBLE);
        }
    }

    /** Called when the user presses the "I'm in the car!" button */
    public void startRide(View view) {
        database.child("rides").child(rideID).child("rideInProgress").setValue(true);
        Intent intent = new Intent(this, RiderInProgressActivity.class);
        intent.putExtra("RIDE_ID", rideID);
        startActivity(intent);
    }

    /** Called when the user presses the "Cancel Ride Request" button */
    public void cancelRide(View view) {
        database.child("rides").child(rideID).removeValue();
        startActivity(new Intent(this, PickRiderDriverActivity.class));
    }
}
