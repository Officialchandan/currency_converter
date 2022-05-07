package com.example.currency_converter.widget

import android.annotation.SuppressLint
import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.net.Uri
import android.util.Log
import android.view.View
import android.widget.RemoteViews
import androidx.core.content.ContextCompat
import com.example.currency_converter.ListWidgetConfigActivity
import com.example.currency_converter.R
import com.example.currency_converter.api.ApiClient
import com.example.currency_converter.utils.Constants
import com.example.currency_converter.utils.Utility
import com.example.currency_converter.widget_service.ListWidgetService
import com.example.model.Currency
import com.google.gson.JsonObject
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
import io.reactivex.schedulers.Schedulers
import org.json.JSONArray
import retrofit2.Response
import kotlin.jvm.internal.Intrinsics

class ListWidgetKt {
    companion object {

        const val ACTION_LIST_UPDATE_SETTINGS = "intent.action.update_list_widget_settings"
        const val ACTION_WIDGET_CONFIGURE = "ConfigureWidget"

        /* access modifiers changed from: private */
        val MyOnClick = "myOnClickTag"
        private val buttonClick = false


        private fun getSettingPendingIntent(context: Context, widgetId: Int): PendingIntent {

            val configIntent = Intent(context, ListWidgetConfigActivity::class.java)
            configIntent.action = ACTION_WIDGET_CONFIGURE
            configIntent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)
            return PendingIntent.getActivity(
                context,
                widgetId,
                configIntent,
                PendingIntent.FLAG_UPDATE_CURRENT
            )
        }

        private fun getPendingSelfIntentForConvertList(
            context: Context?,
            action: String?,
            widgetId: Int
        ): PendingIntent {
            val intent = Intent(context, ListWidgetProvider::class.java)
            intent.action = action
            intent.putExtra("appWidgetId", widgetId)
            return PendingIntent.getBroadcast(
                context,
                widgetId,
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT
            )
        }

        fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int,
            isProcess: Boolean
        ) {

            Log.e(
                javaClass.simpleName,
                "updateAppWidget--> appWidgetIds - $appWidgetId ,appWidgetManager - $appWidgetManager  "
            )
            val symbolTextSize: Float
            val updateDateTextSize: Float
            val i: Int
            Intrinsics.checkNotNullParameter(context, "context")
            Intrinsics.checkNotNullParameter(appWidgetManager, "appWidgetManager")
            val views =
                RemoteViews(context.packageName, R.layout.multi_convertor_layout)

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


            Log.e(javaClass.simpleName, "json--> $jsonString")

//            getRate(context, views, json, baseCurrency, amount.toDouble(), appWidgetId, visualSize, appWidgetManager)
            setRemoteAdapter(context, views, jsonString, baseCurrency, amount.toDouble(), appWidgetId, visualSize, appWidgetManager)


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
                R.id.btnSettings, getSettingPendingIntent(
                    context,
                    appWidgetId
                )
            )
            views.setOnClickPendingIntent(
                R.id.btnSettingsDark, getSettingPendingIntent(
                    context,
                    appWidgetId
                )
            )

//        val instance: AppCurrency = AppCurrency.Companion.getInstance()
//        Intrinsics.checkNotNull(instance)
//        val settingManager: SettingManager = instance.getAppData().getSettingManager()
//

            symbolTextSize = when (visualSize) {
                1 -> context.resources.getDimension(R.dimen._13sdp)
                2 -> context.resources.getDimension(R.dimen._14sdp)
                else -> context.resources.getDimension(R.dimen._15sdp)
            }
            updateDateTextSize = when (visualSize) {
                1 -> context.resources.getDimension(R.dimen._9sdp)
                2 -> context.resources.getDimension(R.dimen._10sdp)
                else -> context.resources.getDimension(R.dimen._11sdp)
            }
            views.setTextViewTextSize(R.id.txtSymbolLight, 0, symbolTextSize)
            views.setTextViewTextSize(R.id.txtSymbolDark, 0, symbolTextSize)
            views.setTextViewTextSize(R.id.txtProvider, 0, updateDateTextSize)
            views.setTextViewText(R.id.txtProvider, "Currency.wiki")
            views.setTextViewTextSize(R.id.tvPipe, 0, updateDateTextSize)

            var listWidgetProviderWidth =
                appWidgetManager.getAppWidgetOptions(appWidgetId).getInt("appWidgetMinWidth", 0)
            var listWidgetProviderHeight =
                appWidgetManager.getAppWidgetOptions(appWidgetId).getInt("appWidgetMaxHeight", 0)

