package com.example.currency_converter.utils

import android.content.Context
import android.content.SharedPreferences
import android.content.res.Configuration
import android.content.res.Resources
import android.graphics.*
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.GradientDrawable
import android.graphics.drawable.PictureDrawable
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Build
import android.util.DisplayMetrics
import android.util.Log
import android.widget.TextView
import java.text.DecimalFormat
import java.text.DecimalFormatSymbols
import java.text.NumberFormat
import java.util.*
import kotlin.jvm.internal.Intrinsics

class Utility {


    companion object {


        fun setCurrencyInputValue(
            context: Context,
            value: String,

            ): Boolean {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );
            val editor: SharedPreferences.Editor = prefs.edit()
            editor.putString("flutter." + Constants.currencyInputValue, value)
            editor.apply()
            return editor.commit()
        }
 fun setCurrencyCodeFrom(
            context: Context,
            value: String,

            ): Boolean {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );
            val editor: SharedPreferences.Editor = prefs.edit()
            editor.putString("flutter." + Constants.currencyFrom, value)
            editor.apply()
            return editor.commit()
        }

        fun setCurrencyCodeTo(
            context: Context,
            value: String,

            ): Boolean {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );
            val editor: SharedPreferences.Editor = prefs.edit()
            editor.putString("flutter." + Constants.currencyTo, value)
            editor.apply()
            return editor.commit()
        }

        fun setCurrencyCode1(
            context: Context,
            value: String,
            widgetId: Int
        ): Boolean {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );
            val editor: SharedPreferences.Editor = prefs.edit()
            editor.putString(Constants.currencyFrom + widgetId, value)
            editor.apply()
            return editor.commit()
        }

        fun getCurrencyCode1(context: Context, widgetId: Int): String {

            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );

            val v = prefs.getString(Constants.currencyFrom + widgetId, "USD")

            return if (v != null && v.isNotEmpty()) {
                v
            } else {
                "USD"
            }


        }


        fun setCurrencyCode2(
            context: Context,
            value: String,
            widgetId: Int
        ): Boolean {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );
            val editor: SharedPreferences.Editor = prefs.edit()
            editor.putString(Constants.currencyTo + widgetId, value)
            editor.apply()
            return editor.commit()
        }

        fun getCurrencyCode2(context: Context, widgetId: Int): String {

            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );

            val v = prefs.getString(Constants.currencyTo + widgetId, "EUR")

            return if (v != null && v.isNotEmpty()) {
                v
            } else {
                "EUR"
            }


        }

        fun setExchangeValue(context: Context, value: String, widgetId: Int): Boolean {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );
            val editor: SharedPreferences.Editor = prefs.edit()
            editor.putString(Constants.currencyRate + widgetId, value)
            editor.apply()
            return editor.commit()


        }

        fun getExchangeValue(context: Context, widgetId: Int): String {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );

            val v = prefs.getString(Constants.currencyRate + widgetId, "0.0")

            return if (v != null && v.isNotEmpty()) {
                v
            } else {
                "0.0"
            }
        }


        fun getWidgetColor(
            context: Context
        ): String {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );
            val v = prefs.getString("flutter." + "primaryColorCode", "ff4e7dcb")
            return if (v != null && v.isNotEmpty()) {
                v
            } else {
                "ff4e7dcb"
            }
        }


        fun isDarkTheme(
            context: Context
        ): Boolean {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );

            return prefs.getBoolean("flutter." + "isDarkMode", false)


        }


        fun isSubscriptionPurchased(
            context: Context
        ): Boolean {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );

            return prefs.getBoolean("flutter." + "checkWidgetPurchaseAds", false)


        }

        fun setStringPref(
            key: String, value: String, context: Context
        ): Boolean {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );
            val editor: SharedPreferences.Editor = prefs.edit()
            editor.putString("flutter.$key", value)
            editor.apply()
            return editor.commit()
        }

        fun getStringPref(
            key: String, context: Context
        ): String {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );
            return prefs.getString("flutter.$key", "")!!
        }

        fun getMonetaryFormat(
            context: Context
        ): String {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );

            val v = prefs.getString("flutter.monetaryFormat", "1")

            return if (v != null && v.isNotEmpty()) {
                v
            } else {
                "1"
            }

        }

        fun getDecimalFormat(
            context: Context
        ): String {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );
            val v = prefs.getString("flutter.decimalFormat", "2")!!
            return if (v != null && v.isNotEmpty()) {
                v
            } else {
                "2"
            }
        }

        fun setIntegerPref(
            key: String, value: Int, context: Context
        ): Boolean {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );
            val editor: SharedPreferences.Editor = prefs.edit()
            editor.putInt("flutter.$key", value)
            editor.apply()
            return editor.commit()
        }

        fun getIntegerPref(
            key: String, context: Context
        ): Int {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );
            return prefs.getInt("flutter.$key", 0)
        }

        fun saveWidgetTransparency(context: Context, value: Int): Boolean {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );

            val edit = prefs.edit()
            edit.putString("flutter." + "widgetTransparent", value.toString())
            edit.apply()
            return edit.commit()
        }

        fun getWidgetTransparency(context: Context): Int {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );

            var v = prefs.getString("flutter." + "widgetTransparent", "0")
            Log.e(javaClass.simpleName, "getWidgetTransparency-->$v")

            return v!!.toInt()
        }


        /*   fun saveSingleWidgetTransparency(context: Context, value: Int, appWidgetId: Int): Boolean {

               val prefs = context.getSharedPreferences(
                   "FlutterSharedPreferences",
                   Context.MODE_PRIVATE
               )
               val edit = prefs.edit()

               edit.putInt(Constants.widgetTransparent + appWidgetId, value)
               edit.apply()
               return edit.commit()
           }

           fun getSingleWidgetTransparency(context: Context, appWidgetId: Int): Int {
               val prefs = context.getSharedPreferences(
                   "FlutterSharedPreferences",
                   Context.MODE_PRIVATE
               )
               return prefs.getInt(Constants.widgetTransparent + appWidgetId, 0)
           }*/


        /*    fun saveListWidgetTransparency(context: Context, value: Int, appWidgetId: Int): Boolean {
                val prefs = context.getSharedPreferences(
                    "FlutterSharedPreferences",
                    Context.MODE_PRIVATE
                )
                val edit = prefs.edit()
                edit.putInt(Constants.listWidgetTransparent + appWidgetId, value)
                edit.apply()
                return edit.commit()
            }

            fun getListWidgetTransparency(context: Context, appWidgetId: Int): Int {

                val prefs = context.getSharedPreferences(
                    "FlutterSharedPreferences",
                    Context.MODE_PRIVATE
                )
                return prefs.getInt(Constants.listWidgetTransparent + appWidgetId, 0)

            }*/

        fun loadItemsPref(context: Context, appWidgetId: Int): String {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            )
            return prefs.getString(
                "flutter." + Constants.selectedCurrencyList + "$appWidgetId",
                ""
            )!!
        }

        fun saveListWidgetData(context: Context, data: String, appWidgetId: Int): Boolean {
            val prefs = context.getSharedPreferences(
                "ListWidgetPreference",
                Context.MODE_PRIVATE
            )

            val editor = prefs.edit()
            editor.putString(
                Constants.listWidgetData + "$appWidgetId",
                data
            )!!
            editor.apply()
            return editor.commit()
        }

        fun getListWidgetData(context: Context, appWidgetId: Int): String {
            val prefs = context.getSharedPreferences(
                "ListWidgetPreference",
                Context.MODE_PRIVATE
            )
            return prefs.getString(
                Constants.listWidgetData + "$appWidgetId",
                ""
            )!!
        }

        fun saveItemsPref(context: Context, data: String, appWidgetId: Int): Boolean {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            )

            val editor = prefs.edit()
            editor.putString(
                "flutter." + Constants.selectedCurrencyList + "$appWidgetId",
                data
            )!!
            editor.apply()
            return editor.commit()
        }

        fun loadBaseCurrency(context: Context, appWidgetId: Int): String {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            )
            return prefs.getString(
                "flutter." + Constants.baseCurrency + "$appWidgetId",
                "USD"
            )!!
        }

        fun getLanguage(context: Context): String {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            )
            return prefs.getString(
                "flutter." + Constants.languageCode,
                "en"
            )!!
        }

        fun saveBaseCurrency(context: Context, currency: String, appWidgetId: Int): Boolean {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            )

            val editor = prefs.edit()


            editor.putString(
                "flutter." + Constants.baseCurrency + "$appWidgetId",
                currency
            )!!

            editor.apply()
            return editor.commit()
        }

        fun loadAmount(context: Context, appWidgetId: Int): String {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            )
            return prefs.getString(
                "flutter." + Constants.baseAmount + "$appWidgetId",
                "1"
            )!!
        }

        fun saveAmount(context: Context, amount: String, appWidgetId: Int): Boolean {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            )

            val editor = prefs.edit()
            editor.putString("flutter." + Constants.baseAmount + "$appWidgetId", amount)
            editor.apply()
            return editor.commit()
        }

        fun loadVisual(context: Context, appWidgetId: Int): Int {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            )
            val v =   prefs.getInt(
                "flutter." + Constants.fontSizeListWidget + "$appWidgetId",
                1
            )
            Log.e("loadVisual-->","$v")

            return v
        }

        fun saveVisual(context: Context, size: Int, appWidgetId: Int): Boolean {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            )
            Log.e("saveVisual-->","$size")


            val editor = prefs.edit()

            editor.putInt(
                "flutter." + Constants.fontSizeListWidget + "$appWidgetId",
                size
            )
            editor.apply()
            return editor.commit()
        }

        fun getColorWithAlpha(color: Int, ratio: Float): Int {
            var newColor = 0
            val alpha = Math.round(Color.alpha(color) * ratio)
            val r = Color.red(color)
            val g = Color.green(color)
            val b = Color.blue(color)
            newColor = Color.argb(alpha, r, g, b)
            return newColor
        }


        fun getFlagRaw(flagName: String, context: Context): Int {
            Intrinsics.checkNotNullParameter(flagName, "flagName")
            val resources = context.resources
            return resources.getIdentifier("ic_$flagName", "raw", context.packageName)
        }

        fun setTextViewSize(textView: TextView, textSize: Float) {
            textView.setTextSize(0, textSize)
        }

        fun getCircularBitmapFromSVGFileName(fileName: String, context: Context): Bitmap {
            Log.e("fileName", "fileName$fileName")
            Intrinsics.checkNotNullParameter(fileName, "fileName")
            return getCircularBitmapFrom(
                bitmapFromSVGFileName(
                    fileName,
                    context
                )
            )!!
        }

        fun bitmapFromSVGFileName(fileName: String, context: Context): Bitmap {
            val drawable: BitmapDrawable
            Intrinsics.checkNotNullParameter(fileName, "fileName")

            val context: Context = context.applicationContext
//            if (!Intrinsics.areEqual(
//                    fileName as Any,
//                    "mm" as Any
//                ) && !Intrinsics.areEqual(fileName as Any, "ss" as Any) && !Intrinsics.areEqual(
//                    fileName as Any,
//                    "ve" as Any
//                ) && !Intrinsics.areEqual(fileName as Any, "bc" as Any) && !Intrinsics.areEqual(
//                    fileName as Any,
//                    "ca" as Any
//                )
//            ) {
//                return pictureDrawable2Bitmap(
//                    pictureDrawableFromSVGFileName(
//                        fileName
//                    )
//                )
//            }
            val resources = context.resources
            val imageResource =
                resources.getIdentifier("ic_$fileName", "raw", context.packageName)


            Log.e("bitmapFromSVGFileName", "imageResource$imageResource")


            val drawable2 = resources.getDrawable(imageResource)
            Log.e("bitmapFromSVGFileName", "imageResource$imageResource")
            if (drawable2 != null) {
                drawable2 as BitmapDrawable
            } else {
                throw NullPointerException("null cannot be cast to non-null type android.graphics.drawable.BitmapDrawable")
            }

            drawable = drawable2 as BitmapDrawable
            return drawable.bitmap
        }

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


        fun pictureDrawable2Bitmap(pictureDrawable: PictureDrawable): Bitmap {
            Intrinsics.checkNotNullParameter(pictureDrawable, "pictureDrawable")
            val bitmap = Bitmap.createBitmap(
                pictureDrawable.intrinsicWidth,
                pictureDrawable.intrinsicHeight,
                Bitmap.Config.ARGB_8888
            )
            Intrinsics.checkNotNullExpressionValue(
                bitmap,
                "Bitmap.createBitmap(\n   …onfig.ARGB_8888\n        )"
            )
            Canvas(bitmap).drawPicture(pictureDrawable.picture)
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
            return gradientDrawable2
        }


