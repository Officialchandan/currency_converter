package com.example.currency_converter

import android.annotation.SuppressLint
import android.app.Activity
import android.appwidget.AppWidgetManager
import android.content.ContentValues
import android.content.Context
import android.content.Intent
import android.content.res.TypedArray
import android.database.sqlite.SQLiteDatabase
import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.os.Build
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.util.Log
import android.view.View
import android.view.WindowManager
import android.widget.SeekBar
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.currency_converter.activity.MyApplication
import com.example.currency_converter.activity.SelectCurrencyActivity
import com.example.currency_converter.adapter.CurrencyCodeAdapter
import com.example.currency_converter.ads.AppOpenManager
import com.example.currency_converter.api.ApiClient
import com.example.currency_converter.databinding.ActivityListWidgetConfigBinding
import com.example.currency_converter.interfaces.ItemClickListener
import com.example.currency_converter.model.Country
import com.example.currency_converter.utils.Constants
import com.example.currency_converter.utils.Utility
import com.example.currency_converter.utils.Utility.Companion.getColorWithAlpha
import com.example.currency_converter.widget.ListWidgetKt
import com.google.gson.JsonObject
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
import io.reactivex.schedulers.Schedulers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import org.json.JSONArray
import org.json.JSONObject
import retrofit2.Response

class ListWidgetConfigActivity : AppCompatActivity(), ItemClickListener {

    lateinit var binding: ActivityListWidgetConfigBinding
    var appWidgetId = 0
    var showCurrencyPicker = false
    var currencyList = ArrayList<Country>()
    var adapter : CurrencyCodeAdapter?=null
    lateinit var currencyCode: Array<String>
    lateinit var currencyName: Array<String>
    lateinit var currencyFlag: TypedArray

    override fun onCreate(savedInstanceState: Bundle?) {
        Utility.setAppLanguage(this)
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.activity_list_widget_config)
        appWidgetId = intent?.extras?.getInt(
            AppWidgetManager.EXTRA_APPWIDGET_ID,
            AppWidgetManager.INVALID_APPWIDGET_ID
        ) ?: AppWidgetManager.INVALID_APPWIDGET_ID


        Log.e(javaClass.name, "appWidgetId-->$appWidgetId")

        initView(appWidgetId)

        binding.btnNext.setOnClickListener(View.OnClickListener {

            if (binding.tvBaseCurrency.text.trim().isEmpty()) {
                Toast.makeText(this, "Please enter base amount", Toast.LENGTH_SHORT)
                return@OnClickListener
            }
            Utility.saveAmount(this, binding.editAmount.text!!.trim().toString(), appWidgetId)
            Utility.saveBaseCurrency(this, binding.tvBaseCurrency.text!!.trim().toString(), appWidgetId)


            val intent = Intent(this, SelectCurrencyActivity::class.java)
            intent.putExtra("appWidgetId", appWidgetId)
            intent.putExtra("baseCurrency", binding.tvBaseCurrency.text)
            intent.putExtra("baseAmount", binding.editAmount.text)

            startActivityForResult(intent, 101)

        })

        if (!Utility.isSubscriptionPurchased(this)) {

            var appOpenAdManager: AppOpenManager?=null

            val application = application as? MyApplication
            if (application?.appOpenAdManager != null) {
                Log.e(javaClass.name, "appOpenAdManager---")
                application.appOpenAdManager?.onActivityResumed(this)
                application.appOpenAdManager?.showAdIfAvailable()
            }
        }

