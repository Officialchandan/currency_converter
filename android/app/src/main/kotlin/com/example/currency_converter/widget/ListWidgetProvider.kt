package com.example.currency_converter.widget
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.net.Uri
import android.os.Bundle
import android.util.Log
import android.widget.RemoteViews
import com.example.currency_converter.MainActivity
import com.example.currency_converter.R
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class ListWidgetProvider : HomeWidgetProvider() {

    override fun onReceive(context: Context?, intent: Intent?) {

        Log.e(javaClass.simpleName ,"onReceive--> ${intent?.data}")
        Log.e(javaClass.simpleName ,"onReceive--> ${intent?.action}")
        super.onReceive(context, intent)
    }

    override fun onEnabled(context: Context?) {
        Log.e(javaClass.simpleName,"onEnabled-->"+"enabled")
        super.onEnabled(context)
    }

    override fun onAppWidgetOptionsChanged(
        context: Context?,
        appWidgetManager: AppWidgetManager?,
        appWidgetId: Int,
        newOptions: Bundle?
    ) {
        Log.e(javaClass.simpleName,"onAppWidgetOptionsChanged-->\n${appWidgetId} ${appWidgetManager.toString()}")
        super.onAppWidgetOptionsChanged(context, appWidgetManager, appWidgetId, newOptions)
    }

    override fun onRestored(context: Context?, oldWidgetIds: IntArray?, newWidgetIds: IntArray?) {
        Log.e(javaClass.simpleName,"onRestored--> newWidgetIds - $newWidgetIds ,oldWidgetIds - $oldWidgetIds  ")

        super.onRestored(context, oldWidgetIds, newWidgetIds)
    }

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        Log.e(javaClass.simpleName,"onUpdate--> appWidgetIds - $appWidgetIds ,appWidgetManager - $widgetData  ")
        for (widgetId in appWidgetIds) {


            ListWidgetKt.updateAppWidget(context,appWidgetManager,widgetId,false)


//            val views = RemoteViews(context.packageName, R.layout.multi_convertor_layout).apply {
//                // Open App on Widget Click
//                val pendingIntent = HomeWidgetLaunchIntent.getActivity(
//                    context,
//                    MainActivity::class.java)
//                setOnClickPendingIntent(R.id.container, pendingIntent)
//
//                // Swap Title Text by calling Dart Code in the Background
//                setTextViewText(
//                    R.id.title, widgetData.getString("title", null)
//                    ?: "No Title Set")
//
//                val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(
//                    context,
//                    Uri.parse("homeWidgetExample://multiConvertorTitleClick")
//                )
//                setOnClickPendingIntent(R.id.title, backgroundIntent)
//
//                val message = widgetData.getString("message", null)
//
//                setTextViewText(
//                    R.id.message, message
//                    ?: "No Message Set")
//                // Detect App opened via Click inside Flutter
//                val pendingIntentWithData = HomeWidgetLaunchIntent.getActivity(
//                    context,
//                    MainActivity::class.java,
//                    Uri.parse("homeWidgetExample://message?message=$message"))
//                setOnClickPendingIntent(R.id.message, pendingIntentWithData)
//            }
//
//            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }

    companion object{



    }



}