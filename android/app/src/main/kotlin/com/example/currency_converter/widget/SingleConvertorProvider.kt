package com.example.currency_converter.widget

import android.annotation.SuppressLint
import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.*
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.GradientDrawable
import android.os.Bundle
import android.util.Log
import android.widget.RemoteViews
import com.example.currency_converter.MainActivity
import com.example.currency_converter.R
import com.example.currency_converter.activity.SingleWidgetConfigurationActivity
import com.example.currency_converter.api.ApiClient
import com.example.currency_converter.utils.Constants
import com.example.currency_converter.utils.Utility
import com.google.gson.JsonObject
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
import io.reactivex.schedulers.Schedulers
import retrofit2.Response
import java.util.*
import kotlin.jvm.internal.Intrinsics


class SingleConvertorProvider : HomeWidgetProvider() {


    override fun onReceive(context: Context?, intent: Intent?) {

        Log.e(javaClass.simpleName, "onReceive--> ${intent?.data}")



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
        Log.e(
            javaClass.simpleName,
            "onAppWidgetOptionsChanged-->\n${appWidgetId} ${appWidgetManager.toString()}"
        )
        super.onAppWidgetOptionsChanged(context, appWidgetManager, appWidgetId, newOptions)
    }

    override fun onRestored(context: Context?, oldWidgetIds: IntArray?, newWidgetIds: IntArray?) {
        Log.e(
            javaClass.simpleName,
            "onRestored--> newWidgetIds - $newWidgetIds ,oldWidgetIds - $oldWidgetIds  "
        )

        super.onRestored(context, oldWidgetIds, newWidgetIds)
    }

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {

        Log.e(javaClass.simpleName, "onUpdate--> ")


        for (widgetId in appWidgetIds) {
            Log.e(javaClass.simpleName, "widgetId-->$widgetId")

            var from: String = Utility.getStringPref("currencyCodeFrom", context!!)
            var to: String = Utility.getStringPref("currencyCodeTo", context!!)

            if (from.isNotEmpty() && to.isNotEmpty()) {
                converotRate(from, to, context, appWidgetManager, widgetId)
            }
        }
    }


