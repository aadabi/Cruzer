package com.example.jonny.tagrides;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;

public class RiderStatusActivity extends AppCompatActivity {

    private final String TAG = "RiderStatusActivity";

    private String rideID;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_rider_status);
        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            this.rideID = extras.getString("RIDE_ID");
            Log.d(TAG, this.rideID);
        } else {
            Log.e(TAG, "No ride ID received");
        }
    }
}
