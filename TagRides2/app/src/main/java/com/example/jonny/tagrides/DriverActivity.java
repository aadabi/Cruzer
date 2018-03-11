package com.example.jonny.tagrides;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.provider.ContactsContract;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
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
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;

public class DriverActivity extends AppCompatActivity {

    private final String TAG = "DriverActivity";

    private DatabaseReference database;

    private ArrayList<String> rideList;
    private ArrayList<String> rideKeyList;
    private ListView rideListView;
    private ArrayAdapter<String> rideListAdapter;

    private ValueEventListener initializeRideLists = new ValueEventListener() {
        /* This onDataChange() is called only once during onCreate() and the listener is
           then immediately removed. */
        @Override
        public void onDataChange(DataSnapshot dataSnapshot) {
            for (DataSnapshot d : dataSnapshot.getChildren()) {
                Ride ride = d.getValue(Ride.class);
                String currLocation = ride.getCurrentLocation();
                String destination = ride.getDestination();
                String riderName = ride.getRiderName();
                rideList.add("From: "+currLocation+", To: "+destination+", Name: "+riderName);

                String key = d.getKey();
                rideKeyList.add(key);

                rideListAdapter.notifyDataSetChanged();
            }
        }

        @Override
        public void onCancelled(DatabaseError databaseError) {
            Log.w(TAG, databaseError.toException());
        }
    };

    private ChildEventListener childEventListener = new ChildEventListener() {
        @Override
        public void onChildAdded(DataSnapshot dataSnapshot, String s) {
            Ride ride = dataSnapshot.getValue(Ride.class);
            String currLocation = ride.getCurrentLocation();
            String destination = ride.getDestination();
            String riderName = ride.getRiderName();
            rideList.add("From: "+currLocation+", To: "+destination+", Name: "+riderName);

            String key = dataSnapshot.getKey();
            rideKeyList.add(key);

            rideListAdapter.notifyDataSetChanged();
        }

        @Override
        public void onChildChanged(DataSnapshot dataSnapshot, String s) {

        }

        @Override
        public void onChildRemoved(DataSnapshot dataSnapshot) {

        }

        @Override
        public void onChildMoved(DataSnapshot dataSnapshot, String s) {

        }

        @Override
        public void onCancelled(DatabaseError databaseError) {

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

        database.child("rides").addListenerForSingleValueEvent(initializeRideLists);
        database.child("rides").addChildEventListener(childEventListener);
    }

    //function to listen for changes in the database
//    public void firebaseListener(DatabaseReference rideDatabase, DatabaseReference userDatabase)
//    {
//        //this is where we listen for data changes when new rides get posted
//        rideDatabase.addChildEventListener(new ChildEventListener() {
//            @Override
//            public void onChildAdded(DataSnapshot dataSnapshot, String s) {
//                rideInfo = dataSnapshot.getValue(Ride.class);
//                userInfo = dataSnapshot.getValue(User.class);
//
//                // get destination and rider's name to display
//                String rideDestInfo = rideInfo.getDestination();
//                String rideRiderInfo = rideInfo.getRiderName();
//                String rideCurrLoc = rideInfo.getCurrentLocation();
//                rideID = dataSnapshot.getKey();
//
//                if (!rideInfo.isRideInProgress() && rideInfo.getDriverID().equals("")) {
//                    myRides.add("From: "+rideCurrLoc+", To: "+rideDestInfo+", Name: "+rideRiderInfo);
//                }
//
//                rideList.setAdapter(adapter);
//                adapter.notifyDataSetChanged();
//            }
//
//            @Override
//            public void onChildChanged(DataSnapshot dataSnapshot, String s)
//            {
//                //insert new modified value
//                Ride valueUpdated = dataSnapshot.getValue(Ride.class);
//                String modifyDest = valueUpdated.getDestination();
//                String modifyRName = valueUpdated.getRiderName();
//                String modifyCurr = valueUpdated.getCurrentLocation();
//
//                //get the location where change happened
//                if (valueUpdated.isRideInProgress() && !valueUpdated.getDriverID().equals("")) {
//                    myRides.remove("From: "+ modifyCurr+ ", To: "+modifyDest+", Name: "+modifyRName);
//                    rideList.setAdapter(adapter);
//                    adapter.notifyDataSetChanged();
//                }
//            }
//
//            // maybe later
//            @Override
//            public void onChildRemoved(DataSnapshot dataSnapshot) {
//                rideList.setAdapter(adapter);
//                adapter.notifyDataSetChanged();
//            }
//
//            //for now we wont deal with this yet
//            @Override
//            public void onChildMoved(DataSnapshot dataSnapshot, String s) {
//            }
//
//            @Override
//            public void onCancelled(DatabaseError databaseError) {
//                String message = "Server error. Refresh page";
//                Toast.makeText(DriverActivity.this, message, Toast.LENGTH_SHORT).show();
//            }
//        });
//
//        //here we declare a listener
//        rideList.setOnItemClickListener(new AdapterView.OnItemClickListener(){
//            @Override
//            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
//                handleRideSelection(position);
//            }
//        });
//    }
//
    public void handleRideSelection(int position)
    {
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
        Intent intent = new Intent(this, DriverRideInProgress.class);
        intent.putExtra("RIDE_ID", rideID);
        startActivity(intent);
    }
}
