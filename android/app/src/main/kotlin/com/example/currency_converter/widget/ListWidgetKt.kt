package com.example.currency_converter.widget

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.net.Uri
import android.os.Build
import android.util.Log
import android.view.View
import android.widget.RemoteViews
import androidx.core.content.ContextCompat
import com.example.currency_converter.R
import com.example.currency_converter.utils.Constants
import com.example.currency_converter.utils.Utility
import com.example.currency_converter.widget_service.ListWidgetService
import kotlin.jvm.internal.Intrinsics

class ListWidgetKt {

    companion object {
        private val TAG = "ListWidgetKt"

        const val ACTION_LIST_UPDATE_SETTINGS = "intent.action.update_list_widget_settings"
        const val ACTION_WIDGET_CONFIGURE = "ConfigureWidget"
        const val MyOnClick = "myOnClickTag"


         fun getPendingSelfIntentForConvertList(
            context: Context?,
            action: String?,
            widgetId: Int
        ): PendingIntent {
            val intent = Intent(context, ListWidgetProvider::class.java)
            intent.action = action
            intent.putExtra("appWidgetId", widgetId)

             return  if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.S){
                 PendingIntent.getBroadcast(
                     context,
                     widgetId,
                     intent,
                     PendingIntent.FLAG_IMMUTABLE
                 )
             }else{
                 PendingIntent.getBroadcast(
                     context,
                     widgetId,
                     intent,
                     PendingIntent.FLAG_UPDATE_CURRENT
                 )
             }

        }

        fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int,
            isProcess: Boolean
        ) {

            Log.e(
                TAG,
                "updateAppWidget--> appWidgetIds - $appWidgetId ,appWidgetManager - $appWidgetManager  "
            )
            val symbolTextSize: Float
            val updateDateTextSize: Float
            val i: Int
            Intrinsics.checkNotNullParameter(context, "context")
            Intrinsics.checkNotNullParameter(appWidgetManager, "appWidgetManager")
            val views =
                RemoteViews(context.packageName, R.layout.multi_convertor_layout)
            val colorCode = Utility.getWidgetColor(context)

            Log.e(TAG, "colorCode-->$colorCode")
            val colorFrom: Int = Color.parseColor("#$colorCode")
            val trans = Utility.getWidgetTransparency(context)
            Log.e(TAG, "trans--> $trans")
            val transparency: Float = 1f - (trans.toFloat() / 100)

            val listWidgetProviderWidth =
                appWidgetManager.getAppWidgetOptions(appWidgetId).getInt("appWidgetMinWidth", 150)
            val listWidgetProviderHeight =
                appWidgetManager.getAppWidgetOptions(appWidgetId).getInt("appWidgetMaxHeight", 120)

            val gradientDrawable = Utility.getWidgetGradientDrawable(
                Utility.getColorWithAlpha(colorFrom, transparency), 0, 0, context.resources.getDimension(
                    R
                        .dimen._16sdp
                )
            );
            val bitmap =
                SingleConvertorProvider.drawableToBitmap(
                    gradientDrawable,
                    listWidgetProviderWidth * 3,
                    listWidgetProviderHeight * 3
                )
            views.setImageViewBitmap(R.id.imgContainer, bitmap)

            val jsonString: String = Utility.getListWidgetData(
                context,
                appWidgetId
            )

            val baseCurrency: String = Utility.loadBaseCurrency(
                context,
                appWidgetId
            )

            val amount: String = Utility.loadAmount(
                context,
                appWidgetId
            )

            val visualSize: Int = Utility.loadVisual(context, appWidgetId)



            Log.e(TAG, "json--> $jsonString")

//            getRate(context, views, json, baseCurrency, amount.toDouble(), appWidgetId, visualSize, appWidgetManager)
            setRemoteAdapter(context, views, jsonString, baseCurrency, amount.toDouble(), appWidgetId, visualSize, appWidgetManager)


//        val instance: AppCurrency = AppCurrency.Companion.getInstance()
//        Intrinsics.checkNotNull(instance)
//        val settingManager: SettingManager = instance.getAppData().getSettingManager()
//

            symbolTextSize = when (visualSize) {
                1 -> context.resources.getDimension(R.dimen._16sdp)
                2 -> context.resources.getDimension(R.dimen._17sdp)
                else -> context.resources.getDimension(R.dimen._18sdp)
            }



            updateDateTextSize = when (visualSize) {
                1 -> context.resources.getDimension(R.dimen._10sdp)
                2 -> context.resources.getDimension(R.dimen._11sdp)
                else -> context.resources.getDimension(R.dimen._12sdp)
            }
            views.setTextViewTextSize(R.id.txtSymbolLight, 0, symbolTextSize)
            views.setTextViewTextSize(R.id.txtSymbolDark, 0, symbolTextSize)
            views.setTextViewTextSize(R.id.txtProvider, 0, updateDateTextSize)
            views.setTextViewText(R.id.txtProvider, "Currency.wiki")
            views.setTextViewTextSize(R.id.tvPipe, 0, updateDateTextSize)


            val amountText: String = amount
//            ExtensionsKt.decimalStringEliminateZeros(BigDecimal(amount))

            views.setTextViewText(R.id.txtSymbolDark, "$amountText $baseCurrency = ")
            views.setTextViewText(R.id.txtSymbolLight, "$amountText $baseCurrency = ")
            views.setViewVisibility(R.id.txtSymbolDark, View.GONE)
            views.setViewVisibility(R.id.txtSymbolLight, View.VISIBLE)

            if (Utility.isDarkTheme(context)) {
                views.setTextColor(
                    R.id.txtProvider, ContextCompat.getColor(
                        context,
                        R.color.textDark
                    )
                )

                views.setTextColor(
                    R.id.tvPipe, ContextCompat.getColor(
                        context,
                        R.color.textDark
                    )
                )



                views.setViewVisibility(R.id.btnRefresh, View.GONE)
                views.setViewVisibility(R.id.btnSettings, View.GONE)
                views.setViewVisibility(R.id.txtSymbolLight, View.GONE)

                views.setViewVisibility(R.id.btnRefreshDark, View.VISIBLE)
                views.setViewVisibility(R.id.btnSettingsDark, View.VISIBLE)
                views.setViewVisibility(R.id.txtSymbolDark, View.VISIBLE)
                i = 8
            } else {

                views.setTextColor(
                    R.id.txtProvider, ContextCompat.getColor(
                        context,
                        R.color.textLight
                    )
                )
                views.setTextColor(
                    R.id.tvPipe, ContextCompat.getColor(
                        context,
                        R.color.textLight
                    )
                )
                views.setViewVisibility(R.id.txtSymbolLight, View.VISIBLE)
                views.setViewVisibility(R.id.btnRefresh, View.VISIBLE)
                i = 8
                views.setViewVisibility(R.id.btnRefreshDark, View.GONE)
                views.setViewVisibility(R.id.btnSettings, View.VISIBLE)
                views.setViewVisibility(R.id.btnSettingsDark, View.GONE)
            }


            if (isProcess) {
                views.setViewVisibility(R.id.btnRefresh, i)
                views.setViewVisibility(R.id.btnRefreshDark, i)
                if (Utility.isDarkTheme(context)) {
                    views.setViewVisibility(R.id.progressDark, View.VISIBLE)
                } else {
                    views.setViewVisibility(R.id.progressWhite, View.VISIBLE)
                }
            } else {
                views.setViewVisibility(R.id.progressWhite, View.GONE)
                views.setViewVisibility(R.id.progressDark, View.GONE)
                if (Utility.isDarkTheme(context)) {
                    views.setViewVisibility(R.id.btnRefreshDark, View.VISIBLE)
                } else {
                    views.setViewVisibility(R.id.btnRefresh, View.VISIBLE)
                }
                appWidgetManager.notifyAppWidgetViewDataChanged(
                    appWidgetId,
                    R.id.listCurrency
                )
            }


            val str2: String = MyOnClick

            views.setOnClickPendingIntent(
                R.id.btnRefresh, getPendingSelfIntentForConvertList(
                    context,
                    str2,
                    appWidgetId
                )
            )
            views.setOnClickPendingIntent(
                R.id.btnRefreshDark, getPendingSelfIntentForConvertList(
                    context,
                    str2,
                    appWidgetId
                )
            )
            views.setOnClickPendingIntent(
                R.id.btnSettings, getPendingSelfIntentForConvertList(
                    context,
                    ACTION_LIST_UPDATE_SETTINGS,
                    appWidgetId
                )
            )
            views.setOnClickPendingIntent(
                R.id.btnSettingsDark, getPendingSelfIntentForConvertList(
                    context,
                    ACTION_LIST_UPDATE_SETTINGS,
                    appWidgetId
                )
            )

//            views.setOnClickPendingIntent(
//                R.id.layout_list_widget, getPendingSelfIntentForConvertList(
//                    context,
//                    ACTION_LIST_UPDATE_SETTINGS,
//                    appWidgetId
//                )
//            )



            val toastIntent = Intent(context, ListWidgetProvider::class.java)
            toastIntent.action = Constants.TOAST_ACTION
            toastIntent.putExtra("appWidgetId", appWidgetId)
//             toastIntent.putExtra("currencyCode", baseCurrency)
            toastIntent.data = Uri.parse(toastIntent.toUri(Intent.URI_INTENT_SCHEME))


            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S){
                views.setPendingIntentTemplate(
                    R.id.listCurrency,
                    PendingIntent.getBroadcast(
                        context,
                        0,
                        toastIntent,
                        PendingIntent.FLAG_IMMUTABLE
                    )
                )
            }else{
                views.setPendingIntentTemplate(
                    R.id.listCurrency,
                    PendingIntent.getBroadcast(
                        context,
                        0,
                        toastIntent,
                        PendingIntent.FLAG_UPDATE_CURRENT
                    )
                )
            }




//            val pendingIntent = context.let {
//                HomeWidgetLaunchIntent.getActivity(
//                    it,
//                    MainActivity::class.java
//                )
//            }
//           views.setOnClickPendingIntent(R.id.listCurrency, pendingIntent)

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }

        private fun setRemoteAdapter(
            context: Context?,
            views: RemoteViews,
            json: String,
            baseCurrency: String?,
            amount: Double,
            appWidgetId: Int,
            visualSize: Int,
            appWidgetManager: AppWidgetManager,
        ) {

            Intrinsics.checkNotNullParameter(context, "context")
            Intrinsics.checkNotNullParameter(views, "views")
            Intrinsics.checkNotNullParameter(baseCurrency, "baseCurrency")
            val intent = Intent(context, ListWidgetService::class.java)
            intent.putExtra("jsonItems", json)
            intent.putExtra("baseCurrency", baseCurrency)
            intent.putExtra("amount", amount)
            intent.putExtra("visualSize", visualSize)
            intent.putExtra("appWidgetId", appWidgetId)
            views.setRemoteAdapter(R.id.listCurrency, intent)

        }


    }


}