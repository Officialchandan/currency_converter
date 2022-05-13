package com.example.currency_converter.ads

import android.app.Activity
import android.app.Application
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.OnLifecycleEvent
import androidx.lifecycle.ProcessLifecycleOwner
import com.example.currency_converter.activity.MyApplication
import com.google.android.gms.ads.AdError
import com.google.android.gms.ads.AdRequest
import com.google.android.gms.ads.FullScreenContentCallback
import com.google.android.gms.ads.LoadAdError
import com.google.android.gms.ads.appopen.AppOpenAd
import java.util.*
import kotlin.jvm.internal.Intrinsics


class AppOpenManager(val mApplication: MyApplication) : LifecycleObserver, Application.ActivityLifecycleCallbacks {
    private var loadTime: Long = 0
    private   val LOG_TAG = "AppOpenManager";
    private val AD_UNIT_ID = "ca-app-pub-3940256099942544/3419835294";
    private  var appOpenAd : AppOpenAd ?= null;
    private var currentActivity: Activity? = null

    private lateinit var loadCallback : AppOpenAd.AppOpenAdLoadCallback
    private var isShowingAd = false
    private  val myApplication: MyApplication = mApplication;

    init {
        Log.e(javaClass.name, "init---")
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            this.myApplication.registerActivityLifecycleCallbacks(this)
        };
        val lifecycleOwner = ProcessLifecycleOwner.get()
        Intrinsics.checkNotNullExpressionValue(lifecycleOwner, "ProcessLifecycleOwner.get()")
        lifecycleOwner.lifecycle.addObserver(this)
    }

    /** LifecycleObserver methods  */
    @OnLifecycleEvent(Lifecycle.Event.ON_START)
    fun onStart() {
//        showAdIfAvailable()
        Log.d(LOG_TAG, "onStart")
    }

    /** Shows the ad if one isn't already showing.  */
    fun showAdIfAvailable() {
        Log.e(javaClass.name, "showAdIfAvailable---")


        // Only show ad if there is not already an app open ad currently showing
        // and an ad is available.
        Log.e(javaClass.name, "showAdIfAvailable---"+isAdAvailable())
        if (!isShowingAd && isAdAvailable()) {
            Log.d(LOG_TAG, "Will show ad.")
            val fullScreenContentCallback: FullScreenContentCallback = object : FullScreenContentCallback() {
                override fun onAdDismissedFullScreenContent() {
                    // Set the reference to null so isAdAvailable() returns false.
                    appOpenAd = null
                    isShowingAd = false
                    fetchAd()
                }

                override fun onAdFailedToShowFullScreenContent(adError: AdError?) {}
                override fun onAdShowedFullScreenContent() {
                    isShowingAd = true
                }
            }
            appOpenAd!!.fullScreenContentCallback = fullScreenContentCallback
            appOpenAd!!.show(currentActivity)
        } else {
            Log.d(LOG_TAG, "Can not show ad.")
            fetchAd()
        }
    }



    /** Utility method that checks if ad exists and can be shown.  */
    fun isAdAvailable(): Boolean {
        Log.e(javaClass.name, "isAdAvailable---")
        return appOpenAd != null
    }

    /** Request an ad  */
    fun fetchAd() {
        Log.e(javaClass.name, "fetchAd---")
        // Have unused ad, no need to fetch another.
        Log.e(javaClass.name, "fetchAd---"+isAdAvailable())
        if (isAdAvailable()) {
            return
        }
        loadCallback = object : AppOpenAd.AppOpenAdLoadCallback() {


            override fun onAdLoaded(ad: AppOpenAd) {
                super.onAdLoaded(ad)
                Log.e(javaClass.name, "onAppOpenAdLoaded---"+ad.adUnitId)
                appOpenAd = ad
                loadTime = Date().getTime()
            }

            override fun onAdFailedToLoad(loadAdError: LoadAdError) {
                super.onAdFailedToLoad(loadAdError)
                Log.e(javaClass.name, "onAppOpenAdFailedToLoad---"+loadAdError.cause.code)
            }


        }
        val request: AdRequest = getAdRequest()
        AppOpenAd.load(
            myApplication, AD_UNIT_ID, request, AppOpenAd.APP_OPEN_AD_ORIENTATION_PORTRAIT, loadCallback
        )
    }

    private fun getAdRequest(): AdRequest {
        Log.e(javaClass.name, "getAdRequest---")
        return AdRequest.Builder().build()
    }

    /** Utility method to check if ad was loaded more than n hours ago.  */
    private fun wasLoadTimeLessThanNHoursAgo(numHours: Long): Boolean {
        Log.e(javaClass.name, "wasLoadTimeLessThanNHoursAgo---")
        val dateDifference: Long = Date().getTime() - loadTime
        val numMilliSecondsPerHour: Long = 3600000
        return dateDifference < numMilliSecondsPerHour * numHours
    }




    override fun onActivityCreated(activity: Activity, p1: Bundle?) {

    }

    override fun onActivityStarted(activity: Activity) {
        currentActivity = activity;
    }

    override fun onActivityResumed(activity: Activity) {
        currentActivity = activity;
    }

    override fun onActivityPaused(activity: Activity) {

    }

    override fun onActivityStopped(activity: Activity) {

    }

    override fun onActivitySaveInstanceState(activity: Activity, p1: Bundle) {

    }

    override fun onActivityDestroyed(activity: Activity) {
        currentActivity = null;
    }
}