        accessDB(this);

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == 101 && resultCode == Activity.RESULT_OK) {

            Log.e(javaClass.simpleName, "onActivityResult-->${data!!.extras!!.get("data")}")
            var json = data.extras!!.get("data")


            if (data.toString().isNotEmpty()) {
                val appWidgetManager = AppWidgetManager.getInstance(this)
                getRate(
                    this, JSONArray(json.toString()), binding.tvBaseCurrency.text.toString().trim(), binding.editAmount.text.toString().toDouble(),
                    appWidgetId, appWidgetManager
                )
            }


        }


    }

    override fun onBackPressed() {
        super.onBackPressed()
        setResult(Activity.RESULT_CANCELED)
    }


    private fun initView(appWidgetId: Int) {

        binding.imgArrow.visibility = View.GONE
        binding.layoutCurrencyList.visibility = View.GONE

        currencyCode = this.resources.getStringArray(R.array.currency_code)
        currencyName = this.resources.getStringArray(R.array.currency_name)
        currencyFlag = this.resources.obtainTypedArray(R.array.country_flag)

        val colorCode = Utility.getWidgetColor(this)
        val color: Int = Color.parseColor("#$colorCode")
        window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
        window.statusBarColor = color
        val colorTran = Utility.getColorWithAlpha(color, 1f)
        var gd = Utility.getWidgetGradientDrawable(colorTran, 0, 0, 0f);
        binding.containerView.background = gd
        binding.appBar.setBackgroundColor(color)
        binding.toolbar.setBackgroundColor(color)

        var baseCurrency = Utility.loadBaseCurrency(this, appWidgetId)
        if (baseCurrency.isEmpty()) {
            baseCurrency = "USD"
        }
        binding.tvBaseCurrency.text = baseCurrency
        val i = currencyCode.indexOf(baseCurrency)

        val flag = currencyFlag.getDrawable(i)
        binding.imgFlag.setImageDrawable(flag)


        var baseAmount: String = Utility.loadAmount(this, appWidgetId)
        if (baseAmount.isEmpty()) {
            baseAmount = "1"
        }
        binding.editAmount.setText(baseAmount)

        var fontSize = Utility.loadVisual(this, appWidgetId)
        if (fontSize == 0) {
            fontSize = 1;
            Utility.saveVisual(this, fontSize, appWidgetId)
        } else {
            setTextViewFontSize(fontSize)
        }

        val trans = Utility.getWidgetTransparency(this)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            binding.seekBarWidgetOpacity.setProgress(trans, true)
        } else {
            binding.seekBarWidgetOpacity.progress = trans
        }
        setupWidgetTransparency(trans, color);
        setupRadio(this, appWidgetId)
        setupSeekbar(this, color)
