package com.example.jonny.tagrides;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.RatingBar;
import android.widget.TextView;

public class Rating extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_rating);

        final RatingBar ratingBar = (RatingBar) findViewById(R.id.ratingBar);
        Button btnSubmit = (Button) findViewById(R.id.btnSubmit);
        final TextView rating = (TextView) findViewById(R.id.rating);

        btnSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                rating.setText("Your Rating is:" + ratingBar.getRating());
            }
        });
    }
}
