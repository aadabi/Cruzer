package com.example.jonny.tagrides.Activities;

import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.support.annotation.NonNull;
import android.support.design.widget.NavigationView;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

import com.example.jonny.tagrides.Models.Ride;
import com.example.jonny.tagrides.Models.User;
import com.example.jonny.tagrides.R;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

public class MainActivity extends AppCompatActivity implements NavigationView.OnNavigationItemSelectedListener {
    //variables for login out
    private FirebaseAuth myAuth;
    private FirebaseAuth.AuthStateListener myAuthListener;
    //variables to get the user name from fire base
    private FirebaseAuth firebaseAuth;
    private FirebaseUser firebaseUser;
    private DatabaseReference userReference;
    //variables for the UI
    private DrawerLayout drawerLayout;
    private ActionBarDrawerToggle toggle;
    private TextView userName;
    private View headerView;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        NavigationView myView = findViewById(R.id.nav_view);
        myView.setNavigationItemSelectedListener(this);
        Toolbar toolbar = findViewById(R.id.toolbar_main);
        setSupportActionBar(toolbar);
        headerView = myView.getHeaderView(0);
        userName = headerView.findViewById(R.id.nav_header_textView);



        //method to display the name of the user in the nav header
        getUsername();
        //userName.setText(userReference.toString());
        drawerLayout = findViewById(R.id.drawer_layout);
        toggle = new ActionBarDrawerToggle(this, drawerLayout,
                toolbar, R.string.drawer_open, R.string.drawer_close);



        //makes hamburger icon clickable and add the
        drawerLayout.addDrawerListener(toggle);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        getSupportActionBar().setHomeButtonEnabled(true);

        //method to log out
        authListner();

    }

    //navigation drawer
    @Override
    protected void onPostCreate(Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);
        toggle.syncState();
    }
    @Override
    public void onConfigurationChanged(Configuration newCon){
        super.onConfigurationChanged(newCon);
        toggle.onConfigurationChanged(newCon);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item){
        if(toggle.onOptionsItemSelected(item)){
            return true;
        }
        return super.onOptionsItemSelected(item);
    }
    //setting up the click listner
    @Override
    public boolean onNavigationItemSelected(@NonNull MenuItem item) {
        switch (item.getItemId()) {
            case R.id.nav_driver:
                Toast.makeText(this, "I will be a Driver", Toast.LENGTH_SHORT).show();
                this.startActivity(new Intent(this, DriverActivity.class));
                break;
            case R.id.nav_rider:
                Toast.makeText(this, "I will be a Rider", Toast.LENGTH_SHORT).show();
                this.startActivity(new Intent(this, RiderActivity.class));
                break;

            case R.id.nav_exit:
                Toast.makeText(this, "Signed Out", Toast.LENGTH_SHORT).show();
                myAuth.signOut();
                this.startActivity(new Intent(this, Login.class));

        }
        //closes drawer when item is choosen
        drawerLayout.closeDrawer(GravityCompat.START);
        return true;
    }
    //method to get the user name from firebase and then to set it on to the textview
    public void getUsername(){
        firebaseAuth = FirebaseAuth.getInstance();
        firebaseUser = firebaseAuth.getCurrentUser();
        userReference = FirebaseDatabase.getInstance().getReference("users").child(firebaseUser.getUid());
        userReference.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                userName.setText(dataSnapshot.child("name").getValue().toString());
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });
    }
    //listen to authentication changes once the activity
    //starts in the case of sign out
    @Override
    protected void onStart() {
        super.onStart();

        myAuth.addAuthStateListener(myAuthListener);
    }
    public void authListner(){
        myAuth=FirebaseAuth.getInstance();


        myAuthListener =new FirebaseAuth.AuthStateListener() {
            @Override
            public void onAuthStateChanged(@NonNull FirebaseAuth firebaseAuth) {
                if (firebaseAuth.getCurrentUser()==null){
                    startActivity(new Intent(MainActivity.this,Login.class));

                }
            }
        };
    }


}



