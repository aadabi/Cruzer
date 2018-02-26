package com.example.jonny.tagrides;


import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class Pick_RD extends Login{

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.pick_layout);
        statusTextView.setText("Welcome to Tagrides!\n");


        Button btnRider = (Button)findViewById(R.id.btnRider);

        /*btnRider.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(Pick_RD.this, RiderActivity.class));
            }
        });*/

        Button btnDriver = (Button)findViewById(R.id.btnDriver);

        btnDriver.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(Pick_RD.this, postRides.class));
            }
        });
        btnRider.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(Pick_RD.this, RiderActivity.class));
            }
        });
    }

}
