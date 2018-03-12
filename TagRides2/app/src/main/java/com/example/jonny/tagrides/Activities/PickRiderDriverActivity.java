package com.example.jonny.tagrides.Activities;


import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.example.jonny.tagrides.R;

public class PickRiderDriverActivity extends Login{

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.pick_layout);
        statusTextView.setText("Welcome to Tagrides!\n");


        Button btnRider = (Button)findViewById(R.id.btnRider);

        Button btnDriver = (Button)findViewById(R.id.btnDriver);

        btnDriver.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(PickRiderDriverActivity.this, DriverActivity.class));
            }
        });
        btnRider.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(PickRiderDriverActivity.this, RiderMapActivity.class));
            }
        });
    }

}
