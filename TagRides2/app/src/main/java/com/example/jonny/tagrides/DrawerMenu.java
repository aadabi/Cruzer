package com.example.jonny.tagrides;


import android.content.Context;
import android.content.Intent;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.mindorks.placeholderview.annotations.Click;
import com.mindorks.placeholderview.annotations.Layout;
import com.mindorks.placeholderview.annotations.Resolve;
import com.mindorks.placeholderview.annotations.View;

@Layout(R.layout.drawer_items)
public  class  DrawerMenu  {

    public static final int DRAWER_MENU_ITEM_RIDER = 1;
    public static final int DRAWER_MENU_ITEM_DRIVER = 2;

    private int mMenuPosition;
    private Context mContext;
    private DrawerCallBack mCallBack;

    @View(R.id.itemNameTxt)
    private TextView itemNameTxt;

    @View(R.id.riderView)
    private ImageView itemIcon;


    public DrawerMenu(Context context, int menuPosition) {
        mContext = context;
        mMenuPosition = menuPosition;
    }

    @Resolve
    private void onResolved() {
        DrawerMenu context = DrawerMenu.this;
        switch (mMenuPosition){
            case DRAWER_MENU_ITEM_RIDER:
                itemNameTxt.setText("Rider");
                itemIcon.setImageDrawable(mContext.getResources().getDrawable(R.drawable.ic_event_seat_black_24dp, null));


                break;
            case DRAWER_MENU_ITEM_DRIVER:
                itemNameTxt.setText("Driver");
                itemIcon.setImageDrawable(mContext.getResources().getDrawable(R.drawable.ic_directions_car_black_24dp, null));
                break;

        }
    }

    @Click(R.id.mainView)
    private void onMenuItemClick(){
        switch (mMenuPosition){
            case DRAWER_MENU_ITEM_RIDER:

                Toast.makeText(mContext, "I will be a Rider", Toast.LENGTH_SHORT).show();
                if(mCallBack != null)mCallBack.onRiderMenuSelected();
                mContext.startActivity(new Intent(mContext, RiderActivity.class));
                break;
            case DRAWER_MENU_ITEM_DRIVER:

                Toast.makeText(mContext, "I will be a Driver", Toast.LENGTH_SHORT).show();
                mContext.startActivity(new Intent(mContext, DriverActivity.class));
                if(mCallBack != null)mCallBack.onDriverMenuSelected();
                break;

        }
    }

    public void setDrawerCallBack(DrawerCallBack callBack) {
        mCallBack = callBack;
    }

    public interface DrawerCallBack{
        void onRiderMenuSelected();
        void onDriverMenuSelected();

    }
}