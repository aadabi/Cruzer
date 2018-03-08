package com.example.jonny.tagrides;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.provider.ContactsContract;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import com.google.android.gms.drive.Drive;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.ChildEventListener;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;


import java.util.ArrayList;

public class DriverActivity extends AppCompatActivity {

    private final DatabaseReference mRootRef = FirebaseDatabase.getInstance().getReference();

    private String rideID;

    //array list for rides
    ArrayList<String> myRides = new ArrayList<String>();
    //listview for my rides
    ListView rideList;
    //adapter for rides listview
    ArrayAdapter<String> adapter;

    Ride rideInfo;
    User userInfo;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_driver);

        //begin to get the information for our Rides from firebase
        //intantiateFirebase();
        DatabaseReference rideDB = mRootRef.child("rides");
        DatabaseReference userDB = mRootRef.child("users");
        firebaseListener(rideDB, userDB);
    }

    //fiunction to listen for changes in the database
    public void firebaseListener(DatabaseReference rideDatabase, DatabaseReference userDatabase)
    {
        //this is where we listen for data changes when new rides get posted
        rideList = (ListView) findViewById(R.id.allRidesview);

        adapter = new ArrayAdapter<String>(DriverActivity.this, android.R.layout.simple_dropdown_item_1line, myRides);

        //rideReference.addChildEventListener(new ChildEventListener() {
        rideDatabase.addChildEventListener(new ChildEventListener() {
            @Override
            public void onChildAdded(DataSnapshot dataSnapshot, String s) {
                rideInfo = dataSnapshot.getValue(Ride.class);
                userInfo = dataSnapshot.getValue(User.class);

                // get destination and rider's name to display
                String rideDestInfo = rideInfo.getDestination();
                String rideRiderInfo = rideInfo.getRiderName();
                rideID = dataSnapshot.getKey();

                if (!rideInfo.isRideInProgress() && rideInfo.getDriverID().equals("")) {
                    myRides.add("Destination: "+rideDestInfo+"  "+"Rider Name: "+rideRiderInfo);
                }

                rideList.setAdapter(adapter);
                adapter.notifyDataSetChanged();
            }

            @Override
            public void onChildChanged(DataSnapshot dataSnapshot, String s)
            {
                //insert new modified value

                Ride valueUpdated = dataSnapshot.getValue(Ride.class);
                String modifyDest = valueUpdated.getDestination();
                String modifyRName = valueUpdated.getRiderName();



                //get the location where change happened
                if (valueUpdated.isRideInProgress() && !valueUpdated.getDriverID().equals("")) {
                    myRides.remove("Destination: "+modifyDest+"  "+"Rider Name: "+modifyRName);
                    rideList.setAdapter(adapter);
                    adapter.notifyDataSetChanged();
                }
            }
            // maybe later
            @Override
            public void onChildRemoved(DataSnapshot dataSnapshot) {

                rideList.setAdapter(adapter);
                adapter.notifyDataSetChanged();

            }
            //for now we wont deal with this yet
            @Override
            public void onChildMoved(DataSnapshot dataSnapshot, String s) {

            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                String message = "Server error. Refresh page";
                Toast.makeText(DriverActivity.this, message, Toast.LENGTH_SHORT).show();

            }
        });

        //here we declare a listener
        rideList.setOnItemClickListener(new AdapterView.OnItemClickListener(){


            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                dselectRide(position);

            }
        });
    }

    //method that gets called when the user clicks on the list
    //cretes  pop up view to select ride
    public void dselectRide(int position)
    {
        final int pos = position;
        AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(this);
        alertDialogBuilder.setTitle("Do you want to add this rider");
        alertDialogBuilder.setPositiveButton("Yes",
                new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface arg0, int arg1)
                    {
                        DatabaseReference rideInfo = FirebaseDatabase.getInstance().getReference();
                        //this code should set the driver but from here we need to send that info to another activity
                        FirebaseUser currUser = FirebaseAuth.getInstance().getCurrentUser();

                        // add current ride id fields to database

                        rideInfo.child("rides").child(rideID).child("driverID").setValue(currUser.getUid());
                        rideInfo.child("rides").child(rideID).child("rideInProgress").setValue(true);
                        rideInfo.child("rides").child(rideID).child("driverName").setValue(currUser.getDisplayName());

                        //lets the user know the ride was added
                        Utils.toastMessage("Rider Added to Ride", DriverActivity.this);

                        openDriverRideInProgressActivity();
                    }
                });

        alertDialogBuilder.setNegativeButton("No",new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface arg0, int arg1)
            {
            }
        });
        AlertDialog alertDialog = alertDialogBuilder.create();
        alertDialog.show();

    }

    private void openDriverRideInProgressActivity() {
        Intent intent = new Intent(this, DriverMapActivity.class);
        intent.putExtra("RIDE_ID", rideID);
        startActivity(intent);
    }
}
