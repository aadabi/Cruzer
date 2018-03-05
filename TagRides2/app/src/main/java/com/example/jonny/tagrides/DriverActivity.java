package com.example.jonny.tagrides;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.ChildEventListener;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import java.util.ArrayList;

public class DriverActivity extends MainActivity{

    private FirebaseAuth rideAuth;
    private DatabaseReference userReference;
    private DatabaseReference rideReference;
    private FirebaseDatabase userDatabase;
    private FirebaseDatabase rideDatabase;
    private String _rideID;

    //array list for rides
    ArrayList<String> myRides = new ArrayList<String>();
    //listview for my rides
    ListView rideList;
    //adapter for rides listvie
    ArrayAdapter<String> adapter;

    Ride rideInfo;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_driver);

        //begin to get the information for our Rides from firebase
        //intantiateFirebase();
        firebaseListener();
    }


    //fiunction to listen for changes in the database
    public void firebaseListener()
    {
        //this is where we listen for data changes when new rides get posted
        rideList = (ListView) findViewById(R.id.allRidesview);
        rideDatabase = FirebaseDatabase.getInstance();
        userDatabase = FirebaseDatabase.getInstance();
        userReference = userDatabase.getReference("user");
        rideReference = rideDatabase.getReference().child("rides");

        adapter = new ArrayAdapter<String>(DriverActivity.this, android.R.layout.simple_dropdown_item_1line, myRides);

        rideReference.addChildEventListener(new ChildEventListener() {
            @Override
            public void onChildAdded(DataSnapshot dataSnapshot, String s) {
                rideInfo = dataSnapshot.getValue(Ride.class);
                String rideDestInfo = rideInfo.getDestination();
                //we dont need to display driver info
                //String rideDriverInfo= rideInfo.getDriverID();
                String rideRiderInfo = rideInfo.getRiderID();

                myRides.add(rideDestInfo);

                //myRides.add(rideDriverInfo);
                myRides.add(rideRiderInfo);


                rideList.setAdapter(adapter);
                adapter.notifyDataSetChanged();
            }

            @Override
            public void onChildChanged(DataSnapshot dataSnapshot, String s)
            {
                //insert new modified value

                Ride valueUpdated = dataSnapshot.getValue(Ride.class);
                String key = dataSnapshot.getKey();
                String modifyDest = valueUpdated.getDestination();
                String modifyDId  = valueUpdated.getDriverID();
                String modifyRId  = valueUpdated.getRiderID();


                //get the location where change happened
                int index = myRides.indexOf(key)+1;
                //set the change to the adapter
                myRides.set(index, modifyDest);
                //myRides.set(index, modifyDId);
                //myRides.set(index,modifyRId);


                rideList.setAdapter(adapter);
                adapter.notifyDataSetChanged();

            }

            @Override
            public void onChildRemoved(DataSnapshot dataSnapshot) {


                Ride rideInfo = dataSnapshot.getValue(Ride.class);

                String rideDestInfo = rideInfo.getDestination();
                String rideDriverInfo= rideInfo.getDriverID();
                String rideRiderInfo = rideInfo.getRiderID();

                myRides.remove(rideDestInfo);
                myRides.remove(rideDriverInfo);
                myRides.remove(rideRiderInfo);



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
                dselectRide();
            }
        });
    }

    //method that gets called when the user clicks on the list
    //cretes  pop up view to select ride
    public void dselectRide()
    {
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
                        //rideInfo.setDriverID(currUser.getUid());
                        DatabaseReference myRef = FirebaseDatabase.getInstance().getReference();
                        String rideID = rideInfo.child("rides").push().getKey();
                        //myRef.child("rides").child(rideID).setValue(ride);

                        //lets the user know the ride was added
                        Utils.toastMessage("Rider Added to Ride", DriverActivity.this);

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


}