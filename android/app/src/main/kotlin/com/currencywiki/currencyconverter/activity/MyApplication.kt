package com.currencywiki.currencyconverter.activity

import android.app.Application
import android.util.Log
import com.currencywiki.currencyconverter.ads.AppOpenManager

import com.google.android.gms.ads.MobileAds

class MyApplication : Application() {

    var appOpenAdManager: AppOpenManager?=null


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