//        fun pictureDrawableFromSVGFileName(fileName: String?): PictureDrawable {
//            Intrinsics.checkNotNullParameter(fileName, "fileName")
//            val instance: AppCurrency = AppCurrency.Companion.getInstance()
//            Intrinsics.checkNotNull(instance)
//            val context: Context = instance.getApplicationContext()
//            val createPictureDrawable: PictureDrawable = SVGParser.getSVGFromResource(
//                context.resources,
//                com.currencywiki.currencyconverter.util.ResourcesKt.getFlagRaw(fileName)
//            ).createPictureDrawable()
//            Intrinsics.checkNotNullExpressionValue(
//                createPictureDrawable,
//                "svg.createPictureDrawable()"
//            )
//            return createPictureDrawable
//        }


        /*fun decimalStringEliminateZeros(real: BigDecimal?, context: Context): String {
            val groupFormat: Char
            val dotFormat: Char
            Intrinsics.checkNotNullParameter(real, "real")
            var decimalFormatString = ""

            val decimalFormat = getDecimalFormat(context)


            when (decimalFormat) {
                "2" -> decimalFormatString = ".##"
                "3" -> decimalFormatString = ".###"
                "4" -> decimalFormatString = ".####"
                "5" -> decimalFormatString = ".#####"
                "5" -> decimalFormatString = ".######"
                else -> decimalFormatString = ""
            }
            val formattedString: String =
                com.currencywiki.currencyconverter.util.ExtensionsKt.decimalString(
                    real,
                    "#,##0$decimalFormatString"
                )
            when (settingManager.getMonetaryFormat()) {
                1 -> {
                    dotFormat = ','
                    groupFormat = '.'
                }
                2 -> {
                    dotFormat = '.'
                    groupFormat = ' '
                }
                3 -> {
                    dotFormat = ','
                    groupFormat = ' '
                }
                else -> {
                    dotFormat = '.'
                    groupFormat = ','
                }
            }
            return `replace$default`(
                `replace$default`(
                    `replace$default`(
                        formattedString,
                        ClassUtils.PACKAGE_SEPARATOR_CHAR as Char,
                        amp as Char,
                        false,
                        4,
                        null as Any?
                    ), ',', groupFormat, false, 4, null as Any?
                ), amp as Char, dotFormat, false, 4, null as Any?
            )
        }*/


        fun currencyFormatter(num: String, context: Context): String {


            if (num.isEmpty()) {

                return num;
            } else {
                val m = num.toDouble()
                val format: NumberFormat = NumberFormat.getCurrencyInstance()

                val decimalFormat = getDecimalFormat(context)
                if (decimalFormat.isNotEmpty()) {
                    format.maximumFractionDigits = decimalFormat.toInt()
                    format.minimumFractionDigits = decimalFormat.toInt()
                } else {
                    format.maximumFractionDigits = 0
                }

                val decimalFormatSymbols: DecimalFormatSymbols = (format as DecimalFormat).decimalFormatSymbols
                decimalFormatSymbols.currencySymbol = ""
                (format as DecimalFormat).decimalFormatSymbols = decimalFormatSymbols
                return format.format(m)
            }
        }

        fun monetaryFormatter(v: String, context: Context): String {

            if (v.isEmpty()) {
                return "0"
            } else {
                val format = getMonetaryFormat(context)

                var amount = v
                when (format) {

                    "1" -> {
                    }
                    "2" -> {

                        amount = amount.replace(",", "@")
                        amount = amount.replace(".", ",")
                        amount = amount.replace("@", ".")
                    }
                    "3" -> {
                        amount = amount.replace(",", " ")
                    }
                    "4" -> {
                        amount = amount.replace(",", " ")
                        amount = amount.replace(".", ",")
                    }


                }
                return amount


            }

        }


        fun isOnline(context: Context): Boolean {
            val connectivityManager =
                context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            if (connectivityManager != null) {
                val capabilities =
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        connectivityManager.getNetworkCapabilities(connectivityManager.activeNetwork)
                    } else {
                        connectivityManager.getNetworkCapabilities(connectivityManager.allNetworks[0])
                    }
                if (capabilities != null) {
                    if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR)) {
                        Log.i("Internet", "NetworkCapabilities.TRANSPORT_CELLULAR")
                        return true
                    } else if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI)) {
                        Log.i("Internet", "NetworkCapabilities.TRANSPORT_WIFI")
                        return true
                    } else if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET)) {
                        Log.i("Internet", "NetworkCapabilities.TRANSPORT_ETHERNET")
                        return true
                    }
                }
            }
            return false
        }


        fun setAppLanguage(context: Context) {
            try {
                val res: Resources = context.resources
                val dm: DisplayMetrics = res.displayMetrics
                val conf: Configuration = res.getConfiguration()
                conf.setLocale(Locale(getLanguage(context).toLowerCase())) // API 17+ only.
                res.updateConfiguration(conf, dm)
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }


    }

}

