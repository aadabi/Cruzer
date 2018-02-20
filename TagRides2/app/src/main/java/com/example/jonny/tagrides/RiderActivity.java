package com.example.jonny.tagrides;

import android.*;
import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.location.Location;
import android.support.design.widget.Snackbar;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;

import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

public class RiderActivity extends Activity
        implements ActivityCompat.OnRequestPermissionsResultCallback {

    EditText destinationInput;
    private FusedLocationProviderClient mFusedLocationClient;
    private static final int PERMISSION_REQUEST_LOCATION = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_rider);

        destinationInput = (EditText) findViewById(R.id.editText);
        mFusedLocationClient = LocationServices.getFusedLocationProviderClient(this);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions,
                                           int[] grantResults) {
        if (requestCode == PERMISSION_REQUEST_LOCATION) {
            // Request for location permission.
            if (grantResults.length == 1 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                // Permission has been granted.
                Log.v("ride request", "PERMISSION GRANTED!!!!!");
            } else {
                Log.v("ride request", "PERMISSION DENIED :(((((");
            }
        }
    }

    /** Called when the user presses the send button */
    public void sendRideRequest(View view) {
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION)
                == PackageManager.PERMISSION_GRANTED) {
            Log.v("ride request", "PERMISSION ALREADY GRANTED!!!!");
        } else {
            requestLocationPermission();
        }
//        FirebaseUser currUser = FirebaseAuth.getInstance().getCurrentUser();
//        String uid = currUser.getUid();
//        String destination = destinationInput.getText().toString();
//        mFusedLocationClient.getLastLocation()
//                .addOnSuccessListener(this, new OnSuccessListener<Location>() {
//                    @Override
//                    public void onSuccess(Location location) {
//                        if (location != null) {
//                            Log.v(location.toString());
//                        }
//                    }
//                });
//        Ride ride = new Ride(uid, "", destination);
//        DatabaseReference myRef = FirebaseDatabase.getInstance().getReference();
//        String rideKey = myRef.child("rides").push().getKey();
//        myRef.child("rides").child(rideKey).setValue(ride);
    }

    private void requestLocationPermission() {
        // Permission has not been granted and must be requested.
        ActivityCompat.requestPermissions(this,
                new String[]{Manifest.permission.ACCESS_FINE_LOCATION}, PERMISSION_REQUEST_LOCATION);
    }
}
