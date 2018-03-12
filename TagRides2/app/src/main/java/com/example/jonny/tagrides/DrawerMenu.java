package com.example.jonny.tagrides;


import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.support.annotation.NonNull;
import android.support.v4.content.ContextCompat;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.auth.api.Auth;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.ResultCallback;
import com.google.android.gms.common.api.Status;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.mindorks.placeholderview.annotations.Click;
import com.mindorks.placeholderview.annotations.Layout;
import com.mindorks.placeholderview.annotations.Resolve;
import com.mindorks.placeholderview.annotations.View;



@Layout(R.layout.drawer_items)
public  class  DrawerMenu extends Login {

    public static final int DRAWER_MENU_ITEM_RIDER = 1;
    public static final int DRAWER_MENU_ITEM_DRIVER = 2;
    public static final int DRAWER_MENU_ITEM_SIGNOUT = 3;

    private int mMenuPosition;
    private Context mContext;
    private DrawerCallBack mCallBack;
    private GoogleApiClient mGoogleApiClient;
    private FirebaseAuth mAuth;

    @View(R.id.itemNameTxt)
    private TextView itemNameTxt;

    @View(R.id.riderView)
    private ImageView itemIcon;


    public DrawerMenu(Context context, int menuPosition) {
        mContext = context;
        mMenuPosition = menuPosition;
    }

    @Resolve
        private void onResolved () {

            switch (mMenuPosition) {
                case DRAWER_MENU_ITEM_RIDER:
                    itemNameTxt.setText("Rider");
                    itemIcon.setImageDrawable(ContextCompat.getDrawable(mContext, R.drawable.ic_event_seat_black_24dp));


                    break;
                case DRAWER_MENU_ITEM_DRIVER:
                    itemNameTxt.setText("Driver");
                    itemIcon.setImageDrawable(ContextCompat.getDrawable(mContext,R.drawable.ic_directions_car_black_24dp));
                    break;
                case DRAWER_MENU_ITEM_SIGNOUT:
                    itemNameTxt.setText("Sign out");
                    itemIcon.setImageDrawable(ContextCompat.getDrawable(mContext, R.drawable.ic_exit_to_app_black_24dp));

            }
        }
      @Override
      public void onStart() {
        super.onStart();
        // Check if user is signed in (non-null) and update UI accordingly.
        FirebaseUser currentUser = mAuth.getCurrentUser();
        //updateUI(currentUser);
      }


        @Click(R.id.mainView)
        private void onMenuItemClick () {
            mAuth = FirebaseAuth.getInstance();
            switch (mMenuPosition) {
                case DRAWER_MENU_ITEM_RIDER:

                    Toast.makeText(mContext, "I will be a Rider", Toast.LENGTH_SHORT).show();
                    if (mCallBack != null) mCallBack.onRiderMenuSelected();
                    mContext.startActivity(new Intent(mContext, RiderActivity.class));
                    break;
                case DRAWER_MENU_ITEM_DRIVER:

                    Toast.makeText(mContext, "I will be a Driver", Toast.LENGTH_SHORT).show();
                    mContext.startActivity(new Intent(mContext, DriverActivity.class));
                    if (mCallBack != null) mCallBack.onDriverMenuSelected();
                    break;

                case DRAWER_MENU_ITEM_SIGNOUT:

                    Toast.makeText(mContext, "Signing Out", Toast.LENGTH_SHORT).show();
                    signOut();


                    if (mCallBack != null) mCallBack.onSignOutMenuSelected();



            }

        }
    public void signOut() {
        Auth.GoogleSignInApi.signOut(mGoogleApiClient).setResultCallback(new ResultCallback<Status>() {

            @Override
            public void onResult(@NonNull Status status) {
                FirebaseAuth.getInstance().signOut();
                mContext.startActivity(new Intent(mContext, Login.class));

            }
        });
    }

    public void setDrawerCallBack(DrawerCallBack callBack) {
        mCallBack = callBack;
    }

    public interface DrawerCallBack{
        void onRiderMenuSelected();
        void onDriverMenuSelected();
        void onSignOutMenuSelected();

    }

}