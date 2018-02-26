package com.example.jonny.tagrides;

import android.content.Context;
import android.widget.Toast;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

/**
 * Created by jonny on 2/20/2018.
 */

public class Utils {

    private static FirebaseDatabase mDataBase;
    private static DatabaseReference mFireBaseDatabase;
    private static FirebaseDatabase mFirebaseInstance;
    private static FirebaseAuth firebaseAuth;
    public static FirebaseDatabase getDatabase()
    {
        if (mDataBase == null)
        {
            mDataBase = FirebaseDatabase.getInstance();
            mDataBase.setPersistenceEnabled(true);
        }
        return mDataBase;
    }
    public static void toastMessage(String message, Context currentActivity)
    {
        Toast.makeText(currentActivity,message,Toast.LENGTH_SHORT).show();
    }
}
