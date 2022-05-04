package com.example.currency_converter.utils

import android.content.Context
import android.content.SharedPreferences
import android.graphics.*
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.GradientDrawable
import android.graphics.drawable.PictureDrawable
import android.util.Log
import android.widget.TextView
import kotlin.jvm.internal.Intrinsics

class Utility {


    companion object {

        fun isDarkTheme(
            context: Context
        ): Boolean {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );

            return prefs.getBoolean("flutter." + "theme1", false)


        }

        fun setStringPref(
            key: String, value: String, context: Context
        ): Boolean {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );
            val editor: SharedPreferences.Editor = prefs.edit()
            editor.putString("flutter." + key, value)
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
            return prefs.getString("flutter." + key, "")!!
        }

        fun setIntegerPref(
            key: String, value: Int, context: Context
        ): Boolean {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            );
            val editor: SharedPreferences.Editor = prefs.edit()
            editor.putInt("flutter." + key, value)
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


        fun saveListWidgetTransparency(context: Context, value: Int, appWidgetId: Int): Boolean {

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

        }

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
                Constants.selectedCurrencyList + "$appWidgetId",
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
                Constants.baseCurrency + "$appWidgetId",
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
            return prefs.getInt(
                "flutter." + Constants.fontSizeListWidget + "$appWidgetId",
                1
            )
        }

        fun saveVisual(context: Context, size: Int, appWidgetId: Int): Boolean {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            )

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


//        fun decimalStringEliminateZeros(real: BigDecimal?,context: Context): String {
//            val groupFormat: Char
//            val dotFormat: Char
//            Intrinsics.checkNotNullParameter(real, "real")
//            var decimalFormatString = ""
//
//          val decimalFormat =   Utility.getIntegerPref(Constants.decimalFormat,context)
//
//
//            when (decimalFormat) {
//                0 -> decimalFormatString = ".##"
//                1 -> decimalFormatString = ".###"
//                2 -> decimalFormatString = ".####"
//                3 -> decimalFormatString = ".#####"
//                4 -> decimalFormatString = ".######"
//            }
//            val formattedString: String =
//                com.currencywiki.currencyconverter.util.ExtensionsKt.decimalString(
//                    real,
//                    "#,##0$decimalFormatString"
//                )
//            when (settingManager.getMonetaryFormat()) {
//                1 -> {
//                    dotFormat = ','
//                    groupFormat = '.'
//                }
//                2 -> {
//                    dotFormat = '.'
//                    groupFormat = ' '
//                }
//                3 -> {
//                    dotFormat = ','
//                    groupFormat = ' '
//                }
//                else -> {
//                    dotFormat = '.'
//                    groupFormat = ','
//                }
//            }
//            return `replace$default`(
//                `replace$default`(
//                    `replace$default`(
//                        formattedString,
//                        ClassUtils.PACKAGE_SEPARATOR_CHAR as Char,
//                        amp as Char,
//                        false,
//                        4,
//                        null as Any?
//                    ), ',', groupFormat, false, 4, null as Any?
//                ), amp as Char, dotFormat, false, 4, null as Any?
//            )
//        }

    }

}