    companion object {
        val ACTION_WIDGET_CONFIGURE = "ConfigureWidget"

        fun getCircularBitmapFrom(bitmap: Bitmap?): Bitmap? {
            val i: Int
            if (bitmap == null || bitmap.isRecycled) {
                return null
            }
            i = if (bitmap.width > bitmap.height) {
                bitmap.height
            } else {
                bitmap.width
            }
            val canvasBitmap =
                Bitmap.createBitmap(bitmap.width, bitmap.height, Bitmap.Config.ARGB_8888)
            val shader = BitmapShader(bitmap, Shader.TileMode.CLAMP, Shader.TileMode.CLAMP)
            val paint = Paint()
            paint.isAntiAlias = true
            paint.shader = shader
            val f = 2.toFloat()
            Canvas(canvasBitmap).drawCircle(
                bitmap.width.toFloat() / f, bitmap.height
                    .toFloat() / f, i.toFloat() / 2.0f, paint
            )
            return canvasBitmap
        }

        fun drawableToBitmap(
            drawable: GradientDrawable,
            width: Int,
            height: Int
        ): Bitmap {
            val bitmap: Bitmap
            Intrinsics.checkNotNullParameter(drawable, "drawable")
            val bitmap2: Bitmap? = null
            if (drawable is BitmapDrawable) {
                val bitmapDrawable = drawable as BitmapDrawable
                if (bitmapDrawable.bitmap != null) {
                    return bitmapDrawable.bitmap
                }
            }
            bitmap = if (drawable.intrinsicWidth <= 0 || drawable.intrinsicHeight <= 0) {
                Bitmap.createBitmap(
                    width,
                    height,
                    Bitmap.Config.ARGB_8888
                )
            } else {
                Bitmap.createBitmap(
                    drawable.intrinsicWidth,
                    drawable.intrinsicHeight,
                    Bitmap.Config.ARGB_8888
                )
            }
            val canvas = Canvas(bitmap)
            drawable.setBounds(0, 0, canvas.width, canvas.height)
            drawable.draw(canvas)
            return bitmap
        }

        fun getWidgetGradientDrawable(
            color: Int,
            orientation: Int,
            shape: Int,
            radius: Float
        ): GradientDrawable {
            val gradientOrientation: GradientDrawable.Orientation
            val a = Color.alpha(color)
            val r = Color.red(color)
            val g = Color.green(color)
            val b = Color.blue(color)
            val hsv = FloatArray(3)
            val orgHsv = FloatArray(3)
            Color.RGBToHSV(r, g, b, hsv)
            Color.RGBToHSV(r, g, b, orgHsv)
            val startSaturation = hsv[1] - 0.37f
            if (startSaturation.toDouble() >= 0.2) {
                hsv[1] = startSaturation
            } else if (hsv[2].toDouble() < 0.25) {
                hsv[1] = 0.2f
            } else {
                hsv[2] = hsv[2] - 0.2f
            }
            val gradientColors = intArrayOf(Color.HSVToColor(a, hsv), Color.HSVToColor(a, orgHsv))
            gradientOrientation = if (orientation == 0) {
                GradientDrawable.Orientation.TOP_BOTTOM
            } else {
                GradientDrawable.Orientation.LEFT_RIGHT
            }
            if (shape == 0) {
                val gradientDrawable = GradientDrawable(gradientOrientation, gradientColors)
                gradientDrawable.cornerRadius = radius
                return gradientDrawable
            }
            val f = radius
            val gradientDrawable2 = GradientDrawable(gradientOrientation, gradientColors)
            gradientDrawable2.shape = GradientDrawable.RECTANGLE
            gradientDrawable2.cornerRadius = radius
            return gradientDrawable2
        }

        fun updateWidget(context: Context?, appWidgetManager: AppWidgetManager, widgetId: Int) {
            val views = RemoteViews(context?.packageName, R.layout.single_converter_layout).apply {

                val widgetInfo = appWidgetManager.getAppWidgetInfo(widgetId)
//                val colorFrom: Int = Utility.getIntegerPref("color_code_start", context!!)
                var colorcode = Utility.getStringPref("primaryColorCode", context!!)
                if(colorcode.isEmpty()){
                    colorcode = "ff4e7dcb"
                }
                Log.e(javaClass.name, "colorcode-->$colorcode")

                val colorFrom: Int = Color.parseColor("#$colorcode")
                val trans = Utility.getIntegerPref(Constants.widgetTransparent, context)
                var transparancy: Float = 1f - (trans.toFloat() / 100)
                val color = Utility.getColorWithAlpha(colorFrom, transparancy)
                val gradientDrawable = getWidgetGradientDrawable(color, 0, 0, 16f)
                val bitmap =
                    drawableToBitmap(gradientDrawable, widgetInfo.minWidth, widgetInfo.minHeight)
                setImageViewBitmap(R.id.bck_image, bitmap)

                val value: String = Utility.getStringPref("currencySaveData", context!!)
                val diff: String = Utility.getStringPref("difference", context)
                val from: String = Utility.getStringPref("currencyCodeFrom", context)
                val to: String = Utility.getStringPref("currencyCodeTo", context)
                var decimalFormat = Utility.getStringPref("decimalFormat", context)
                if (decimalFormat.isEmpty()) {
                    decimalFormat = "2"
                }

                Log.e(javaClass.simpleName, "value-->$value")
                Log.e(javaClass.simpleName, "from-->$from")
                Log.e(javaClass.simpleName, "to-->$to")
                setTextViewText(
                    R.id.tv_value, "%.${decimalFormat}f".format(value.toDouble())
                )

                setTextViewText(
                    R.id.tv_from, from
                )
                setTextViewText(
                    R.id.tv_to, to
                )


                var d: Double = diff.toDouble();

                if (d < 0) {
                    setImageViewResource(R.id.img_arrow, R.drawable.ic_arrow_down)
                    setTextViewText(
                        R.id.tv_change_rate, "" + "%.4f".format(diff.toDouble() * 100) + "%"
                    )
                } else {
                    setImageViewResource(R.id.img_arrow, R.drawable.arrow_up)
                    setTextViewText(
                        R.id.tv_change_rate, "+" + "%.4f".format(diff.toDouble() * 100) + "%"
                    )
                }

                var currencyList = context.resources.getStringArray(R.array.currency_code)

                var index: Int = currencyList.indexOf(from)
                var index1: Int = currencyList.indexOf(to)

                val flagArray = context.resources.obtainTypedArray(R.array.country_flag)
                val imgFrom = flagArray.getDrawable(index)
                val imgTo = flagArray.getDrawable(index1)


                val bitmapOptions = BitmapFactory.Options()
                bitmapOptions.inSampleSize = 4

                val img: Bitmap =
                    (imgFrom as BitmapDrawable).bitmap
                val img1: Bitmap =
                    (imgTo as BitmapDrawable).bitmap

                setImageViewBitmap(R.id.img_from, getCircularBitmapFrom(img))
                setImageViewBitmap(R.id.img_to, getCircularBitmapFrom(img1))


                var fontSize = Utility.getIntegerPref(Constants.fontSize, context)

                if (fontSize == 0) {
                    fontSize = 1;
                    Utility.setIntegerPref(Constants.fontSize, 1, context)
                }

                when (fontSize) {

                    1 -> {

                        setTextViewTextSize(
                            R.id.tv_from,
                            0,
                            context.resources.getDimension(R.dimen._14sdp)
                        )
                        setTextViewTextSize(
                            R.id.tv_to,
                            0,
                            context.resources.getDimension(R.dimen._14sdp)
                        )
                        setTextViewTextSize(
                            R.id.tv_value,
                            0,
                            context.resources.getDimension(R.dimen._16sdp)
                        )
                        setTextViewTextSize(
                            R.id.tv_change_rate,
                            0,
                            context.resources.getDimension(R.dimen._12sdp)
                        )

                        setTextViewTextSize(
                            R.id.txtProvider,
                            0,
                            context.resources.getDimension(R.dimen._10sdp)
                        )


                    }
                    2 -> {
                        setTextViewTextSize(
                            R.id.tv_from,
                            0,
                            context.resources.getDimension(R.dimen._15sdp)
                        )
                        setTextViewTextSize(
                            R.id.tv_to,
                            0,
                            context.resources.getDimension(R.dimen._15sdp)
                        )
                        setTextViewTextSize(
                            R.id.tv_value,
                            0,
                            context.resources.getDimension(R.dimen._17sdp)
                        )
                        setTextViewTextSize(
                            R.id.tv_change_rate,
                            0,
                            context.resources.getDimension(R.dimen._13sdp)
                        )
                        setTextViewTextSize(
                            R.id.txtProvider,
                            0,
                            context.resources.getDimension(R.dimen._11sdp)
                        )
                    }
                    3 -> {
                        setTextViewTextSize(
                            R.id.tv_from,
                            0,
                            context.resources.getDimension(R.dimen._16sdp)
                        )
                        setTextViewTextSize(
                            R.id.tv_to,
                            0,
                            context.resources.getDimension(R.dimen._16sdp)
                        )
                        setTextViewTextSize(
                            R.id.tv_value,
                            0,
                            context.resources.getDimension(R.dimen._18sdp)
                        )
                        setTextViewTextSize(
                            R.id.tv_change_rate,
                            0,
                            context.resources.getDimension(R.dimen._14sdp)
                        )
                        setTextViewTextSize(
                            R.id.txtProvider,
                            0,
                            context.resources.getDimension(R.dimen._12sdp)
                        )
                    }


                }

                // Open App on Widget Click
                val pendingIntent = context.let {
                    HomeWidgetLaunchIntent.getActivity(
                        it,
                        MainActivity::class.java
                    )
                }

                setOnClickPendingIntent(R.id.widget_container, pendingIntent)

                setOnClickPendingIntent(R.id.btnSettings, getConfigurePendingIntent(context,widgetId))
                setOnClickPendingIntent(R.id.btnSettingsDark, getConfigurePendingIntent(context,widgetId))

                setOnClickPendingIntent(R.id.btnRefresh, getRefreshPendingIntent(context, widgetId))
                setOnClickPendingIntent(R.id.btnRefreshDark, getRefreshPendingIntent(context, widgetId))


            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }

        private fun getRefreshPendingIntent(context: Context, widgetId: Int): PendingIntent {
            val intentUpdate = Intent(
                context,
                SingleConvertorProvider::class.java
            )
            intentUpdate.action = AppWidgetManager.ACTION_APPWIDGET_UPDATE

            intentUpdate.putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, intArrayOf(widgetId))


            return PendingIntent.getBroadcast(
                context, widgetId, intentUpdate,
                PendingIntent.FLAG_UPDATE_CURRENT
            )
        }

        private fun getConfigurePendingIntent(context: Context, widgetId: Int): PendingIntent {

            val configIntent = Intent(context, SingleWidgetConfigurationActivity::class.java)
            configIntent.action = ACTION_WIDGET_CONFIGURE
            configIntent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)
            return PendingIntent.getActivity(
                context,
                widgetId,
                configIntent,
                PendingIntent.FLAG_UPDATE_CURRENT
            )
        }