//        setupCurrencyAdapter(this)

        binding.layoutBaseCurrency.setOnClickListener(View.OnClickListener {


            if (showCurrencyPicker) {
                showCurrencyPicker = false
                binding.layoutCurrencyList.visibility = View.GONE
                binding.imgArrow.visibility = View.GONE

            } else {
                showCurrencyPicker = true
                binding.layoutCurrencyList.visibility = View.VISIBLE
                binding.imgArrow.visibility = View.VISIBLE
            }

        })


        val textColor: Int = if (Utility.isDarkTheme(this)) {
            binding.tvBaseCurrency.setTextColor(this.resources.getColor(R.color.textLight))
            binding.txtUSD.background = this.resources.getDrawable(R.drawable.bg_bottom_dark)
            binding.editAmount.setTextColor(this.resources.getColor(R.color.textLight))
            binding.editAmount.setBackgroundResource(R.drawable.dartk_round)
            binding.layoutBaseCurrency.setBackgroundResource(R.drawable.dartk_round)
            binding.btnNext.setBackgroundResource(R.drawable.dartk_round)
            binding.widgetContainer.setBackgroundResource(R.drawable.currency_widget_background_dark)
            binding.seekBarWidgetOpacity.thumb = getDrawable(R.drawable.slider_thumb_dark)
            binding.radioLarge.setButtonDrawable(R.drawable.radio_button_dark)
            binding.radioMedium.setButtonDrawable(R.drawable.radio_button_dark)
            binding.radioSmall.setButtonDrawable(R.drawable.radio_button_dark)
            binding.seekBarWidgetOpacity.progressDrawable = getDrawable(R.drawable.custom_slider_dark)
            this.resources.getColor(R.color.textDark)

        } else {
            binding.txtUSD.background = this.resources.getDrawable(R.drawable.bg_bottom_light)
            binding.tvBaseCurrency.setTextColor(this.resources.getColor(R.color.textDark))
            binding.editAmount.setTextColor(this.resources.getColor(R.color.textDark))
            binding.editAmount.setBackgroundResource(R.drawable.white_round)
            binding.layoutBaseCurrency.setBackgroundResource(R.drawable.white_round)
            binding.btnNext.setBackgroundResource(R.drawable.white_round)
            binding.widgetContainer.setBackgroundResource(R.drawable.currency_widget_background)
            binding.seekBarWidgetOpacity.thumb = getDrawable(R.drawable.slider_thumb)
            binding.seekBarWidgetOpacity.progressDrawable = getDrawable(R.drawable.custom_slider)
            binding.radioLarge.setButtonDrawable(R.drawable.radio_button_light)
            binding.radioMedium.setButtonDrawable(R.drawable.radio_button_light)
            binding.radioSmall.setButtonDrawable(R.drawable.radio_button_light)
            this.resources.getColor(R.color.textLight)
        }
        binding.btnNext.setTextColor(color)

        binding.txtTitleBaseCurrency.setTextColor(textColor)
        binding.txtTitleAmount.setTextColor(textColor)
        binding.textSize.setTextColor(textColor)
        binding.textTransparency.setTextColor(textColor)
        binding.txtWidgetOpacity.setTextColor(textColor)
        binding.txtEUR.setTextColor(textColor)
        binding.txtGbp.setTextColor(textColor)
        binding.txtCad.setTextColor(textColor)
        binding.txtBtc.setTextColor(textColor)
        binding.txtUSD.setTextColor(textColor)
        binding.txtExchange.setTextColor(textColor)
        binding.txtExchange1.setTextColor(textColor)
        binding.txtExchange2.setTextColor(textColor)
        binding.txtExchange3.setTextColor(textColor)
        binding.txtRateExchange.setTextColor(textColor)
        binding.txtRateExchange1.setTextColor(textColor)
        binding.txtRateExchange2.setTextColor(textColor)
        binding.txtRateExchange3.setTextColor(textColor)
        binding.txtBy.setTextColor(textColor)
        binding.radioSmall.setTextColor(textColor)
        binding.radioMedium.setTextColor(textColor)
        binding.radioLarge.setTextColor(textColor)


    }

    private fun setupCurrencyAdapter(context: Context) {

//        val fabList = ArrayList<Country>()
//        val list = ArrayList<Country>()
//
//        for (index in currencyCode.indices) {
//            if (currencyCode[index] == "USD" ||
//                currencyCode[index] == "BTC" ||
//                currencyCode[index] == "CAD" ||
//                currencyCode[index] == "EUR" ||
//                currencyCode[index] == "GBP" ||
//                currencyCode[index] == "MXN" ||
//                currencyCode[index] == "INR"
//            ) {
//                fabList.add(Country(currencyFlag.getDrawable(index)!!, currencyCode[index], currencyName[index], "", 1, 0))
//            } else {
//                list.add(Country(currencyFlag.getDrawable(index)!!, currencyCode[index], currencyName[index], "", 0, 0))
//            }
//        }
//
//        currencyList.addAll(fabList)
//        currencyList.addAll(list)

        binding.rvCurrency.layoutManager = LinearLayoutManager(this)
         adapter = CurrencyCodeAdapter(currencyList, 1, this, this)
        binding.rvCurrency.adapter = adapter

        val divider = DividerItemDecoration(
            binding.rvCurrency.context,
            DividerItemDecoration.VERTICAL
        )


        if (Utility.isDarkTheme(this)) {
            getDrawable(R.drawable.line_divider_dark)?.let {
                divider.setDrawable(
                    it
                )
            }
        } else {
            getDrawable(R.drawable.line_divider)?.let {
                divider.setDrawable(
                    it
                )
            }
        }

        binding.rvCurrency.addItemDecoration(divider);

        binding.edtSearch.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
                Log.e(javaClass.name, "beforeTextChanged" + p0.toString())
                print(p0)
            }

            override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
                Log.e(javaClass.name, "onTextChanged" + p0.toString())
