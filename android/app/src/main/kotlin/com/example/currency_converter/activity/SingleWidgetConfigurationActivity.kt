package com.example.currency_converter.activity

import android.app.Activity
import android.appwidget.AppWidgetManager
import android.content.ContentValues
import android.content.Context
import android.content.Intent
import android.content.res.TypedArray
import android.database.sqlite.SQLiteDatabase
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.util.Log
import android.view.View
import android.view.WindowManager
import android.widget.ImageView
import android.widget.SeekBar
import android.widget.SeekBar.OnSeekBarChangeListener
import android.widget.Toast
import androidx.core.database.sqlite.transaction
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.currency_converter.MainActivity
import com.example.currency_converter.R
import com.example.currency_converter.adapter.CurrencyCodeAdapter
import com.example.currency_converter.ads.AppOpenManager
import com.example.currency_converter.api.ApiClient
import com.example.currency_converter.databinding.SingleConvertorConfigActivityBinding
import com.example.currency_converter.interfaces.ItemClickListener
import com.example.currency_converter.model.Country
import com.example.currency_converter.utils.Constants
import com.example.currency_converter.utils.Utility
import com.example.currency_converter.widget.SingleConvertorProvider
import com.google.gson.JsonObject
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import retrofit2.Response


class SingleWidgetConfigurationActivity : Activity(), ItemClickListener {

    lateinit var binding: SingleConvertorConfigActivityBinding
    lateinit var appOpenAdManager: AppOpenManager
    var appWidgetId = 0
    var showCurrencyList2: Boolean = false
    var showCurrencyList1: Boolean = false
    var countryList = ArrayList<Country>()
    var adapter: CurrencyCodeAdapter? = null

    lateinit var currencyCode: Array<String>
    lateinit var currencyName: Array<String>
    lateinit var currencyFlag: TypedArray

    override fun onCreate(savedInstanceState: Bundle?) {
        Utility.setAppLanguage(this)
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.single_convertor_config_activity)

        currencyCode = this.resources.getStringArray(R.array.currency_code)
        currencyName = this.resources.getStringArray(R.array.currency_name)
        currencyFlag = this.resources.obtainTypedArray(R.array.country_flag)

        appWidgetId = intent?.extras?.getInt(
            AppWidgetManager.EXTRA_APPWIDGET_ID,
            AppWidgetManager.INVALID_APPWIDGET_ID
        ) ?: AppWidgetManager.INVALID_APPWIDGET_ID

        Log.e(javaClass.name, "appWidgetId-->$appWidgetId")
//        Utility.setAppLanguage(this)
        getCurrencyList()

        init()

        binding.tvAddWidget.setOnClickListener {
            if (binding.tvCurrencyCodeFrom.text.toString().isEmpty() || binding.tvCurrencyCodeTo.text.toString().isEmpty()) {
                Toast.makeText(this, "Both the field is required", Toast.LENGTH_LONG).show()
            } else {
                val from: String = binding.tvCurrencyCodeFrom.text.toString()
                val to: String = binding.tvCurrencyCodeTo.text.toString()
                Utility.setCurrencyCode1(this, from, appWidgetId)
                Utility.setCurrencyCode2(this, to, appWidgetId)

                val appWidgetManager = AppWidgetManager.getInstance(this)
                getConvertRate(from, to, this, appWidgetManager, widgetId = appWidgetId)
            }
        }

