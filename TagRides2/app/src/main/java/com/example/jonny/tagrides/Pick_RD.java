package com.example.jonny.tagrides;


import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.widget.TextView;

import java.text.CollationElementIterator;

public class Pick_RD extends Login {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.pick_layout);
        statusTextView.setText("Welcome to Tagrides!\n");
    }

}
