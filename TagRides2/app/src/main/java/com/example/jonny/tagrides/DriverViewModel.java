package com.example.jonny.tagrides;


import android.arch.lifecycle.LiveData;
import android.arch.lifecycle.ViewModel;
import android.support.annotation.NonNull;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

public class DriverViewModel extends ViewModel {
    private static final DatabaseReference RIDES_REF =
            FirebaseDatabase.getInstance().getReference("/rides");

    private final FirebaseQueryLiveData liveData = new FirebaseQueryLiveData(RIDES_REF);

    @NonNull
    public LiveData<DataSnapshot> getDataSnapshotLiveData() {

        return liveData;
    }

}
