package com.softwinner.TvdVideo;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.provider.MediaStore;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.util.Log;

public class TvdVideoActivity extends Activity {
	private static final String TAG = "TvdVideoActivity";
	
	private MovieViewControl mControl;
	private boolean mBDFolderPlayMode = false;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);

        Log.d(TAG, "onCreate");

        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
		
        setContentView(R.layout.movie_view);
        View rootView = findViewById(R.id.root);
        mBDFolderPlayMode = getIntent().getBooleanExtra(MediaStore.EXTRA_BD_FOLDER_PLAY_MODE, false);
        Log.d(TAG, "onCreate: create MovieViewControl");
        mControl = new MovieViewControl(rootView, this, getIntent()) {
            @Override
            public void onCompletion() {
            	if(mBDFolderPlayMode){
            		finish();
            	}
            	else{
                	super.onCompletion();
                	if( super.toQuit() ){
                    	finish();
                	}
            	}
            }
        };
    }

    @Override
    public void onPause() {
        mControl.onPause();
        super.onPause();
    }

    @Override
    public void onResume() {
        mControl.onResume();
        super.onResume();
    }
    
    @Override
    public void onDestroy() {
        mControl.onDestroy();
    	super.onDestroy();
    }
}
