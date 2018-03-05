package com.example.jonny.tagrides;

import android.widget.ImageView;
import android.widget.TextView;

import com.mindorks.placeholderview.annotations.Layout;
import com.mindorks.placeholderview.annotations.NonReusable;
import com.mindorks.placeholderview.annotations.Resolve;
import com.mindorks.placeholderview.annotations.View;

@NonReusable
@Layout(R.layout.drawer_header)
public class DrawerHeader {
    private User user;

    @View(R.id.profileImageView)
    private ImageView profileImage;

    @View(R.id.Name)
    private TextView nameTxt;

    @View(R.id.Email)
    private TextView emailTxt;

    @Resolve
    private void onResolved() {
        nameTxt.setText(user.getName());
        emailTxt.setText(user.getName());
    }
}