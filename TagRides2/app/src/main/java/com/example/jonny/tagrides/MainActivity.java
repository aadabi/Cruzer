package com.example.jonny.tagrides;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.FrameLayout;


import com.mindorks.placeholderview.PlaceHolderView;

import static com.example.jonny.tagrides.R.*;
import static com.example.jonny.tagrides.R.id.drawerFull;

public class MainActivity extends AppCompatActivity
{

    private PlaceHolderView mDrawerView;
    private DrawerLayout mDrawer;
    private Toolbar mToolbar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(layout.activity_main);

        mDrawer = (DrawerLayout)findViewById(id.drawerLayout);
        mDrawerView = (PlaceHolderView)findViewById(id.drawerView);
        mToolbar = (Toolbar)findViewById(id.toolbar);
        setupDrawer();
    }


    private void setupDrawer(){
        mDrawerView
                .addView(new DrawerHeader())
                .addView(new DrawerMenu(this.getApplicationContext(), DrawerMenu.DRAWER_MENU_ITEM_RIDER))
                .addView(new DrawerMenu(this.getApplicationContext(), DrawerMenu.DRAWER_MENU_ITEM_DRIVER));
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