        @SuppressLint("CheckResult")
        fun converotRate(
            from: String,
            to: String,
            context: Context,
            appWidgetManager: AppWidgetManager,
            widgetId: Int
        ): String {
//         Log.e("Internet Connection", )

            var disposable: Disposable? = null
            var rate: String = "0.0";

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

                                val todayRate1 = quote.get(from.uppercase()).toString()
                                val todayRate2 = quote.get(to.uppercase()).toString()

                                val todayRate =
                                    (todayRate1.toDouble() * 100) / (todayRate2.toDouble() * 100)
                                Log.e(
                                    javaClass.simpleName,
                                    "today rate-->$todayRate"
                                )

                                val yesterdayRate1 = yesterday.get(from.uppercase()).toString()
                                val yesterdayRate2 = yesterday.get(to.uppercase()).toString()
                                val yesterdayRate =
                                    (yesterdayRate1.toDouble() * 100) / (yesterdayRate2.toDouble() * 100)
                                Log.e(
                                    javaClass.simpleName,
                                    "yesterday rate-->$yesterdayRate"
                                )

                                var diff = todayRate - yesterdayRate
                                Utility.setStringPref("difference", diff.toString(), context);

                                Utility.setStringPref(
                                    "currencySaveData",
                                    todayRate.toString(),
                                    context
                                );


                                updateWidget(context, appWidgetManager, widgetId)


                            }
                        }

                    }
                }, { error ->
                    Log.e(javaClass.simpleName, "error-->$error")

                })



            return rate
        }

        fun <T> Iterator<T>.toList(): List<T> =
            LinkedList<T>().apply {
                while (hasNext())
                    this += next()
            }.toMutableList()

    }


}