        if (!Utility.isSubscriptionPurchased(this)) {
            Log.e(javaClass.name, "isSubscriptionPurchased")
            val application = application as? MyApplication

            if (application?.appOpenAdManager != null) {
                Log.e(javaClass.name, "appOpenAdManager---")
                application.appOpenAdManager?.showAdIfAvailable()
            }
        }

    }

    private fun init() {


        binding.arrowLayout.visibility = View.GONE
        binding.layoutCountries.visibility = View.GONE
        binding.layoutWidgetTransparency.visibility = View.VISIBLE
        binding.tvWidgetTransparency.visibility = View.VISIBLE
        binding.layoutVisualSize.visibility = View.VISIBLE
        binding.tvVisualSize.visibility = View.VISIBLE
        binding.tvSliderValue.text = "0";


        val widgetColor = Utility.getWidgetColor(context = this)
        val color: Int = Color.parseColor("#$widgetColor")

        window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
        window.statusBarColor = color



        binding.appBar.setBackgroundColor(getColorWithAlpha(color, 0.8f))
        binding.appBar.setStatusBarForegroundColor(getColorWithAlpha(color, 0.8f))
        binding.toolbar.setBackgroundColor(color)

        binding.parentLayout.background = SingleConvertorProvider.getWidgetGradientDrawable(color, 0, 0, this.resources.getDimension(R.dimen._0sdp))

        val from: String = Utility.getCurrencyCode1(this, appWidgetId)
        val to: String = Utility.getCurrencyCode2(this, appWidgetId)

        val index: Int = currencyCode.indexOf(from)
        val index1: Int = currencyCode.indexOf(to)

        val imgFrom = currencyFlag.getDrawable(index)
        val imgTo = currencyFlag.getDrawable(index1)

        binding.flagImgFrom.setImageDrawable(imgFrom)
        binding.flagImgTo.setImageDrawable(imgTo)
        binding.tvCurrencyCodeFrom.text = from
        binding.tvCurrencyCodeTo.text = to
        binding.imgClear.setOnClickListener(View.OnClickListener {
            binding.edtSearch.text.clear()
        })

        val trans = Utility.getWidgetTransparency(this)
        setupWidgetTransparency(trans, color);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            binding.seekbar.setProgress(trans, true)
        } else {
            binding.seekbar.progress = trans
        }


        setSlider(color)
        setRadio()


        binding.layoutForm.setOnClickListener(View.OnClickListener {

            if (showCurrencyList1) {
                showCurrencyList1 = false
                binding.arrowLayout.visibility = View.GONE
                binding.layoutCountries.visibility = View.GONE
                binding.layoutWidgetTransparency.visibility = View.VISIBLE
                binding.tvWidgetTransparency.visibility = View.VISIBLE
                binding.layoutVisualSize.visibility = View.VISIBLE
                binding.tvVisualSize.visibility = View.VISIBLE
            } else {
                showCurrencyList1 = true
                showCurrencyList2 = false
                setAdapter(countryList, type = 1)
            }


        })

        binding.layoutTo.setOnClickListener(View.OnClickListener {

            if (showCurrencyList2) {
                showCurrencyList2 = false
                binding.arrowLayout.visibility = View.GONE
                binding.layoutCountries.visibility = View.GONE
                binding.layoutWidgetTransparency.visibility = View.VISIBLE
                binding.tvWidgetTransparency.visibility = View.VISIBLE
                binding.layoutVisualSize.visibility = View.VISIBLE
                binding.tvVisualSize.visibility = View.VISIBLE
            } else {
                showCurrencyList2 = true
                showCurrencyList1 = false
                setAdapter(countryList, 2)
            }

        })


        var fontSize = Utility.getIntegerPref(Constants.fontSize, this)

        if (fontSize == 0) {
            fontSize = 1;
            Utility.setIntegerPref(Constants.fontSize, 1, this)
        }

        when (fontSize) {
            1 -> {

                binding.radioSmall.isChecked = true
                binding.radioLarge.isChecked = false
                binding.radioMedium.isChecked = false
                Utility.setTextViewSize(
                    binding.tvFromWidget,
                    this.resources.getDimension(R.dimen._14sdp)
                )
                Utility.setTextViewSize(
                    binding.tvToWidget,
                    this.resources.getDimension(R.dimen._14sdp)
                )
                Utility.setTextViewSize(
                    binding.tvRateWidget,
                    this.resources.getDimension(R.dimen._16sdp)
                )
                Utility.setTextViewSize(
                    binding.tvDiffWidget,
                    this.resources.getDimension(R.dimen._13sdp)
                )
                Utility.setTextViewSize(
                    binding.currencyWiki,
                    this.resources.getDimension(R.dimen._10sdp)
                )


            }
            2 -> {
                binding.radioMedium.isChecked = true
                binding.radioLarge.isChecked = false
                binding.radioSmall.isChecked = false
                Utility.setTextViewSize(
                    binding.tvFromWidget,
                    this.resources.getDimension(R.dimen._15sdp)
                )
                Utility.setTextViewSize(
                    binding.tvToWidget,
                    this.resources.getDimension(R.dimen._15sdp)
                )
                Utility.setTextViewSize(
                    binding.tvRateWidget,
                    this.resources.getDimension(R.dimen._17sdp)
                )
                Utility.setTextViewSize(
                    binding.tvDiffWidget,
                    this.resources.getDimension(R.dimen._14sdp)
                )
                Utility.setTextViewSize(
                    binding.currencyWiki,
                    this.resources.getDimension(R.dimen._11sdp)
                )
            }
            3 -> {
                binding.radioLarge.isChecked = true
                binding.radioSmall.isChecked = false
                binding.radioMedium.isChecked = false
                Utility.setTextViewSize(
                    binding.tvFromWidget,
                    this.resources.getDimension(R.dimen._16sdp)
                )
                Utility.setTextViewSize(
                    binding.tvToWidget,
                    this.resources.getDimension(R.dimen._16sdp)
                )
                Utility.setTextViewSize(
                    binding.tvRateWidget,
                    this.resources.getDimension(R.dimen._18sdp)
                )
                Utility.setTextViewSize(
                    binding.tvDiffWidget,
                    this.resources.getDimension(R.dimen._15sdp)
                )
                Utility.setTextViewSize(
                    binding.currencyWiki,
                    this.resources.getDimension(R.dimen._12sdp)
                )
            }
        }

        val textColor: Int

        if (Utility.isDarkTheme(this)) {
            binding.layoutForm.setBackgroundResource(R.drawable.currency_widget_background_dark)
            binding.layoutTo.setBackgroundResource(R.drawable.currency_widget_background_dark)
            binding.widgetContainer.setBackgroundResource(R.drawable.currency_widget_background_dark)
            binding.seekbar.thumb = getDrawable(R.drawable.slider_thumb_dark)
            binding.seekbar.progressDrawable = getDrawable(R.drawable.custom_slider_dark)
            binding.radioSmall.setButtonDrawable(R.drawable.radio_button_dark)
            binding.radioLarge.setButtonDrawable(R.drawable.radio_button_dark)
            binding.radioMedium.setButtonDrawable(R.drawable.radio_button_dark)
            binding.tvCurrencyCodeFrom.setTextColor(this.resources.getColor(R.color.white))
            binding.tvCurrencyCodeTo.setTextColor(this.resources.getColor(R.color.white))
            textColor = this.resources.getColor(R.color.textDark)


        } else {
            binding.layoutForm.setBackgroundResource(R.drawable.currency_widget_background)
            binding.layoutTo.setBackgroundResource(R.drawable.currency_widget_background)
            binding.widgetContainer.setBackgroundResource(R.drawable.currency_widget_background)
            binding.seekbar.thumb = getDrawable(R.drawable.slider_thumb)
            binding.seekbar.progressDrawable = getDrawable(R.drawable.custom_slider)
            binding.radioSmall.setButtonDrawable(R.drawable.radio_button_light)
            binding.radioLarge.setButtonDrawable(R.drawable.radio_button_light)
            binding.radioMedium.setButtonDrawable(R.drawable.radio_button_light)
            binding.tvCurrencyCodeFrom.setTextColor(this.resources.getColor(R.color.black))
            binding.tvCurrencyCodeTo.setTextColor(this.resources.getColor(R.color.black))

            textColor = this.resources.getColor(R.color.textLight)

        }

        binding.tvAddWidget.setTextColor(textColor)
        binding.tvVisualSize.setTextColor(textColor)
        binding.tvWidgetTransparency.setTextColor(textColor)
        binding.tvSliderValue.setTextColor(textColor)
        binding.tvFromWidget.setTextColor(textColor)
        binding.tvToWidget.setTextColor(textColor)
        binding.tv1.setTextColor(textColor)
        binding.tvRateWidget.setTextColor(textColor)
        binding.tvDiffWidget.setTextColor(textColor)
        binding.currencyWiki.setTextColor(textColor)
        binding.radioLarge.setTextColor(textColor)
        binding.radioMedium.setTextColor(textColor)
        binding.radioSmall.setTextColor(textColor)


    }

    private fun setAdapter(countryList: ArrayList<Country>, type: Int) {

//        countryList.sortedBy { it.code }
//        countryList.sortedByDescending { it.favorite }

        binding.arrowLayout.visibility = View.VISIBLE
        binding.layoutCountries.visibility = View.VISIBLE
        binding.layoutWidgetTransparency.visibility = View.GONE
        binding.tvWidgetTransparency.visibility = View.GONE
        binding.layoutVisualSize.visibility = View.GONE
        binding.tvVisualSize.visibility = View.GONE


        if (type == 1) {
            binding.imgArrowFrom.visibility = View.VISIBLE
            binding.imgArrowTo.visibility = View.GONE
        }
        if (type == 2) {
            binding.imgArrowFrom.visibility = View.GONE
            binding.imgArrowTo.visibility = View.VISIBLE
        }



        binding.rvCurrency.layoutManager = LinearLayoutManager(this)
        adapter = CurrencyCodeAdapter(countryList, type, this, this)
        val divider = DividerItemDecoration(
            binding.rvCurrency.context,
            DividerItemDecoration.VERTICAL
        )


        getDrawable(R.drawable.line_divider)?.let {
            divider.setDrawable(
                it
            )
        }
        binding.rvCurrency.addItemDecoration(divider);

        binding.edtSearch.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
                Log.e(javaClass.name, "beforeTextChanged" + p0.toString())
                debugPrint(p0)
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
        binding.rvCurrency.adapter = adapter
        adapter!!.notifyDataSetChanged()


    }

    private fun getCurrencyList() {
        accessDB(this)
//        val codeArray = this.resources.getStringArray(R.array.currency_code)
//        val nameArray = this.resources.getStringArray(R.array.currency_name)
//        val flagArray = this.resources.obtainTypedArray(R.array.country_flag)
//
//        var fabList = ArrayList<Country>()
//        var list = ArrayList<Country>()
//
//
//        for (i in codeArray.indices) {
//
//            if (codeArray[i] == "USD" ||
//                codeArray[i] == "BTC" ||
//                codeArray[i] == "CAD" ||
//                codeArray[i] == "EUR" ||
//                codeArray[i] == "MXN" ||
//                codeArray[i] == "GBP" ||
//                codeArray[i] == "INR"
//            ) {
//                val country =
//                    Country(flagArray.getDrawable(i)!!, codeArray[i], nameArray[i], "0", favorite = 1, selected = 0)
//                fabList.add(country)
//            } else {
//                val country =
//                    Country(flagArray.getDrawable(i)!!, codeArray[i], nameArray[i], "0", favorite = 0, selected = 0)
//                list.add(country)
//            }
//        }
//
//        countryList.addAll(fabList)
//        countryList.addAll(list)

    }

    private fun setRadio() {

        binding.radioSmall.setOnCheckedChangeListener { compoundButton, check ->

            if (check) {
                binding.radioLarge.isChecked = false
                binding.radioMedium.isChecked = false
                binding.radioSmall.isChecked = true
                Utility.setIntegerPref(Constants.fontSize, 1, this)
                Utility.setTextViewSize(
                    binding.tvFromWidget,
                    this.resources.getDimension(R.dimen._14sdp)
                )
                Utility.setTextViewSize(
                    binding.tvToWidget,
                    this.resources.getDimension(R.dimen._14sdp)
                )
                Utility.setTextViewSize(
                    binding.tvRateWidget,
                    this.resources.getDimension(R.dimen._16sdp)
                )

                Utility.setTextViewSize(
                    binding.currencyWiki,
                    this.resources.getDimension(R.dimen._10sdp)
                )
                Utility.setTextViewSize(
                    binding.tvDiffWidget,
                    this.resources.getDimension(R.dimen._13sdp)
                )


            }

        }


        binding.radioMedium.setOnCheckedChangeListener { compoundButton, check ->
            if (check) {
                binding.radioLarge.isChecked = false
                binding.radioMedium.isChecked = true
                binding.radioSmall.isChecked = false
                Utility.setIntegerPref(Constants.fontSize, 2, this)
                Utility.setTextViewSize(
                    binding.tvFromWidget,
                    this.resources.getDimension(R.dimen._15sdp)
                )
                Utility.setTextViewSize(
                    binding.tvToWidget,
                    this.resources.getDimension(R.dimen._15sdp)
                )
                Utility.setTextViewSize(
                    binding.tvRateWidget,
                    this.resources.getDimension(R.dimen._17sdp)
                )
                Utility.setTextViewSize(
                    binding.tvDiffWidget,
                    this.resources.getDimension(R.dimen._14sdp)
                )
                Utility.setTextViewSize(
                    binding.currencyWiki,
                    this.resources.getDimension(R.dimen._11sdp)
                )
            }
        }

        binding.radioLarge.setOnCheckedChangeListener { compoundButton, check ->
            if (check) {
                binding.radioLarge.isChecked = true
                binding.radioMedium.isChecked = false
                binding.radioSmall.isChecked = false
                Utility.setIntegerPref(Constants.fontSize, 3, this)
                Utility.setTextViewSize(
                    binding.tvFromWidget,
                    this.resources.getDimension(R.dimen._16sdp)
                )
                Utility.setTextViewSize(
                    binding.tvToWidget,
                    this.resources.getDimension(R.dimen._16sdp)
                )
                Utility.setTextViewSize(
                    binding.tvRateWidget,
                    this.resources.getDimension(R.dimen._18sdp)
                )
                Utility.setTextViewSize(
                    binding.tvDiffWidget,
                    this.resources.getDimension(R.dimen._15sdp)
                )
                Utility.setTextViewSize(
                    binding.currencyWiki,
                    this.resources.getDimension(R.dimen._12sdp)
                )

            }
        }


//        var radioGroup: RadioGroup = findViewById(R.id.radio_group_visual)
//
//        binding.radioGroupVisual.setOnCheckedChangeListener { p0, id ->
//            when (id) {
//                R.id.radio_small -> {
//                    Utility.setIntegerPref(Constants.fontSize, 1, this)
//                    Utility.setTextViewSize(
//                        binding.tvFromWidget,
//                        this.resources.getDimension(R.dimen._14sdp)
//                    )
//                    Utility.setTextViewSize(
//                        binding.tvToWidget,
//                        this.resources.getDimension(R.dimen._14sdp)
//                    )
//                    Utility.setTextViewSize(
//                        binding.tvRateWidget,
//                        this.resources.getDimension(R.dimen._16sdp)
//                    )
//
//                    Utility.setTextViewSize(
//                        binding.currencyWiki,
//                        this.resources.getDimension(R.dimen._10sdp)
//                    )
//                    Utility.setTextViewSize(
//                        binding.tvDiffWidget,
//                        this.resources.getDimension(R.dimen._13sdp)
//                    )
//
//
//                }
//                R.id.radio_medium -> {
//                    Utility.setIntegerPref(Constants.fontSize, 2, this)
//                    Utility.setTextViewSize(
//                        binding.tvFromWidget,
//                        this.resources.getDimension(R.dimen._15sdp)
//                    )
//                    Utility.setTextViewSize(
//                        binding.tvToWidget,
//                        this.resources.getDimension(R.dimen._15sdp)
//                    )
//                    Utility.setTextViewSize(
//                        binding.tvRateWidget,
//                        this.resources.getDimension(R.dimen._17sdp)
//                    )
//                    Utility.setTextViewSize(
//                        binding.tvDiffWidget,
//                        this.resources.getDimension(R.dimen._14sdp)
//                    )
//                    Utility.setTextViewSize(
//                        binding.currencyWiki,
//                        this.resources.getDimension(R.dimen._11sdp)
//                    )
//
//                }
//                R.id.radio_large -> {
//                    Utility.setIntegerPref(Constants.fontSize, 3, this)
//                    Utility.setTextViewSize(
//                        binding.tvFromWidget,
//                        this.resources.getDimension(R.dimen._16sdp)
//                    )
//                    Utility.setTextViewSize(
//                        binding.tvToWidget,
//                        this.resources.getDimension(R.dimen._16sdp)
//                    )
//                    Utility.setTextViewSize(
//                        binding.tvRateWidget,
//                        this.resources.getDimension(R.dimen._18sdp)
//                    )
//                    Utility.setTextViewSize(
//                        binding.tvDiffWidget,
//                        this.resources.getDimension(R.dimen._15sdp)
//                    )
//                    Utility.setTextViewSize(
//                        binding.currencyWiki,
//                        this.resources.getDimension(R.dimen._12sdp)
//                    )
//
//                }
//                else -> { // Note the block
//                    debugPrint("x is neither 1 nor 2")
//                }
//            }
//        }


    }

    private fun setSlider(color: Int) {
        binding.seekbar.setOnSeekBarChangeListener(object : OnSeekBarChangeListener {
            override fun onProgressChanged(
                seekBar: SeekBar?, progress: Int,
                fromUser: Boolean
            ) {

                Utility.saveWidgetTransparency(applicationContext, progress)
                setupWidgetTransparency(progress, color);
            }

            override fun onStartTrackingTouch(seekBar: SeekBar?) {
            }

            override fun onStopTrackingTouch(seekBar: SeekBar?) {
            }
        })
    }

    private fun setupWidgetTransparency(trans: Int, color: Int) {
        val transparancy: Float = 1f - (trans.toFloat() / 100)
        val startColor = getColorWithAlpha(color, 1f)
        val endColor = getColorWithAlpha(color, 0.8f)



        Utility.setIntegerPref(
            Constants.colorCodeStart,
            getColorWithAlpha(startColor, transparancy),
            applicationContext
        )
        Utility.setIntegerPref(
            Constants.colorCodeEnd,
            getColorWithAlpha(endColor, transparancy),
            applicationContext
        )


        binding.widgetTransparency.background = SingleConvertorProvider.getWidgetGradientDrawable(
            getColorWithAlpha(color, transparancy),
            0,
            0,
            this.resources.getDimension(R.dimen._8sdp)
        )

        binding.tvSliderValue.text = trans.toString()
    }

    private fun getColorWithAlpha(color: Int, ratio: Float): Int {
        var newColor = 0
        val alpha = Math.round(Color.alpha(color) * ratio)
        val r = Color.red(color)
        val g = Color.green(color)
        val b = Color.blue(color)
        newColor = Color.argb(alpha, r, g, b)
        return newColor
    }

    override fun onBackPressed() {
        super.onBackPressed()
        setResult(Activity.RESULT_CANCELED)
    }

    override fun onItemSelect(country: Country, type: Int) {
        binding.arrowLayout.visibility = View.GONE
        binding.layoutCountries.visibility = View.GONE
        binding.layoutWidgetTransparency.visibility = View.VISIBLE
        binding.tvWidgetTransparency.visibility = View.VISIBLE
        binding.layoutVisualSize.visibility = View.VISIBLE
        binding.tvVisualSize.visibility = View.VISIBLE
        showCurrencyList1 = false
        showCurrencyList2 = false

        if (type == 1) {
//            Utility.setCurrencyCode1(this, country.code, appWidgetId)
            binding.tvCurrencyCodeFrom.text = country.code
            binding.flagImgFrom.setImageDrawable(country.flag)
            binding.flagImgFrom.scaleType = ImageView.ScaleType.CENTER_CROP
        }
        if (type == 2) {
//            Utility.setCurrencyCode2(this, country.code, appWidgetId)
            binding.tvCurrencyCodeTo.text = country.code
            binding.flagImgTo.setImageDrawable(country.flag)
            binding.flagImgTo.scaleType = ImageView.ScaleType.CENTER_CROP
        }


    }

    override fun onItemFavorite(country: Country, position: Int, fav: Int) {

//        countryList[position].favorite = fav
//        countryList.sortBy { it.code }
//        countryList.sortByDescending { it.favorite }

        adapter!!.currencyList[position].favorite = fav
        adapter!!.currencyList.sortBy { it.code }
        adapter!!.currencyList.sortByDescending { it.favorite }

        updateFavorite(adapter!!.currencyList[position])
        adapter!!.notifyDataSetChanged()


    }


    private fun getConvertRate(
        from: String,
        to: String,
        context: Context,
        appWidgetManager: AppWidgetManager,
        widgetId: Int
    ) {
        val subscribe = ApiClient.instance.getConvertRate()
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


                            val per = (diff * 100) / todayRate

                            Utility.setStringPref("difference", per.toString(), context);

                            Utility.setExchangeValue(
                                context,
                                todayRate.toString(),
                                widgetId

                            )

                            SingleConvertorProvider.updateWidget(
                                context,
                                appWidgetManager,
                                widgetId, false
                            )


                            val resultValue =
                                Intent().putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)
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
                val db: SQLiteDatabase = SQLiteDatabase.openDatabase(
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

                        if (index > -1) {
                            if (cursor.getString(favIndex) == "1") {
                                countryList.add(Country(currencyFlag.getDrawable(index)!!, currencyCode[index], currencyName[index], "", 1, 0))
                            } else {
                                countryList.add(Country(currencyFlag.getDrawable(index)!!, currencyCode[index], currencyName[index], "", 0, 0))
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
                db.close()

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
                val v = db.execSQL(query);
                Log.e(javaClass.name, "update-> " + v.toString())
                db.close()
            }

        } catch (e: Exception) {
            e.printStackTrace();
        }
    }

}