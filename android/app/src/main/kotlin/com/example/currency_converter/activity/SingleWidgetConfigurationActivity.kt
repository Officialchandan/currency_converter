package com.example.currency_converter.activity

import android.app.Activity
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.res.Configuration
import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.os.Build
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.util.DisplayMetrics
import android.util.Log
import android.view.View
import android.view.WindowManager
import android.widget.*
import android.widget.SeekBar.OnSeekBarChangeListener
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.currency_converter.R
import com.example.currency_converter.adapter.CurrencyCodeAdapter
import com.example.currency_converter.api.ApiClient
import com.example.currency_converter.databinding.SingleConvertorConfigActivityBinding
import com.example.currency_converter.utils.Constants
import com.example.currency_converter.utils.Utility
import com.example.currency_converter.widget.SingleConvertorProvider
import com.example.interfaces.ItemClickListener
import com.example.model.Country
import com.google.android.material.appbar.AppBarLayout
import com.google.gson.JsonObject
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import retrofit2.Response


class SingleWidgetConfigurationActivity : Activity(), ItemClickListener {

    lateinit var binding: SingleConvertorConfigActivityBinding

    var appWidgetId = 0

    var toolbar: Toolbar? = null
    var tvSlider: TextView? = null
    var tvFrom: TextView? = null
    var tv_to: TextView? = null
    var tvfromWidget: TextView? = null
    var tvToWidget: TextView? = null
    var tvConversionValue: TextView? = null
    var tvConversionDiff: TextView? = null
    var tvCurrencyWiki: TextView? = null
    var tvAdd: TextView? = null
    var tvCurrencyCodeFrom: TextView? = null
    var tvCurrencyCodeTo: TextView? = null
    var layoutFrom: RelativeLayout? = null
    var layoutTo: RelativeLayout? = null
    var arrowLayout: RelativeLayout? = null
    var layoutCountries: LinearLayout? = null
    var imgFlagFrom: ImageView? = null
    var imgFlagTo: ImageView? = null
    var widgetTransparencyLayout: LinearLayout? = null
    var layoutWidgetTransparency: LinearLayout? = null
    var layoutVisualSize: LinearLayout? = null
    var tvWidgetTransparency: TextView? = null
    var tvVisualSize: TextView? = null
    var img_arrow_from: ImageView? = null
    var img_arrow_to: ImageView? = null
    var showCurrencyList: Int = 0
    var rvCurrency: RecyclerView? = null
    var edtSearch: EditText? = null

