package com.example.currency_converter

import android.app.Activity
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.RadioGroup
import android.widget.SeekBar
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import com.example.currency_converter.activity.SelectCurrencyActivity
import com.example.currency_converter.databinding.ActivityListWidgetConfigBinding
import com.example.currency_converter.utils.Utility
import com.example.currency_converter.utils.Utility.Companion.getColorWithAlpha
import com.example.currency_converter.widget.ListWidgetKt

class ListWidgetConfigActivity : AppCompatActivity() {

    lateinit var binding: ActivityListWidgetConfigBinding
    var appWidgetId = 0

    override fun onCreate(savedInstanceState: Bundle?) {
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


    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == 101 && resultCode == Activity.RESULT_OK) {

            Log.e(javaClass.simpleName, "onActivityResult-->${data!!.extras!!.get("data")}")
            val appWidgetManager = AppWidgetManager.getInstance(this)
            ListWidgetKt.updateAppWidget(this, appWidgetManager, appWidgetId, false)

            val resultValue =
                Intent().putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId)
            setResult(Activity.RESULT_OK, resultValue)
            finish()
        }


    }

    override fun onBackPressed() {
        super.onBackPressed()
        setResult(Activity.RESULT_CANCELED)
    }

    private fun initView(appWidgetId: Int) {

        val colorCode = Utility.getStringPref("primaryColorCode", this)
        val color: Int = Color.parseColor("#$colorCode")
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


        var trans = Utility.getListWidgetTransparency(this, appWidgetId)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            binding.seekBarWidgetOpacity.setProgress(trans, true)
        } else {
            binding.seekBarWidgetOpacity.progress = trans
        }
        setupWidgetTransparency(trans, color);

        setupRadio(this, appWidgetId)
        setupSeekbar(this, color)


    }


    fun setupSeekbar(context: Context, color: Int) {
        binding.seekBarWidgetOpacity.setOnSeekBarChangeListener(object :
            SeekBar.OnSeekBarChangeListener {
            override fun onProgressChanged(p0: SeekBar?, p1: Int, p2: Boolean) {
                Utility.saveListWidgetTransparency(context, p0!!.progress, appWidgetId)
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

    fun setTextViewFontSize(fontSize: Int) {
        when (fontSize) {

            1 -> {

                binding.radioSmall.isChecked = true
                Utility.setTextViewSize(
                    binding.txtUSD,
                    this.resources.getDimension(R.dimen._12sdp)
                )
                Utility.setTextViewSize(
                    binding.txtEUR,
                    this.resources.getDimension(R.dimen._12sdp)
                )
                Utility.setTextViewSize(
                    binding.txtGbp,
                    this.resources.getDimension(R.dimen._12sdp)
                )
                Utility.setTextViewSize(
                    binding.txtCad,
                    this.resources.getDimension(R.dimen._12sdp)
                )
                Utility.setTextViewSize(
                    binding.txtBtc,
                    this.resources.getDimension(R.dimen._12sdp)
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
                    this.resources.getDimension(R.dimen._7sdp)
                )
                Utility.setTextViewSize(
                    binding.txtRateExchange1,
                    this.resources.getDimension(R.dimen._7sdp)
                )
                Utility.setTextViewSize(
                    binding.txtRateExchange2,
                    this.resources.getDimension(R.dimen._7sdp)
                )
                Utility.setTextViewSize(
                    binding.txtRateExchange3,
                    this.resources.getDimension(R.dimen._7sdp)
                )
                Utility.setTextViewSize(
                    binding.txtBy,
                    this.resources.getDimension(R.dimen._12sdp)
                )


            }
            2 -> {
                binding.radioMedium.isChecked = true
                Utility.setTextViewSize(
                    binding.txtUSD,
                    this.resources.getDimension(R.dimen._13sdp)
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
                    this.resources.getDimension(R.dimen._13sdp)
                )
            }
            3 -> {
                binding.radioLarge.isChecked = true
                Utility.setTextViewSize(
                    binding.txtUSD,
                    this.resources.getDimension(R.dimen._14sdp)
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
                    this.resources.getDimension(R.dimen._14sdp)
                )
            }


        }
    }

    fun setupRadio(context: Context, appWidgetId: Int) {


        binding.radioGroup.setOnCheckedChangeListener(object : RadioGroup.OnCheckedChangeListener {
            override fun onCheckedChanged(p0: RadioGroup?, p1: Int) {
                when (p1) {


                    R.id.radio_small -> {
                        Utility.saveVisual(context, 1, appWidgetId)
                        setTextViewFontSize(1)


                    }
                    R.id.radio_medium -> {
                        Utility.saveVisual(context, 2, appWidgetId)
                        setTextViewFontSize(2)
                        binding.radioMedium.isChecked = true

                    }
                    R.id.radio_large -> {
                        Utility.saveVisual(context, 3, appWidgetId)
                        setTextViewFontSize(3)
                        binding.radioLarge.isChecked = true

                    }


                }
            }


        })

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
}