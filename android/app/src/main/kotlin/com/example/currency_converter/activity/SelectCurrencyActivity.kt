package com.example.currency_converter.activity

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.res.TypedArray
import android.graphics.Color
import android.os.Bundle
import android.util.Log
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.currency_converter.R
import com.example.currency_converter.adapter.CurrencyListAdapter
import com.example.currency_converter.databinding.ActivitySelectCurrencyBinding
import com.example.currency_converter.utils.Utility
import com.example.interfaces.CurrencySelectListener
import com.example.model.Country
import org.json.JSONArray

class SelectCurrencyActivity : AppCompatActivity() {


    lateinit var binding: ActivitySelectCurrencyBinding
    private var selectedAdapter: CurrencyListAdapter? = null
    private var unSelectedAdapter: CurrencyListAdapter? = null
    var selected: ArrayList<Country> = ArrayList<Country>()
    var unSelected: ArrayList<Country> = ArrayList<Country>()

    var widgetId = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.activity_select_currency)

        widgetId = intent.extras!!.getInt("appWidgetId")

        initView(widgetId)
    }


    private fun initView(widgetId: Int) {
        val colorCode = Utility.getStringPref("primaryColorCode", this)
        val color: Int = Color.parseColor("#$colorCode")
        val colorTran = Utility.getColorWithAlpha(color, 1f)
        var gd = Utility.getWidgetGradientDrawable(colorTran, 0, 0, 0f);
        binding.containerView.background = gd


        binding.appBar.setBackgroundColor(color)
        binding.toolbar.setBackgroundColor(color)


        var strSelected = Utility.loadItemsPref(this, widgetId)
        Log.e(javaClass.simpleName, "strSelected-->$strSelected")
        var jsonArray: JSONArray = JSONArray()
        if (strSelected.isNotEmpty()) {
            jsonArray = JSONArray(strSelected)
        }


        Log.e(javaClass.simpleName, "jsonArray-->$jsonArray")

        val currencyList = this.resources.getStringArray(R.array.currency_code)
        val countryList = this.resources.getStringArray(R.array.currency_name)
        val flagList = this.resources.obtainTypedArray(R.array.country_flag)


        if (jsonArray.length() == 0) {
            jsonArray.put("EUR")
            jsonArray.put("USD")
            jsonArray.put("GBP")
            jsonArray.put("MXN")
            jsonArray.put("CAD")
            jsonArray.put("INR")
            Utility.saveItemsPref(this, jsonArray.toString(), appWidgetId = widgetId)
        }


        setSelectedAdapter(jsonArray, this, currencyList, countryList, flagList)

        binding.imgBack.setOnClickListener(View.OnClickListener {
            finish()
        })

        binding.btnAddWidget.setOnClickListener(View.OnClickListener {
            var jsonArray = JSONArray()
            for (item in selected) {
                jsonArray.put(item.code)
            }

            Utility.saveItemsPref(this, jsonArray.toString(), widgetId)
            var data = Intent()

            data.putExtra("data",jsonArray.toString())


            setResult(Activity.RESULT_OK,data )
            finish()


        })


    }

    private fun setSelectedAdapter(
        jsonArray: JSONArray,
        context: Context,
        currencyList: Array<String>,
        countryList: Array<String>,
        flagList: TypedArray
    ) {


        Log.e(javaClass.simpleName, "currencyList-->${currencyList.size}")

        for (index in currencyList.indices) {
            val code = currencyList[index]
            val name = countryList[index]
            val flag = flagList.getDrawable(index)
            unSelected.add(Country(flag!!, code, name, "0.00", false, false))
        }

        Log.e(javaClass.simpleName, "unSelected-->${unSelected.size}")


        for (index in 0 until jsonArray.length()) {
            val symbol: String = jsonArray.getString(index)

            var i = currencyList.indexOf(symbol.uppercase())
            val flag = flagList.getDrawable(i)
            val currencyName = countryList[i]

            val currency = Country(flag!!, symbol, currencyName, "0.00", false, false)
            selected.add(currency)

            val selectedIndex = unSelected.indexOf(currency)
            Log.e(javaClass.simpleName, "selectedIndex-->$selectedIndex")
            if (selectedIndex > -1) {
                unSelected.removeAt(selectedIndex)
            }


        }
        Log.e(javaClass.simpleName, "unSelected-->${unSelected.size}")

        binding.recyclerSelected.layoutManager = LinearLayoutManager(context)
        binding.recyclerUnSelected.layoutManager = LinearLayoutManager(context)


        selectedAdapter =
            CurrencyListAdapter(context, selected, 1, object : CurrencySelectListener {
                override fun onItemRemove(item: Country, position: Int) {
                    selected.remove(item)
                    unSelectedAdapter!!.addItem(item)
                    Log.e("selectedAdapter", "onItemRemove-->${selected.size}")


                }

                override fun onItemAdd(item: java.util.ArrayList<Country>) {

                    selected = item
                    Log.e("selectedAdapter", "onItemAdd-->${selected.size}")
                }
            })

        unSelectedAdapter =
            CurrencyListAdapter(context, unSelected, 2, object : CurrencySelectListener {
                override fun onItemRemove(item: Country, position: Int) {

                    unSelected.remove(item)
                    selectedAdapter!!.addItem(item);

                }

                override fun onItemAdd(item: java.util.ArrayList<Country>) {
                    unSelected = item
                }
            })




        binding.recyclerSelected.adapter = selectedAdapter
        binding.recyclerUnSelected.adapter = unSelectedAdapter


    }
}