    var countryList = ArrayList<Country>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.single_convertor_config_activity)
        adjustFontScale(resources.configuration, 1F)
        getCurrencyList()
        init()


        appWidgetId = intent?.extras?.getInt(
            AppWidgetManager.EXTRA_APPWIDGET_ID,
            AppWidgetManager.INVALID_APPWIDGET_ID
        ) ?: AppWidgetManager.INVALID_APPWIDGET_ID

        Log.e(javaClass.name, "appWidgetId-->$appWidgetId")


        binding.tvAddWidget.setOnClickListener(View.OnClickListener {


            if (binding.tvCurrencyCodeFrom.text.toString().isEmpty() || binding.tvCurrencyCodeTo.text.toString().isEmpty()) {
                Toast.makeText(this, "Both the field is required", Toast.LENGTH_LONG).show();
            } else {
                var from: String = binding.tvCurrencyCodeFrom.text.toString()
                var to: String = binding.tvCurrencyCodeTo.text.toString()
                val appWidgetManager = AppWidgetManager.getInstance(this)
                getConvertRate(from, to, this, appWidgetManager, widgetId = appWidgetId)

            }


        })


    }


    private fun init() {

        val flagArray = this.resources.obtainTypedArray(R.array.country_flag)
        val currencyList = this.resources.getStringArray(R.array.currency_code)

        arrowLayout = findViewById(R.id.arrow_layout)
        layoutCountries = findViewById(R.id.layout_countries)
        layoutWidgetTransparency = findViewById(R.id.layout_widget_transparency)
        tvWidgetTransparency = findViewById(R.id.tv_widget_transparency)
        tvVisualSize = findViewById(R.id.tv_visual_size)
        layoutVisualSize = findViewById(R.id.layout_visual_size)
        tvSlider = findViewById(R.id.tv_slider_value)
        tvFrom = findViewById(R.id.tv_from)
        tv_to = findViewById(R.id.tv_to)
        tvfromWidget = findViewById(R.id.tv_from_widget)
        tvToWidget = findViewById(R.id.tv_to_widget)
        tvConversionValue = findViewById(R.id.tv_rate_widget)
        tvConversionValue = findViewById(R.id.tv_diff_widget)

        tvCurrencyWiki = findViewById(R.id.currency_wiki)
        tvConversionDiff = findViewById(R.id.tv_diff_widget)
        rvCurrency = findViewById(R.id.rv_currency)
        tvCurrencyCodeFrom = findViewById(R.id.tv_currency_code_from)
        tvCurrencyCodeTo = findViewById(R.id.tv_currency_code_to)
        layoutFrom = findViewById(R.id.layout_form)
        layoutTo = findViewById(R.id.layout_to)
        imgFlagFrom = findViewById(R.id.flag_img_from)
        imgFlagTo = findViewById(R.id.flag_img_to)
        edtSearch = findViewById(R.id.edt_search)

        arrowLayout!!.visibility = View.GONE
        layoutCountries!!.visibility = View.GONE
        layoutWidgetTransparency!!.visibility = View.VISIBLE
        tvWidgetTransparency!!.visibility = View.VISIBLE
        layoutVisualSize!!.visibility = View.VISIBLE
        tvVisualSize!!.visibility = View.VISIBLE

        widgetTransparencyLayout = findViewById(R.id.widget_transparency)
        val bodyLayout: LinearLayout = findViewById(R.id.parent_layout)

        tvSlider!!.text = "0";


        val widgetColor = Utility.getWidgetColor(context = this)
        val color: Int = Color.parseColor("#$widgetColor")


        val appBarLayout: AppBarLayout = findViewById<AppBarLayout>(R.id.app_bar)
        appBarLayout.setBackgroundColor(getColorWithAlpha(color, 0.8f))
        appBarLayout.setStatusBarForegroundColor(getColorWithAlpha(color, 0.8f))
        toolbar = findViewById(R.id.toolbar)
        toolbar!!.setBackgroundColor(color)

        var gd = GradientDrawable(
            GradientDrawable.Orientation.TOP_BOTTOM,
            intArrayOf(getColorWithAlpha(color, 1f), getColorWithAlpha(color, 0.8f))
        )
        gd.cornerRadius = 0f
        bodyLayout.background = gd


        var gd1 = GradientDrawable(
            GradientDrawable.Orientation.TOP_BOTTOM,
            intArrayOf(getColorWithAlpha(color, 1f), getColorWithAlpha(color, 0.8f))
        )


        gd1.cornerRadius = 16.0f
        widgetTransparencyLayout!!.background = gd1


        var from: String = Utility.getCurrencyCode1(this, appWidgetId)
        val to: String = Utility.getCurrencyCode2(this, appWidgetId)

        val index: Int = currencyList.indexOf(from)
        val index1: Int = currencyList.indexOf(to)

        val imgFrom = flagArray.getDrawable(index)
        val imgTo = flagArray.getDrawable(index1)

        binding.flagImgFrom.setImageDrawable(imgFrom)
        binding.flagImgTo.setImageDrawable(imgTo)
        binding.tvCurrencyCodeFrom.text = from
        binding.tvCurrencyCodeTo.text = to
        binding.imgClear.setOnClickListener(View.OnClickListener {
            binding.edtSearch.text.clear()
        })

        val trans = Utility.getSingleWidgetTransparency(this, appWidgetId)
        setupWidgetTransparency(trans, color);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            binding.seekbar.setProgress(trans, true)
        } else {
            binding.seekbar.progress = trans
        }


        setSlider(color)
        setRadio()


        binding.layoutForm.setOnClickListener(View.OnClickListener {

            setAdapter(countryList, type = 1)
        })
        binding.layoutTo.setOnClickListener(View.OnClickListener {

            setAdapter(countryList, 2)

        })

        var fontSize = Utility.getIntegerPref(Constants.fontSize, this)

        if (fontSize == 0) {
            fontSize = 1;
            Utility.setIntegerPref(Constants.fontSize, 1, this)
        }

        when (fontSize) {

            1 -> {

                binding.radioSmall.isChecked = true
                Utility.setTextViewSize(
                    binding.tvFromWidget,
                    this.resources.getDimension(R.dimen._12sdp)
                )
                Utility.setTextViewSize(
                    binding.tvToWidget,
                    this.resources.getDimension(R.dimen._12sdp)
                )
                Utility.setTextViewSize(
                    binding.tvRateWidget,
                    this.resources.getDimension(R.dimen._16sdp)
                )

                Utility.setTextViewSize(
                    binding.currencyWiki,
                    this.resources.getDimension(R.dimen._12sdp)
                )
                Utility.setTextViewSize(
                    binding.tvDiffWidget,
                    this.resources.getDimension(R.dimen._10sdp)
                )


            }
            2 -> {
                binding.radioMedium.isChecked = true
                Utility.setTextViewSize(
                    binding.tvFromWidget,
                    this.resources.getDimension(R.dimen._13sdp)
                )
                Utility.setTextViewSize(
                    binding.tvToWidget,
                    this.resources.getDimension(R.dimen._13sdp)
                )
                Utility.setTextViewSize(
                    binding.tvRateWidget,
                    this.resources.getDimension(R.dimen._17sdp)
                )
                Utility.setTextViewSize(
                    binding.tvDiffWidget,
                    this.resources.getDimension(R.dimen._11sdp)
                )
                Utility.setTextViewSize(
                    binding.currencyWiki,
                    this.resources.getDimension(R.dimen._13sdp)
                )
            }
            3 -> {
                binding.radioLarge.isChecked = true
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
                    this.resources.getDimension(R.dimen._18sdp)
                )
                Utility.setTextViewSize(
                    binding.tvDiffWidget,
                    this.resources.getDimension(R.dimen._12sdp)
                )
                Utility.setTextViewSize(
                    binding.currencyWiki,
                    this.resources.getDimension(R.dimen._14sdp)
                )
            }


        }


    }

    private fun setAdapter(countryList: List<Country>, type: Int) {

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



        rvCurrency = findViewById(R.id.rv_currency)
        rvCurrency!!.layoutManager = LinearLayoutManager(this)
        val adapter = CurrencyCodeAdapter(countryList, type, this, this)
        val divider = DividerItemDecoration(
            rvCurrency!!.context,
            DividerItemDecoration.VERTICAL
        )


        getDrawable(R.drawable.line_divider)?.let {
            divider.setDrawable(
                it
            )
        }
        rvCurrency!!.addItemDecoration(divider);



        edtSearch!!.addTextChangedListener(object : TextWatcher {
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
                adapter.filter.filter(p0.toString())
                adapter.notifyDataSetChanged()

            }

        })
        rvCurrency!!.adapter = adapter
        adapter.notifyDataSetChanged()


    }

    private fun getCurrencyList() {
        val codeArray = this.resources.getStringArray(R.array.currency_code)
        val nameArray = this.resources.getStringArray(R.array.currency_name)
        val flagArray = this.resources.obtainTypedArray(R.array.country_flag)

        for (i in codeArray.indices) {

            val country: Country =
                Country(flagArray.getDrawable(i)!!, codeArray[i], nameArray[i], "0", false, false)

            countryList.add(country)


        }


        /* var disposable: Disposable? = null
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

                             val jsonFrom: JsonObject = responseData.getAsJsonObject("from")
                             val jsonTo: JsonObject = responseData.getAsJsonObject("to")
                             Log.e(javaClass.simpleName, "jsonFrom-->$jsonFrom")
                             Log.e(javaClass.simpleName, "jsonTo-->$jsonTo")

                             val sizeFrom = jsonFrom.keySet().size
                             val sizeTo = jsonTo.keySet().size


                             var firstForm =
                                 jsonFrom.get(jsonFrom.keySet().toList().last()).toString()
                             var firstTO = jsonTo.get(jsonTo.keySet().toList().last()).toString()


                             var secondFrom =
                                 jsonFrom.get(jsonFrom.keySet().toList().get(sizeFrom-2)).toString()
                             var secondTo =
                                 jsonFrom.get(jsonTo.keySet().toList().get(sizeTo-2)).toString()
                             var d: Double =
                                 (firstForm.toDouble() * 100) / (firstTO.toDouble() * 100)


                             var d1: Double =
                                 (firstForm.toDouble() * 100) / (firstTO.toDouble() * 100)


                             var d3 = d1 -  d






                         }
                     }

                 }
             }, { error ->
                 Log.e(javaClass.simpleName, "error-->$error")

             })*/


    }

    private fun setRadio() {
        var radioGroup: RadioGroup = findViewById(R.id.radio_group_visual)

        radioGroup.setOnCheckedChangeListener { p0, id ->
            when (id) {
                R.id.radio_small -> {
                    Utility.setIntegerPref(Constants.fontSize, 1, this)
                    Utility.setTextViewSize(
                        binding.tvFromWidget,
                        this.resources.getDimension(R.dimen._12sdp)
                    )
                    Utility.setTextViewSize(
                        binding.tvToWidget,
                        this.resources.getDimension(R.dimen._12sdp)
                    )
                    Utility.setTextViewSize(
                        binding.tvRateWidget,
                        this.resources.getDimension(R.dimen._16sdp)
                    )

                    Utility.setTextViewSize(
                        binding.currencyWiki,
                        this.resources.getDimension(R.dimen._12sdp)
                    )
                    Utility.setTextViewSize(
                        binding.tvDiffWidget,
                        this.resources.getDimension(R.dimen._10sdp)
                    )


                }
                R.id.radio_medium -> {
                    Utility.setIntegerPref(Constants.fontSize, 2, this)
                    Utility.setTextViewSize(
                        binding.tvFromWidget,
                        this.resources.getDimension(R.dimen._13sdp)
                    )
                    Utility.setTextViewSize(
                        binding.tvToWidget,
                        this.resources.getDimension(R.dimen._13sdp)
                    )
                    Utility.setTextViewSize(
                        binding.tvRateWidget,
                        this.resources.getDimension(R.dimen._17sdp)
                    )
                    Utility.setTextViewSize(
                        binding.tvDiffWidget,
                        this.resources.getDimension(R.dimen._11sdp)
                    )
                    Utility.setTextViewSize(
                        binding.currencyWiki,
                        this.resources.getDimension(R.dimen._13sdp)
                    )

                }
                R.id.radio_large -> {
                    Utility.setIntegerPref(Constants.fontSize, 3, this)
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
                        this.resources.getDimension(R.dimen._18sdp)
                    )
                    Utility.setTextViewSize(
                        binding.tvDiffWidget,
                        this.resources.getDimension(R.dimen._12sdp)
                    )
                    Utility.setTextViewSize(
                        binding.currencyWiki,
                        this.resources.getDimension(R.dimen._14sdp)
                    )

                }
                else -> { // Note the block
                    print("x is neither 1 nor 2")
                }
            }
        }


    }

    private fun setSlider(color: Int) {
        binding.seekbar.setOnSeekBarChangeListener(object : OnSeekBarChangeListener {
            override fun onProgressChanged(
                seekBar: SeekBar?, progress: Int,
                fromUser: Boolean
            ) {

                Utility.saveSingleWidgetTransparency(applicationContext, progress, appWidgetId)
                setupWidgetTransparency(progress, color);
            }

            override fun onStartTrackingTouch(seekBar: SeekBar?) {
            }

            override fun onStopTrackingTouch(seekBar: SeekBar?) {
            }
        })
    }

    private fun setupWidgetTransparency(trans: Int, color: Int) {
        var transparancy: Float = 1f - (trans.toFloat() / 100)
        val startColor = getColorWithAlpha(color, 1f)
        val endColor = getColorWithAlpha(color, 0.8f)

        val gradientDrawable = GradientDrawable(
            GradientDrawable.Orientation.TOP_BOTTOM,
            intArrayOf(
                getColorWithAlpha(startColor, transparancy),
                getColorWithAlpha(endColor, transparancy)
            )
        )

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

        gradientDrawable.cornerRadius = 16.0f
        widgetTransparencyLayout!!.background = gradientDrawable
        binding.tvSliderValue.text = trans.toString()
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

    override fun onBackPressed() {
        super.onBackPressed()
        setResult(Activity.RESULT_CANCELED)
    }

    private fun adjustFontScale(configuration: Configuration?, scale: Float) {
        configuration?.let {
            it.fontScale = scale
            val metrics: DisplayMetrics = resources.displayMetrics
            val wm: WindowManager = getSystemService(Context.WINDOW_SERVICE) as WindowManager
            wm.defaultDisplay.getMetrics(metrics)
            metrics.scaledDensity = configuration.fontScale * metrics.density

            baseContext.applicationContext.createConfigurationContext(it)
            baseContext.resources.displayMetrics.setTo(metrics)

        }
    }

    override fun onItemSelect(country: Country, type: Int) {
        arrowLayout!!.visibility = View.GONE
        layoutCountries!!.visibility = View.GONE
        layoutWidgetTransparency!!.visibility = View.VISIBLE
        tvWidgetTransparency!!.visibility = View.VISIBLE
        layoutVisualSize!!.visibility = View.VISIBLE
        tvVisualSize!!.visibility = View.VISIBLE

        if (type == 1) {

            Utility.setCurrencyCode1(this, country.code, appWidgetId)
            binding.tvCurrencyCodeFrom.text = country.code
            binding.flagImgFrom.setImageDrawable(country.flag)
            binding.flagImgFrom.scaleType = ImageView.ScaleType.CENTER_CROP
        }
        if (type == 2) {
            Utility.setCurrencyCode2(this, country.code, appWidgetId)
            binding.tvCurrencyCodeTo!!.text = country.code
            binding.flagImgTo.setImageDrawable(country.flag)
            binding.flagImgTo.scaleType = ImageView.ScaleType.CENTER_CROP
        }


    }


    fun getConvertRate(
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
                            Utility.setStringPref("difference", diff.toString(), context);

                            Utility.setExchangeValue(
                                context,
                                todayRate.toString(),
                                widgetId

                            )

                            SingleConvertorProvider.updateWidget(
                                context,
                                appWidgetManager,
                                widgetId,false
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


}