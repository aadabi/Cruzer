package com.example.jonny.tagrides;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.LinearLayout;


import com.mindorks.placeholderview.PlaceHolderView;

import static com.example.jonny.tagrides.DrawerMenu.DRAWER_MENU_ITEM_DRIVER;
import static com.example.jonny.tagrides.DrawerMenu.DRAWER_MENU_ITEM_RIDER;
import static com.example.jonny.tagrides.DrawerMenu.DRAWER_MENU_ITEM_SIGNOUT;
import static com.example.jonny.tagrides.R.*;


public class MainActivity extends baseDrawer
{

    private PlaceHolderView mDrawerView;
    private DrawerLayout mDrawer;
    private Toolbar mToolbar;
    public  FrameLayout drawerlayout;
    public LinearLayout layoutMenu;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(layout.activity_main);
        getLayoutInflater().inflate(R.layout.activity_main, frameLayout2);

        /**
         * Setting title and itemChecked
         */
        mDrawerList.setItemChecked(position, true);
        setTitle(listArray[position]);
        mDrawer = (DrawerLayout)findViewById(id.drawerLayout);
        mDrawerView = (PlaceHolderView)findViewById(id.drawerView);
        mToolbar = (Toolbar)findViewById(id.toolbar);
        setupDrawer();
    }


    public void setupDrawer(){
        mDrawerView
                .addView(new com.example.jonny.tagrides.DrawerHeader())
                .addView(new com.example.jonny.tagrides.DrawerMenu(this.getApplicationContext(), DRAWER_MENU_ITEM_RIDER))
                .addView(new com.example.jonny.tagrides.DrawerMenu(this.getApplicationContext(), DRAWER_MENU_ITEM_DRIVER))
                .addView(new com.example.jonny.tagrides.DrawerMenu(this.getApplicationContext(), DRAWER_MENU_ITEM_SIGNOUT));
        //ActionBarDrawerToggle adds listener for menu and the hamburger icon
        ActionBarDrawerToggle drawerToggle = new
                ActionBarDrawerToggle(this, mDrawer, mToolbar, R.string.drawer_open, R.string.drawer_close)
                {//handles opening and closing
                    @Override
                    public void onDrawerOpened(View drawerView) {
                        super.onDrawerOpened(drawerView);
                    }
                    @Override
                    public void onDrawerClosed(View drawerView) {
                        super.onDrawerClosed(drawerView);
                    }
                };
        //
        mDrawer.addDrawerListener(drawerToggle);
        drawerToggle.syncState();
    }

}