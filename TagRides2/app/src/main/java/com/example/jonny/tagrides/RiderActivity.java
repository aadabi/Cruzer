package com.example.jonny.tagrides;

import android.app.Activity;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;

public class RiderActivity extends Activity {

    EditText destinationInput;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_rider);

        destinationInput = (EditText) findViewById(R.id.editText);
    }

    /** Called when the user presses the send button */
    public void sendRideRequest(View view) {
        Log.v("ride request", destinationInput.getText().toString());
    }
}
