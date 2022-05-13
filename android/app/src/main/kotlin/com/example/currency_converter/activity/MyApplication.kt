package com.example.currency_converter.activity

import android.app.Activity
import android.app.Application
import android.os.Bundle
import android.util.Log
import com.example.currency_converter.ads.AppOpenManager
import com.google.android.gms.ads.MobileAds

class MyApplication : Application() {

    var appOpenAdManager: AppOpenManager?=null
    private var currentActivity: Activity? = null

    override fun onCreate() {
        super.onCreate()
        Log.e(javaClass.name, "onCreate--- " )
        MobileAds.initialize(
            this
        ) {

            Log.e(javaClass.name, "adapterStatusMap " + it.adapterStatusMap.toString())

            appOpenAdManager = AppOpenManager(this);
        }

    }

}