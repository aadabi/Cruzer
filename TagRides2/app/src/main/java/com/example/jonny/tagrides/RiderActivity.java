package com.example.jonny.tagrides;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.ActivityCompat;
import android.test.mock.MockPackageManager;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

public class RiderActivity extends Activity {

    final String TAG = "RiderActivity";
    private static final  int REQUEST_CODE_PERMISSION =2;
    String mPermisssion = android.Manifest.permission.ACCESS_FINE_LOCATION;

    GPSTracker gps;
    TextView location;
    Button btnShowLocation;
    EditText currentLocation;
    EditText destinationInput;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_rider);

        try{
            if (ActivityCompat.checkSelfPermission(this,mPermisssion)!= MockPackageManager.PERMISSION_GRANTED){
                ActivityCompat.requestPermissions(this,new String[]{mPermisssion},REQUEST_CODE_PERMISSION);
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        btnShowLocation = (Button) findViewById(R.id.button3);
        btnShowLocation.setOnClickListener(new View.OnClickListener(){

            public void onClick(View v){
                gps = new GPSTracker(RiderActivity.this);
                location = (TextView) findViewById(R.id.textView2);
                if (gps.canGetLocation()){
                    double latitude = gps.getLatitude();
                    double longitude = gps.getLongitude();
                    location.setText(latitude+"/"+longitude);


                }else{
                    return;
                }
            }
        });

        currentLocation = (EditText) findViewById(R.id.currText);
        destinationInput = (EditText) findViewById(R.id.destText);
    }

    /** Called when the user presses the send button */
    public void sendRideRequest(View view) {
        FirebaseUser currUser = FirebaseAuth.getInstance().getCurrentUser();
        Ride ride = new Ride();
        ride.setRiderID(currUser.getUid());
        ride.setCurrentLocation(currentLocation.getText().toString());
        ride.setDestination(destinationInput.getText().toString());
        ride.setRiderName(currUser.getDisplayName());
        DatabaseReference myRef = FirebaseDatabase.getInstance().getReference();
        String rideID = myRef.child("rides").push().getKey();
        myRef.child("rides").child(rideID).setValue(ride);
        Intent intent = new Intent(this, RiderStatusActivity.class);
        intent.putExtra("RIDE_ID", rideID);
        startActivity(intent);
    }

}
