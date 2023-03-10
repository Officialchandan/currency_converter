package com.currencywiki.currencyconverter.widget_service

import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.util.Log
import android.widget.RemoteViews
import android.widget.RemoteViewsService
import com.currencywiki.currencyconverter.R
import com.currencywiki.currencyconverter.utils.Constants
import com.currencywiki.currencyconverter.utils.Utility
import com.currencywiki.currencyconverter.widget.ListWidgetProvider
import com.currencywiki.currencyconverter.widget.SingleConvertorProvider
import org.json.JSONArray
import java.math.BigDecimal
import kotlin.jvm.internal.Intrinsics

class WidgetDataProvider(val context: Context, val mIntent: Intent) :
    RemoteViewsService.RemoteViewsFactory {


    private var amount = BigDecimal(0.0)
    private var baseCurrency: String? = "USD"
    private var codeList = ArrayList<String>()
    private var exchangeRate = ArrayList<String>()
    private var diffrence = ArrayList<String>()
    private var flag = ArrayList<Drawable>()
    private var visualSize = 1
    private var decimalFormat = "2"
    var widgetId  = 0

    var currencyList = ArrayList<String>()


    override fun onCreate() {
        Log.e(javaClass.simpleName, "onCreate->")

        decimalFormat = Utility.getStringPref("decimalFormat", context)
        Log.e(javaClass.simpleName, "decimalFormat->$decimalFormat")
        initData()
    }

    override fun getLoadingView(): RemoteViews? {
        return null
    }

    override fun onDataSetChanged() {
        Log.e(javaClass.simpleName, "onDataSetChanged->")
        initData()
    }

    override fun onDestroy() {}
    /* JADX WARNING: Removed duplicated region for block: B:32:0x01c6  */ /* JADX WARNING: Removed duplicated region for block: B:33:0x01dc  */ /* Code decompiled incorrectly, please refer to instructions dump. */

    override fun getViewAt(position: Int): RemoteViews {
        val view = RemoteViews(context.packageName, R.layout.layout_widget_currency)
        val bitmapOptions = BitmapFactory.Options()
        bitmapOptions.inSampleSize = 4
        val img: Bitmap =
            (flag[position] as BitmapDrawable).bitmap
        view.setImageViewBitmap(R.id.img_flag, SingleConvertorProvider.getCircularBitmapFrom(img))

        view.setTextViewText(
            R.id.txt_code,
            codeList[position]
        )
       val amount = Utility.currencyFormatter(exchangeRate[position], context)

        view.setTextViewText(
            R.id.txtRate,
            Utility.monetaryFormatter(amount, context)
        )

        val d: Double = diffrence[position].toDouble();
        if (d < 0) {
            view.setTextViewText(
                R.id.txtPercent, "" + "%.4f".format(d)
            )
        } else {
            view.setTextViewText(
                R.id.txtPercent, "+" + "%.4f".format(d)
            )
        }

        if (Utility.isDarkTheme(context)) {
            view.setTextColor(R.id.txtRate, context.resources.getColor(R.color.textDark))
            view.setTextColor(R.id.txt_code, context.resources.getColor(R.color.textDark))
            view.setTextColor(R.id.txtPercent, context.resources.getColor(R.color.textDark))
        } else {
            view.setTextColor(R.id.txtRate, context.resources.getColor(R.color.white))
            view.setTextColor(R.id.txt_code, context.resources.getColor(R.color.white))
            view.setTextColor(R.id.txtPercent, context.resources.getColor(R.color.white))
        }



        when (visualSize) {
            1 -> {
                view.setTextViewTextSize(
                    R.id.txt_code,
                    0,
                    context.resources.getDimension(R.dimen._15sdp)
                )
                view.setTextViewTextSize(
                    R.id.txtRate,
                    0,
                    context.resources.getDimension(R.dimen._14sdp)
                )
                view.setTextViewTextSize(
                    R.id.txtPercent,
                    0,
                    context.resources.getDimension(R.dimen._10sdp)
                )


            }
            2 -> {
                view.setTextViewTextSize(
                    R.id.txt_code,
                    0,
                    context.resources.getDimension(R.dimen._16sdp)
                )
                view.setTextViewTextSize(
                    R.id.txtRate,
                    0,
                    context.resources.getDimension(R.dimen._15sdp)
                )
                view.setTextViewTextSize(
                    R.id.txtPercent,
                    0,
                    context.resources.getDimension(R.dimen._11sdp)
                )
            }
            3 -> {
                view.setTextViewTextSize(
                    R.id.txt_code,
                    0,
                    context.resources.getDimension(R.dimen._17sdp)
                )
                view.setTextViewTextSize(
                    R.id.txtRate,
                    0,
                    context.resources.getDimension(R.dimen._16sdp)
                )
                view.setTextViewTextSize(
                    R.id.txtPercent,
                    0,
                    context.resources.getDimension(R.dimen._12sdp)
                )
            }

        }

        val toastIntent = Intent(context, ListWidgetProvider::class.java)

        val appWidgetId = widgetId
        val currencyCode = codeList[position]
//        val bundle = Bundle()
//        bundle.putInt("position", position)
//        bundle.putString("currencyCode",currencyCode)
//        bundle.putInt("appWidgetId", appWidgetId)
//        toastIntent.putExtras(bundle)

        toastIntent.action = Constants.TOAST_ACTION
        toastIntent.putExtra("position", position)
        toastIntent.putExtra("appWidgetId", appWidgetId)
        toastIntent.putExtra("currencyCode", currencyCode)
        view.setOnClickFillInIntent(R.id.widget_item, toastIntent)


//        val toastIntent = Intent(context, ListWidgetProvider::class.java)
//        toastIntent.action = Constants.TOAST_ACTION
//        toastIntent.putExtra("appWidgetId", appWidgetId)
////             toastIntent.putExtra("currencyCode", baseCurrency)
//        toastIntent.data = Uri.parse(toastIntent.toUri(Intent.URI_INTENT_SCHEME))
//
//
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S){
//            views.setPendingIntentTemplate(
//                R.id.listCurrency,
//                PendingIntent.getBroadcast(
//                    context,
//                    0,
//                    toastIntent,
//                    PendingIntent.FLAG_MUTABLE
//                )
//            )
//        }else{
//            views.setPendingIntentTemplate(
//                R.id.listCurrency,
//                PendingIntent.getBroadcast(
//                    context,
//                    0,
//                    toastIntent,
//                    PendingIntent.FLAG_UPDATE_CURRENT
//                )
//            )
//        }

        return view
    }

    override fun getCount(): Int {
        Log.e(javaClass.simpleName, "getCount->${codeList.size}")
        return codeList.size
    }

    override fun getViewTypeCount(): Int {
        return 1
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun hasStableIds(): Boolean {
        return true
    }

    private fun initData() {
        codeList.clear()
        diffrence.clear()
        exchangeRate.clear()


        val flagArray = context.resources.obtainTypedArray(R.array.country_flag)
        val intent = mIntent
        var num: Int? = null

        val stringExtra = intent.getStringExtra("baseCurrency")
        Log.e(javaClass.simpleName, "stringExtra->$stringExtra")
        Intrinsics.checkNotNull(stringExtra)
        baseCurrency = stringExtra

        val valueOf = java.lang.Double.valueOf(
            intent.getDoubleExtra(
                "amount",
                1.0
            )
        )
        Intrinsics.checkNotNull(valueOf)
        amount = BigDecimal(valueOf.toDouble())
        Log.e(javaClass.simpleName, "valueOf->$valueOf")


//        num = Integer.valueOf(intent.getIntExtra("visualSize", 1))
//        Intrinsics.checkNotNull(num)
//        visualSize = num!!.toInt()


        var jsonString = intent.getStringExtra("jsonItems")
        Log.e(javaClass.simpleName, "jsonString->$jsonString")

        if (jsonString!!.isNotEmpty()) {
            val json = JSONArray(jsonString)
            Log.e(javaClass.simpleName, "json->$json")


            for (index in 0 until json.length()) {
                val obj = json.getJSONObject(index)!!
                codeList.add(obj.getString("code"))
                exchangeRate.add(obj.getString("todayRate"))
                diffrence.add(obj.getString("diff"))
                val i = obj.getInt("flagIndex")
                flag.add(flagArray.getDrawable(i)!!)
            }


        }



        Log.e(javaClass.simpleName, "codeList->$codeList")
        Log.e(javaClass.simpleName, "exchangeRate->$exchangeRate")
        Log.e(javaClass.simpleName, "diffrence->$diffrence")

         widgetId = intent.getIntExtra("appWidgetId", 100)

        visualSize = Utility.loadVisual(context, widgetId)
        Log.e(javaClass.simpleName, "visualSize->$visualSize")
        Log.e(javaClass.simpleName, "widgetId->$widgetId")


    }


}