//        if (ListWidgetProviderWidth <= 0 || ListWidgetProviderHeight <= 0) {
//            val instance2: AppCurrency = AppCurrency.Companion.getInstance()
//            Intrinsics.checkNotNull(instance2)
//            val providerInfo =
//                AppWidgetManager.getInstance(instance2.getApplicationContext())
//                    .getAppWidgetInfo(appWidgetId)
//            ListWidgetProviderWidth = providerInfo.minWidth
//            ListWidgetProviderHeight = providerInfo.minHeight
//        }
//
//        if (ListWidgetProviderWidth <= 0 || ListWidgetProviderHeight <= 0) {
//            ListWidgetProviderWidth = SVG.Style.FONT_WEIGHT_NORMAL
//            ListWidgetProviderHeight = 300
//        }

            val widgetInfo = appWidgetManager.getAppWidgetInfo(appWidgetId)
            val colorCode = Utility.getWidgetColor( context)
            val colorFrom: Int = Color.parseColor("#$colorCode")
            val trans = Utility.getListWidgetTransparency(context, appWidgetId)
            Log.e(javaClass.simpleName, "trans--> $trans")
            var transparancy: Float = 1f - (trans.toFloat() / 100)


            val gradientDrawable = SingleConvertorProvider.getWidgetGradientDrawable(Utility.getColorWithAlpha(colorFrom, transparancy), 0, 0, 20f)
            val bitmap =
                SingleConvertorProvider.drawableToBitmap(
                    gradientDrawable,
                    listWidgetProviderWidth*3,
                    listWidgetProviderHeight*3
                )
            views.setImageViewBitmap(R.id.imgContainer, bitmap)


            val amountText: String = amount.toString()
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
                views.setViewVisibility(R.id.btnRefreshDark, View.VISIBLE)
                views.setViewVisibility(R.id.btnSettings, View.GONE)
                views.setViewVisibility(R.id.btnSettingsDark, View.VISIBLE)
                views.setViewVisibility(R.id.txtSymbolLight, View.GONE)
                views.setViewVisibility(R.id.txtSymbolDark, View.VISIBLE)
                i = 8
            } else {
//                views.setTextColor(
//                    R.id.txtSymbol, ContextCompat.getColor(
//                        context,
//                        R.color.textLight
//                    )
//                )
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


            appWidgetManager.updateAppWidget(appWidgetId, views)
        }

        fun setRemoteAdapter(
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
            intent.putExtra("appWidgetId",appWidgetId)


            views.setRemoteAdapter(R.id.listCurrency, intent)

            val toastIntent = Intent(context, ListWidgetProvider::class.java)


            toastIntent.action = Constants.TOAST_ACTION
            toastIntent.putExtra("appWidgetId", appWidgetId)
            intent.data = Uri.parse(intent.toUri(Intent.URI_INTENT_SCHEME))


            views.setPendingIntentTemplate(
                R.id.listCurrency,
                PendingIntent.getBroadcast(
                    context,
                    0,
                    toastIntent,
                    PendingIntent.FLAG_UPDATE_CURRENT
                )
            )

//            appWidgetManager.updateAppWidget(appWidgetId, views)
        }


        @SuppressLint("CheckResult")
        fun getRate(
            context: Context?,
            views: RemoteViews,
            jsonItems: JSONArray,
            baseCurrency: String?,
            amount: Double,
            appWidgetId: Int,
            visualSize: Int,
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
                                val currencyItems = ArrayList<Currency>()


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

                                    currencyItems.add(
                                        Currency(
                                            flagList.getDrawable(i)!!,
                                            to,
                                            nameList[i]!!,
                                            todayRate.toString(),
                                            diff.toString(),
                                            false,
                                            false
                                        )
                                    )
                                }


//                                setRemoteAdapter(
//                                    context,
//                                    views,
//                                    currencyItems,
//                                    baseCurrency,
//                                    amount,
//                                    appWidgetId,
//                                    visualSize,
//                                    appWidgetManager
//                                )

                            }
                        }

                    }
                }, { error ->
                    Log.e(javaClass.simpleName, "error-->$error")

                })


        }


    }


}