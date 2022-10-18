package com.currencywiki.currencyconverter.widget

import android.annotation.SuppressLint
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.widget.Toast

import com.currencywiki.currencyconverter.R
import com.currencywiki.currencyconverter.activity.ListWidgetConfigActivity
import com.currencywiki.currencyconverter.api.ApiClient
import com.currencywiki.currencyconverter.utils.Constants
import com.currencywiki.currencyconverter.utils.Utility
import com.currencywiki.currencyconverter.widget.ListWidgetKt.Companion.ACTION_LIST_UPDATE_SETTINGS
import com.currencywiki.currencyconverter.widget.ListWidgetKt.Companion.MyOnClick
import com.google.gson.JsonObject
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
import io.reactivex.schedulers.Schedulers
import org.json.JSONArray
import org.json.JSONObject
import retrofit2.Response
import kotlin.jvm.internal.Intrinsics

class ListWidgetProvider : AppWidgetProvider() {

    override fun onReceive(context: Context?, intent: Intent?) {

        Log.e(javaClass.simpleName, "onReceive--> ${intent?.data}")
        Log.e(javaClass.simpleName, "onReceive--> ${intent?.action}")
        if (intent?.action.toString() == MyOnClick) {
            val appWidgetManager = AppWidgetManager.getInstance(context)
            val extras = intent!!.extras

            val widgetId = extras!!.getInt("appWidgetId", 0)
            ListWidgetKt.updateAppWidget(context!!, appWidgetManager, widgetId, true)
            val baseCurrency = Utility.loadBaseCurrency(context, widgetId)
            val amount = Utility.loadAmount(context, widgetId)

            val jsonString = Utility.loadItemsPref(context, widgetId)
            if (Utility.isOnline(context)) {
                if (jsonString.isNotEmpty()) {
                    getRate(context, JSONArray(jsonString), baseCurrency, amount.toDouble(), widgetId, appWidgetManager)
                }
            } else {
                Toast.makeText(context, "Please connect to the internet", Toast.LENGTH_SHORT).show()
                ListWidgetKt.updateAppWidget(context, appWidgetManager, widgetId, false)
            }
        } else if (Intrinsics.areEqual(intent?.action.toString(), ACTION_LIST_UPDATE_SETTINGS)) {
            val widgetId2 = intent!!.getIntExtra("appWidgetId", 0)
            val intentOpenConfigurationActivity = Intent(context, ListWidgetConfigActivity::class.java)
            intentOpenConfigurationActivity.putExtra("appWidgetId", widgetId2)
            intentOpenConfigurationActivity.addFlags( Intent.FLAG_ACTIVITY_CLEAR_TOP)
            intentOpenConfigurationActivity.addFlags( Intent.FLAG_ACTIVITY_NEW_TASK)
            intentOpenConfigurationActivity.addFlags( Intent.FLAG_ACTIVITY_CLEAR_TASK)
            context?.startActivity(intentOpenConfigurationActivity)
        } else if (Intrinsics.areEqual(intent?.action.toString(), Constants.TOAST_ACTION)) {

            val widgetId2 = intent!!.getIntExtra("appWidgetId", 0)
            val widgetId3 = intent!!.getIntExtra("appWidgetId1", 0)
            var currencyCode = intent.getStringExtra("currencyCode")

            val baseCurrency = Utility.loadBaseCurrency(context!!, widgetId2)
            val amount = Utility.loadAmount(context, widgetId2)

            Log.e(javaClass.simpleName, "widgetId2--> $widgetId2")
            Log.e(javaClass.simpleName, "widgetId3--> $widgetId3")
            Log.e(javaClass.simpleName, "currencyCode--> $currencyCode")
            Log.e(javaClass.simpleName, "baseCurrency--> $baseCurrency")
            Log.e(javaClass.simpleName, "amount--> $amount")

            Utility.setCurrencyCodeFrom(context,baseCurrency)

            //save status via open app widget
            Utility.setOpenStatusCode(context,"1")

            if(currencyCode==null){
                Utility.setCurrencyCodeTo(context, baseCurrency)
            }else{
                Utility.setCurrencyCodeTo(context, currencyCode)
            }
            Utility.setCurrencyInputValue(context, amount)

            val mainActivity = Intent(context, com.currencywiki.currencyconverter.MainActivity::class.java)

            mainActivity.putExtra("appWidgetId", widgetId2)
            mainActivity.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
            mainActivity.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK)
            mainActivity.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            context.startActivity(mainActivity)
        }
        super.onReceive(context, intent)
    }

    override fun onEnabled(context: Context?) {
        Log.e(javaClass.simpleName, "onEnabled-->" + "enabled")
        super.onEnabled(context)
    }

    override fun onAppWidgetOptionsChanged(
        context: Context?,
        appWidgetManager: AppWidgetManager?,
        appWidgetId: Int,
        newOptions: Bundle?
    ) {
        Log.e(javaClass.simpleName, "onAppWidgetOptionsChanged-->\n${appWidgetId} ${appWidgetManager.toString()}")
        ListWidgetKt.updateAppWidget(context!!, appWidgetManager!!, appWidgetId, false)
        super.onAppWidgetOptionsChanged(context, appWidgetManager, appWidgetId, newOptions)
    }

    override fun onRestored(context: Context?, oldWidgetIds: IntArray?, newWidgetIds: IntArray?) {
        Log.e(javaClass.simpleName, "onRestored--> newWidgetIds - $newWidgetIds ,oldWidgetIds - $oldWidgetIds  ")
        super.onRestored(context, oldWidgetIds, newWidgetIds)
    }

     override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        Log.e(javaClass.simpleName, "onUpdate--> appWidgetIds - $appWidgetIds ,appWidgetManager - ")
        for (widgetId in appWidgetIds) {
            ListWidgetKt.updateAppWidget(context, appWidgetManager, widgetId, false)
        }
    }

    companion object {
        fun notifyUpdate(appWidgetManager: AppWidgetManager, appWidgetIds: IntArray?) {
            Intrinsics.checkNotNullParameter(appWidgetManager, "appWidgetManager")
            Intrinsics.checkNotNullParameter(appWidgetIds, "appWidgetIds")
            appWidgetManager.notifyAppWidgetViewDataChanged(appWidgetIds, R.id.listCurrency)
        }

        @SuppressLint("CheckResult")
        fun getRate(
            context: Context?,
            jsonItems: JSONArray,
            baseCurrency: String?,
            amount: Double,
            appWidgetId: Int,
            appWidgetManager: AppWidgetManager
        ) {

            var disposable: Disposable? = null

            disposable = ApiClient.instance.getConvertRate()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe({ response: Response<JsonObject> ->

                    val responseCode = response.code()
                    Log.e(javaClass.simpleName, responseCode.toString())
                    when (responseCode) {
                        200 -> {
                            val responseData: JsonObject? = response.body()
                            Log.e(
                                javaClass.simpleName,
                                "responseData-->" + response.body().toString()
                            )

                            if (responseData != null) {
                                val quote = responseData.getAsJsonObject("quotes")
                                val yesterday = responseData.getAsJsonObject("quotes_yesterday")
                                Log.e(
                                    javaClass.simpleName,
                                    "quote-->$quote"
                                )
                                Log.e(
                                    javaClass.simpleName,
                                    "yesterday-->$yesterday"
                                )

                                val todayRate1 = quote.get(baseCurrency!!.uppercase()).toString()
                                val yesterdayRate1 =
                                    yesterday.get(baseCurrency.uppercase()).toString()

                                val codeList =
                                    context!!.resources.getStringArray(R.array.currency_code)
                                val nameList =
                                    context.resources.getStringArray(R.array.currency_name)
                                val flagList =
                                    context.resources.obtainTypedArray(R.array.country_flag)


                                val jsonArray = JSONArray()


                                for (index in 0 until jsonItems.length()) {

                                    val to = jsonItems.get(index).toString()
                                    val todayRate2 = quote.get(to.uppercase()).toString()
                                    val todayRate =
                                        ((todayRate1.toDouble() * 100) / (todayRate2.toDouble() * 100)) * amount

                                    val yesterdayRate2 = yesterday.get(to.uppercase()).toString()
                                    val yesterdayRate =
                                        ((yesterdayRate1.toDouble() * 100) / (yesterdayRate2.toDouble() * 100)) * amount


                                    var diff = todayRate - yesterdayRate

                                    val i = codeList.indexOf(to)

                                    var jsonObj = JSONObject()
                                    jsonObj.put("code", to);
                                    jsonObj.put("name", nameList[i]!!)
                                    jsonObj.put("todayRate", todayRate.toString())
                                    jsonObj.put("diff", diff.toString())
                                    jsonObj.put("flagIndex", i)

                                    jsonArray.put(jsonObj)

                                }


                                Utility.saveListWidgetData(context, jsonArray.toString(), appWidgetId)

                                ListWidgetKt.updateAppWidget(context, appWidgetManager, appWidgetId, false)


                            }
                        }

                    }
                }, { error ->
                    Log.e(javaClass.simpleName, "error-->$error")

                })


        }


    }


}