//                adapter.filter.filter(p0.toString())
//                adapter.notifyDataSetChanged()
            }

            override fun afterTextChanged(p0: Editable?) {
                Log.e(javaClass.name, "afterTextChanged" + p0.toString())
                adapter!!.filter.filter(p0.toString())
                adapter!!.notifyDataSetChanged()

            }

        })

        binding.imgClear.setOnClickListener(View.OnClickListener {

            binding.edtSearch.setText("")

        })


    }


    fun setupSeekbar(context: Context, color: Int) {
        binding.seekBarWidgetOpacity.setOnSeekBarChangeListener(object :
            SeekBar.OnSeekBarChangeListener {
            override fun onProgressChanged(p0: SeekBar?, p1: Int, p2: Boolean) {
                Utility.saveWidgetTransparency(context, p0!!.progress)
                setupWidgetTransparency(p0.progress, color)
                Log.e(javaClass.simpleName, "progress-->${p0.progress}")
            }

            override fun onStartTrackingTouch(p0: SeekBar?) {
                Log.e(javaClass.simpleName, "progress-->${p0!!.progress}")
            }

            override fun onStopTrackingTouch(p0: SeekBar?) {
                Log.e(javaClass.simpleName, "progress-->${p0!!.progress}")
            }

        })
    }

    private fun setTextViewFontSize(fontSize: Int) {
        when (fontSize) {

            1 -> {
                binding.radioLarge.isChecked = false
                binding.radioMedium.isChecked = false
                binding.radioSmall.isChecked = true
                Utility.setTextViewSize(
                    binding.txtUSD,
                    this.resources.getDimension(R.dimen._14sdp)
                )
                Utility.setTextViewSize(
                    binding.txtEUR,
                    this.resources.getDimension(R.dimen._13sdp)
                )
                Utility.setTextViewSize(
                    binding.txtGbp,
                    this.resources.getDimension(R.dimen._13sdp)
                )
                Utility.setTextViewSize(
                    binding.txtCad,
                    this.resources.getDimension(R.dimen._13sdp)
                )
                Utility.setTextViewSize(
                    binding.txtBtc,
                    this.resources.getDimension(R.dimen._13sdp)
                )
                Utility.setTextViewSize(
                    binding.txtExchange,
                    this.resources.getDimension(R.dimen._12sdp)
                )
                Utility.setTextViewSize(
                    binding.txtExchange1,
                    this.resources.getDimension(R.dimen._12sdp)
                )
                Utility.setTextViewSize(
                    binding.txtExchange2,
                    this.resources.getDimension(R.dimen._12sdp)
                )
                Utility.setTextViewSize(
                    binding.txtExchange3,
                    this.resources.getDimension(R.dimen._12sdp)
                )
                Utility.setTextViewSize(
                    binding.txtRateExchange,
                    this.resources.getDimension(R.dimen._8sdp)
                )
                Utility.setTextViewSize(
                    binding.txtRateExchange1,
                    this.resources.getDimension(R.dimen._8sdp)
                )
                Utility.setTextViewSize(
                    binding.txtRateExchange2,
                    this.resources.getDimension(R.dimen._8sdp)
                )
                Utility.setTextViewSize(
                    binding.txtRateExchange3,
                    this.resources.getDimension(R.dimen._8sdp)
                )
                Utility.setTextViewSize(
                    binding.txtBy,
                    this.resources.getDimension(R.dimen._10sdp)
                )


            }
            2 -> {
                binding.radioLarge.isChecked = false
                binding.radioSmall.isChecked = false
                binding.radioMedium.isChecked = true
                Utility.setTextViewSize(
                    binding.txtUSD,
                    this.resources.getDimension(R.dimen._15sdp)
                )
                Utility.setTextViewSize(
                    binding.txtEUR,
                    this.resources.getDimension(R.dimen._14sdp)
                )
                Utility.setTextViewSize(
                    binding.txtGbp,
                    this.resources.getDimension(R.dimen._14sdp)
                )
                Utility.setTextViewSize(
                    binding.txtCad,
                    this.resources.getDimension(R.dimen._14sdp)
                )
                Utility.setTextViewSize(
                    binding.txtBtc,
                    this.resources.getDimension(R.dimen._14sdp)
                )
                Utility.setTextViewSize(
                    binding.txtExchange,
                    this.resources.getDimension(R.dimen._13sdp)
                )
                Utility.setTextViewSize(
                    binding.txtExchange1,
                    this.resources.getDimension(R.dimen._13sdp)
                )
                Utility.setTextViewSize(
                    binding.txtExchange2,
                    this.resources.getDimension(R.dimen._13sdp)
                )
                Utility.setTextViewSize(
                    binding.txtExchange3,
                    this.resources.getDimension(R.dimen._13sdp)
                )
                Utility.setTextViewSize(
                    binding.txtRateExchange,
                    this.resources.getDimension(R.dimen._9sdp)
                )
                Utility.setTextViewSize(
                    binding.txtRateExchange1,
                    this.resources.getDimension(R.dimen._9sdp)
                )
                Utility.setTextViewSize(
                    binding.txtRateExchange2,
                    this.resources.getDimension(R.dimen._9sdp)
                )
                Utility.setTextViewSize(
                    binding.txtRateExchange3,
                    this.resources.getDimension(R.dimen._9sdp)
                )
                Utility.setTextViewSize(
                    binding.txtBy,
                    this.resources.getDimension(R.dimen._11sdp)
                )
            }
            3 -> {
                binding.radioLarge.isChecked = true
                binding.radioMedium.isChecked = false
                binding.radioSmall.isChecked = false
                Utility.setTextViewSize(
                    binding.txtUSD,
                    this.resources.getDimension(R.dimen._16sdp)
                )
                Utility.setTextViewSize(
                    binding.txtEUR,
                    this.resources.getDimension(R.dimen._15sdp)
                )
                Utility.setTextViewSize(
                    binding.txtGbp,
                    this.resources.getDimension(R.dimen._15sdp)
                )
                Utility.setTextViewSize(
                    binding.txtCad,
                    this.resources.getDimension(R.dimen._15sdp)
                )
                Utility.setTextViewSize(
                    binding.txtBtc,
                    this.resources.getDimension(R.dimen._15sdp)
                )
                Utility.setTextViewSize(
                    binding.txtExchange,
                    this.resources.getDimension(R.dimen._14sdp)
                )
                Utility.setTextViewSize(
                    binding.txtExchange1,
                    this.resources.getDimension(R.dimen._14sdp)
                )
                Utility.setTextViewSize(
                    binding.txtExchange2,
                    this.resources.getDimension(R.dimen._14sdp)
                )
                Utility.setTextViewSize(
                    binding.txtExchange3,
                    this.resources.getDimension(R.dimen._14sdp)
                )
                Utility.setTextViewSize(
                    binding.txtRateExchange,
                    this.resources.getDimension(R.dimen._10sdp)
                )
                Utility.setTextViewSize(
                    binding.txtRateExchange1,
                    this.resources.getDimension(R.dimen._10sdp)
                )
                Utility.setTextViewSize(
                    binding.txtRateExchange2,
                    this.resources.getDimension(R.dimen._10sdp)
                )
                Utility.setTextViewSize(
                    binding.txtRateExchange3,
                    this.resources.getDimension(R.dimen._10sdp)
                )
                Utility.setTextViewSize(
                    binding.txtBy,
                    this.resources.getDimension(R.dimen._12sdp)
                )
            }


        }
    }

    private fun setupRadio(context: Context, appWidgetId: Int) {

        binding.radioSmall.setOnCheckedChangeListener { compoundButton, check ->
            if (check) {
                Utility.saveVisual(context, 1, appWidgetId)
                setTextViewFontSize(1)
            }
        }
        binding.radioMedium.setOnCheckedChangeListener { compoundButton, check ->
            if (check) {
                Utility.saveVisual(context, 2, appWidgetId)
                setTextViewFontSize(2)
            }
        }
        binding.radioLarge.setOnCheckedChangeListener { compoundButton, check ->
            if (check) {
                Utility.saveVisual(context, 3, appWidgetId)
                setTextViewFontSize(3)
            }
        }


    }

    private fun setupWidgetTransparency(trans: Int, color: Int) {
        var transparancy: Float = 1f - (trans.toFloat() / 100)
        val startColor = getColorWithAlpha(color, 0.8f)
        val endColor = getColorWithAlpha(color, 1f)

        val gradientDrawable = GradientDrawable(
            GradientDrawable.Orientation.TOP_BOTTOM,
            intArrayOf(
                getColorWithAlpha(startColor, transparancy),
                getColorWithAlpha(endColor, transparancy)
            )
        )

        gradientDrawable.cornerRadius = 16.0f
        binding.widgetPreview.background = gradientDrawable
        binding.txtWidgetOpacity.text = trans.toString()
    }

    override fun onItemSelect(country: Country, type: Int) {
        showCurrencyPicker = false
        binding.layoutCurrencyList.visibility = View.GONE
        binding.imgArrow.visibility = View.GONE
        binding.tvBaseCurrency.text = country.code
        binding.imgFlag.setImageDrawable(country.flag)

        Utility.saveBaseCurrency(this, country.code, appWidgetId)


    }

    override fun onItemFavorite(country: Country, position: Int, fav: Int) {
//        currencyList[position].favorite = fav
//        currencyList.sortBy { it.code }
//        currencyList.sortByDescending { it.favorite }

        adapter!!.currencyList[position].favorite = fav
        adapter!!.currencyList.sortBy { it.code }
        adapter!!.currencyList.sortByDescending { it.favorite }

        updateFavorite( adapter!!.currencyList[position])

        adapter!!.notifyDataSetChanged()
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
                                val per = (diff * 100) / todayRate

                                val i = codeList.indexOf(to)

                                var jsonObj = JSONObject()
                                jsonObj.put("code", to);
                                jsonObj.put("name", nameList[i]!!)
                                jsonObj.put("todayRate", todayRate.toString())
                                jsonObj.put("diff", diff.toString())
                                jsonObj.put("flagIndex", i)

                                jsonArray.put(jsonObj)

                            }


                            Utility.saveListWidgetData(this, jsonArray.toString(), appWidgetId)

                            ListWidgetKt.updateAppWidget(this, appWidgetManager, appWidgetId, false)

                            val resultValue =
                                Intent().putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId)
                            setResult(Activity.RESULT_OK, resultValue)
                            finish()

                        }
                    }

                }
            }, { error ->
                Log.e(javaClass.simpleName, "error-->$error")

            })


    }

    fun accessDB(context: Context) {

        try {
            GlobalScope.launch {
                var db: SQLiteDatabase = SQLiteDatabase.openDatabase(
                    Constants.DB_PATH, null,
                    SQLiteDatabase
                        .OPEN_READWRITE
                );

                Log.d(javaClass.name, "Database Path " + db.path.toString())
                Log.d("", "Database version " + db.version.toString())

//                val query = "SELECT * FROM conversion ORDER BY favCountry DESC"

                val cursor = db.query("conversion", null, null, null, null, null, "favCountry DESC")

                cursor?.let {
                    while (cursor.moveToNext()) {

                        var columnNames = cursor.columnNames

                        val i = cursor.getColumnIndex("countryCode")
                        val favIndex = cursor.getColumnIndex("favCountry")

                        val index = currencyCode.indexOf(cursor.getString(i))

                        if(index>-1){
                            if (cursor.getString(favIndex) == "1") {
                                currencyList.add(Country(currencyFlag.getDrawable(index)!!, currencyCode[index], currencyName[index], "", 1, 0))
                            } else {
                                currencyList.add(Country(currencyFlag.getDrawable(index)!!, currencyCode[index], currencyName[index], "", 0, 0))
                            }
                        }



                        Log.e(
                            javaClass.name,
                            columnNames.toString()
                        )




                        columnNames.forEach {

                            val i = cursor.getColumnIndex(it)

//                            val index = currencyCode.indexOf(cursor.getString())
//                            currencyList.add(Country(currencyFlag.getDrawable(index)!!, currencyCode[index], currencyName[index], "", 1, 0))

                            Log.e(
                                MainActivity::class.java.name,
                                "$it " + cursor.getString(i)
                            )

                        }

                    }
                }

                if(currencyList.isNotEmpty()){
                    setupCurrencyAdapter(context)
                }


            }

        } catch (e: Exception) {
            e.printStackTrace();
        }
    }

    fun updateFavorite(country: Country) {
        try {
            GlobalScope.launch {
                val db: SQLiteDatabase = SQLiteDatabase.openDatabase(
                    Constants.DB_PATH, null,
                    SQLiteDatabase
                        .OPEN_READWRITE
                );

                val query = "UPDATE conversion SET favCountry = ${country.favorite} WHERE countryCode = '${country.code}'";



                val contentValue  = ContentValues()
                contentValue.put("favCountry",country.favorite)
                contentValue.put("countryCode",country.code)


                val v= db.execSQL(query);
//                val i = db.update("conversion",contentValue,"countryCode = ${country.code}",  null  )

                Log.e(javaClass.name, "update-> " + v.toString())



            }

        } catch (e: Exception) {
            e.printStackTrace();
        }
    }



}