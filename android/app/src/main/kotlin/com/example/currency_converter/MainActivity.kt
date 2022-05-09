package com.example.currency_converter

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.util.Log
import androidx.annotation.NonNull
import com.example.currency_converter.widget.ListWidgetProvider
import com.example.currency_converter.widget.SingleConvertorProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlin.jvm.internal.Intrinsics

class MainActivity : FlutterActivity() {


    private val CHANNEL = "com.example.currency_converter/notifyThemeChange"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler(
            fun(call: MethodCall, result: MethodChannel.Result) {
                if (call.method == "notifyThemeChange") {
                    Log.e(javaClass.simpleName, "MethodChannel-->${call.method}")

                    val appWidgetManager = AppWidgetManager.getInstance(context.applicationContext)
                    val ids = appWidgetManager.getAppWidgetIds(
                        ComponentName(
                            application,
                            SingleConvertorProvider::class.java
                        )
                    )
                    Log.e(javaClass.simpleName, "ids-->${ids.size}")
                    Log.e(javaClass.simpleName, "ids-->$ids")
                    val instance = AppWidgetManager.getInstance(this)
                    Intrinsics.checkNotNullExpressionValue(instance, "AppWidgetManager.getInstance(this@MainActivity)")
                    Intrinsics.checkNotNullExpressionValue(ids, "ids")
                    SingleConvertorProvider().onUpdate(context, appWidgetManager, ids)


                    val listWidgetIds = AppWidgetManager.getInstance(application).getAppWidgetIds(
                        ComponentName(
                            application,
                            ListWidgetProvider::class.java
                        )
                    )
                    Log.e(javaClass.simpleName, "listWidgetIds-->${listWidgetIds.size}")
                    Log.e(javaClass.simpleName, "listWidgetIds-->$listWidgetIds")


                    val myListWidget = ListWidgetProvider()
                    val instance2 = AppWidgetManager.getInstance(this)
                    Intrinsics.checkNotNullExpressionValue(instance2, "AppWidgetManager.getInstance(this@MainActivity)")
                    Intrinsics.checkNotNullExpressionValue(listWidgetIds, "listWidgetIds")
                    myListWidget.onUpdate(this, instance2, listWidgetIds)
//                    ListWidgetProvider.notifyUpdate(instance2, listWidgetIds)
//                    val instance3 = AppWidgetManager.getInstance(this)
//                    Intrinsics.checkNotNullExpressionValue(instance3, "AppWidgetManager.getInstance(this@MainActivity)")
//                    myListWidget.onUpdate(this, instance3, listWidgetIds)


                } else {
                    result.notImplemented()
                }
            })
    }
}
