package com.example.jonny.tagrides.Activities;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.ActivityCompat;
import android.test.mock.MockPackageManager;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.example.jonny.tagrides.Models.Ride;
import com.example.jonny.tagrides.R;
import com.example.jonny.tagrides.Utils.GPSTracker;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

public class RiderActivity extends Activity {

    private final String TAG = "RiderActivity";
    private static final  int REQUEST_CODE_PERMISSION = 2;
    private String permission = android.Manifest.permission.ACCESS_FINE_LOCATION;

    GPSTracker gps;
    DatabaseReference database;

    Button btnShowLocation;
    EditText currentLocation;
    EditText destinationInput;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_rider);

        try{
            if (ActivityCompat.checkSelfPermission(this,permission)!= MockPackageManager.PERMISSION_GRANTED){
                ActivityCompat.requestPermissions(this,new String[]{permission},REQUEST_CODE_PERMISSION);
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        database = FirebaseDatabase.getInstance().getReference();

        btnShowLocation = (Button) findViewById(R.id.button3);
        currentLocation = (EditText) findViewById(R.id.currText);
        destinationInput = (EditText) findViewById(R.id.destText);

        btnShowLocation.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                gps = new GPSTracker(RiderActivity.this);
                if (gps.canGetLocation()){
                    double latitude = gps.getLatitude();
                    double longitude = gps.getLongitude();

                    FirebaseUser currUser = FirebaseAuth.getInstance().getCurrentUser();

                    Ride ride = new Ride();
                    ride.setRiderID(currUser.getUid());
                    ride.setLatitude(latitude);
                    ride.setLongitude(longitude);
                    ride.setCurrentLocation(currentLocation.getText().toString());
                    ride.setDestination(destinationInput.getText().toString());
                    ride.setRiderName(currUser.getDisplayName());

                    String rideID = database.child("rides").push().getKey();
                    database.child("rides").child(rideID).setValue(ride);
                    Intent intent = new Intent(v.getContext(), RiderStatusActivity.class);
                    intent.putExtra("RIDE_ID", rideID);
                    startActivity(intent);
                }
            }
        });
    }
}
