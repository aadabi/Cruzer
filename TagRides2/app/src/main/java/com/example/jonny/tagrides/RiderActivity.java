package com.example.jonny.tagrides;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

public class RiderActivity extends Activity {

    final String TAG = "RiderActivity";
    EditText destinationInput;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_rider);

        destinationInput = (EditText) findViewById(R.id.editText);
    }

    /** Called when the user presses the send button */
    public void sendRideRequest(View view) {
        FirebaseUser currUser = FirebaseAuth.getInstance().getCurrentUser();
        Ride ride = new Ride();
        ride.setRiderID(currUser.getUid());
        ride.setDestination(destinationInput.getText().toString());
        DatabaseReference myRef = FirebaseDatabase.getInstance().getReference();
        String rideID = myRef.child("rides").push().getKey();
        myRef.child("rides").child(rideID).setValue(ride);
        Intent intent = new Intent(this, RiderStatusActivity.class);
        intent.putExtra("RIDE_ID", rideID);
        startActivity(intent);
    }

}