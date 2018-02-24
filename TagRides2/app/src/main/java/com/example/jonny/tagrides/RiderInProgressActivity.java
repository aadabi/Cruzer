package com.example.jonny.tagrides;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

public class RiderInProgressActivity extends AppCompatActivity {

    private String rideID;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_rider_in_progress);

        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            rideID = extras.getString("rideID");
        } else {
            // something went wrong
        }
    }
}
