package com.example.jonny.tagrides.Activities;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import com.example.jonny.tagrides.Models.Ride;
import com.example.jonny.tagrides.R;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.ChildEventListener;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import java.util.ArrayList;

public class DriverActivity extends AppCompatActivity {

    private final String TAG = "DriverActivity";

    private DatabaseReference database;

    private ArrayList<String> rideList;
    private ArrayList<String> rideKeyList;
    private ListView rideListView;
    private ArrayAdapter<String> rideListAdapter;

    private ChildEventListener childEventListener = new ChildEventListener() {
        @Override
        public void onChildAdded(DataSnapshot dataSnapshot, String s) {
            Ride ride = dataSnapshot.getValue(Ride.class);
            if (!ride.hasDriver()) {
                String currLocation = ride.getCurrentLocation();
                String destination = ride.getDestination();
                String riderName = ride.getRiderName();
                rideList.add("From: " + currLocation + ", To: " + destination + ", Name: " + riderName);

                String key = dataSnapshot.getKey();
                rideKeyList.add(key);

                rideListAdapter.notifyDataSetChanged();
            }
        }

        @Override
        public void onChildChanged(DataSnapshot dataSnapshot, String s) {
            Ride ride = dataSnapshot.getValue(Ride.class);
            String currLocation = ride.getCurrentLocation();
            String destination = ride.getDestination();
            String riderName = ride.getRiderName();
            String rideString = "From: " + currLocation + ", To: " + destination + ", Name: " + riderName;
            if (rideList.contains(rideString) && ride.hasDriver()) {
                int position = rideList.indexOf(rideString);
                rideList.remove(position);
                rideKeyList.remove(position);
                rideListAdapter.notifyDataSetChanged();
            }
        }

        @Override
        public void onChildRemoved(DataSnapshot dataSnapshot) {
            Ride ride = dataSnapshot.getValue(Ride.class);
            String currLocation = ride.getCurrentLocation();
            String destination = ride.getDestination();
            String riderName = ride.getRiderName();
            String rideString = "From: " + currLocation + ", To: " + destination + ", Name: " + riderName;
            if (rideList.contains(rideString)) {
                int position = rideList.indexOf(rideString);
                rideList.remove(position);
                rideKeyList.remove(position);
                rideListAdapter.notifyDataSetChanged();
            }
        }

        // This method is only relevant when working with ordered data.
        @Override
        public void onChildMoved(DataSnapshot dataSnapshot, String s) {}

        @Override
        public void onCancelled(DatabaseError databaseError) {
            Log.w(TAG, databaseError.toException());
        }
    };

    private AdapterView.OnItemClickListener adapterClickListener = new AdapterView.OnItemClickListener() {
        @Override
        public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
            handleRideSelection(position);
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_driver);

        rideListView = (ListView) findViewById(R.id.allRidesview);
        rideList = new ArrayList<String>();
        rideKeyList = new ArrayList<String>();
        rideListAdapter = new ArrayAdapter<String>(DriverActivity.this, android.R.layout.simple_dropdown_item_1line, rideList);
        rideListView.setAdapter(rideListAdapter);
        rideListView.setOnItemClickListener(adapterClickListener);

        database = FirebaseDatabase.getInstance().getReference();

        database.child("rides").addChildEventListener(childEventListener);
    }

    public void handleRideSelection(int position) {
        final int index = position;
        AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(this);
        alertDialogBuilder.setTitle("Do you want to add this rider");
        alertDialogBuilder.setPositiveButton("Yes", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface arg0, int arg1)
            {
                FirebaseUser currUser = FirebaseAuth.getInstance().getCurrentUser();
                String rideID = rideKeyList.get(index);

                database.child("rides").child(rideID).child("driverID").setValue(currUser.getUid());
                database.child("rides").child(rideID).child("rideInProgress").setValue(true);
                database.child("rides").child(rideID).child("driverName").setValue(currUser.getDisplayName());

                Toast.makeText(DriverActivity.this,"Rider added to ride",Toast.LENGTH_SHORT).show();

                openDriverRideInProgressActivity(rideID);
            }
        });

        alertDialogBuilder.setNegativeButton("No",new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface arg0, int arg1) {}
        });

        AlertDialog alertDialog = alertDialogBuilder.create();
        alertDialog.show();
    }

    private void openDriverRideInProgressActivity(String rideID) {
        Intent intent = new Intent(this, DriverRideInProgressActivity.class);
        intent.putExtra("RIDE_ID", rideID);
        startActivity(intent);
    }
}
