package com.example.currency_converter.widget_service

import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.util.Log
import android.widget.RemoteViews
import android.widget.RemoteViewsService
import com.example.currency_converter.R
import com.example.currency_converter.utils.Utility
import com.example.currency_converter.widget.SingleConvertorProvider
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
//        initData()
    }

    override fun onDestroy() {}

    /* JADX WARNING: Removed duplicated region for block: B:32:0x01c6  */ /* JADX WARNING: Removed duplicated region for block: B:33:0x01dc  */ /* Code decompiled incorrectly, please refer to instructions dump. */
    override fun getViewAt(position: Int): RemoteViews {
        Log.e(javaClass.simpleName, "getViewAt->$position")
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
        view.setTextViewText(
            R.id.txtRate,
            "%.2f".format(exchangeRate[position].toDouble())
        )

        val d: Double = diffrence[position].toDouble();
        if (d < 0) {
            view.setTextViewText(
                R.id.txtPercent, "" + "%.4f".format(d )
            )
        } else {
            view.setTextViewText(
                R.id.txtPercent, "+" + "%.4f".format(d )
            )
        }

        view.setTextColor(R.id.txtRate, context.resources.getColor(R.color.white))
        view.setTextColor(R.id.txt_code, context.resources.getColor(R.color.white))
        view.setTextColor(R.id.txtPercent, context.resources.getColor(R.color.white))

        when (visualSize) {
            1 -> {
                view.setTextViewTextSize(
                    R.id.txt_code,
                    0,
                    context.resources.getDimension(R.dimen._16sdp)
                )
                view.setTextViewTextSize(
                    R.id.txtRate,
                    0,
                    context.resources.getDimension(R.dimen._13sdp)
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
                    context.resources.getDimension(R.dimen._17sdp)
                )
                view.setTextViewTextSize(
                    R.id.txtRate,
                    0,
                    context.resources.getDimension(R.dimen._14sdp)
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
                    context.resources.getDimension(R.dimen._18sdp)
                )
                view.setTextViewTextSize(
                    R.id.txtRate,
                    0,
                    context.resources.getDimension(R.dimen._15sdp)
                )
                view.setTextViewTextSize(
                    R.id.txtPercent,
                    0,
                    context.resources.getDimension(R.dimen._12sdp)
                )
            }

        }
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
        val intent = mIntent
        var num: Int? = null

        val stringExtra = if (intent != null) intent.getStringExtra("baseCurrency") else "USD"
        Log.e(javaClass.simpleName, "stringExtra->$stringExtra")
        Intrinsics.checkNotNull(stringExtra)
        baseCurrency = stringExtra

        val valueOf = if (intent != null) java.lang.Double.valueOf(
            intent.getDoubleExtra(
                "amount",
                1.0
            )
        ) else 1.0
        Intrinsics.checkNotNull(valueOf)
        amount = BigDecimal(valueOf!!.toDouble())
        Log.e(javaClass.simpleName, "valueOf->$valueOf")


        if (intent != null) {
            num = Integer.valueOf(intent.getIntExtra("visualSize", 1))
        }
        Intrinsics.checkNotNull(num)
        visualSize = num!!.toInt()
        Log.e(javaClass.simpleName, "visualSize->$visualSize")


        codeList = intent.getStringArrayListExtra("codeList")!!
        exchangeRate = intent.getStringArrayListExtra("rateList")!!
        diffrence = intent.getStringArrayListExtra("diffList")!!

        Log.e(javaClass.simpleName, "codeList->$codeList")
        Log.e(javaClass.simpleName, "exchangeRate->$exchangeRate")
        Log.e(javaClass.simpleName, "diffrence->$diffrence")

        val widgetId = intent.getIntExtra("appWidgetId", 100)!!
        Log.e(javaClass.simpleName, "widgetId->$widgetId")

        val flagArray = context.resources.obtainTypedArray(R.array.country_flag)
        val codeArray = context.resources.getStringArray(R.array.currency_code)

        codeList.forEach {
            val i = codeArray.indexOf(it.uppercase())
            flag.add(flagArray.getDrawable(i)!!)
        }


    }


}