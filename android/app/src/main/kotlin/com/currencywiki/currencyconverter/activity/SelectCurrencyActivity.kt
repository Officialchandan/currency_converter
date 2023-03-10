package com.currencywiki.currencyconverter.activity

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.res.TypedArray
import android.graphics.Color
import android.os.Bundle
import android.util.Log
import android.view.View
import android.view.WindowManager
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.LinearLayoutManager
import com.currencywiki.currencyconverter.R
import com.currencywiki.currencyconverter.adapter.CurrencyListAdapter
import com.currencywiki.currencyconverter.databinding.ActivitySelectCurrencyBinding
import com.currencywiki.currencyconverter.utils.Utility
import com.currencywiki.currencyconverter.interfaces.CurrencySelectListener
import com.currencywiki.currencyconverter.model.Country
import org.json.JSONArray

class SelectCurrencyActivity : AppCompatActivity() {


    lateinit var binding: ActivitySelectCurrencyBinding
    private var selectedAdapter: CurrencyListAdapter? = null
    private var unSelectedAdapter: CurrencyListAdapter? = null
    var selected: ArrayList<Country> = ArrayList<Country>()
    var unSelected: ArrayList<Country> = ArrayList<Country>()

    var widgetId = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        Utility.setAppLanguage(this)
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.activity_select_currency)
        widgetId = intent.extras!!.getInt("appWidgetId")
        initView(widgetId)
    }


    private fun initView(widgetId: Int) {
        val colorCode = Utility.getWidgetColor( this)
        val color: Int = Color.parseColor("#$colorCode")

        window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
        window.statusBarColor = color

        val colorTran = Utility.getColorWithAlpha(color, 1f)
        var gd = Utility.getWidgetGradientDrawable(colorTran, 0, 0, 0f);
        binding.containerView.background = gd


        binding.appBar.setBackgroundColor(color)
        binding.toolbar.setBackgroundColor(color)

        val strSelected = Utility.loadItemsPref(this, widgetId)
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
            val jsonArray = JSONArray()
            for (item in selected) {
                jsonArray.put(item.code)
            }
            Utility.saveItemsPref(this, jsonArray.toString(), widgetId)
            val data = Intent()
            data.putExtra("data", jsonArray.toString())
            setResult(Activity.RESULT_OK, data)
            finish()
        })



        if(Utility.isDarkTheme(this)){
            binding.txtSelect.setTextColor(this.resources.getColor(R.color.black))
            binding.txtUnSelect.setTextColor(this.resources.getColor(R.color.black))
            binding.btnAddWidget.setTextColor(this.resources.getColor(R.color.black))
            binding.imgBack.setImageResource(R.drawable.ic_back_dark)
        }else
        {
            binding.txtSelect.setTextColor(this.resources.getColor(R.color.white))
            binding.txtUnSelect.setTextColor(this.resources.getColor(R.color.white))
            binding.btnAddWidget.setTextColor(this.resources.getColor(R.color.white))
            binding.imgBack.setImageResource(R.drawable.ic_back_light)
        }


    }

    private fun setSelectedAdapter(
        jsonArray: JSONArray,
        context: Context,
        currencyList: Array<String>,
        countryList: Array<String>,
        flagList: TypedArray
    ) {
        Log.e(javaClass.simpleName, "currencyList-->${currencyList.size}")
        for (index in 0 until jsonArray.length()) {
            val symbol: String = jsonArray.getString(index)
            val i = currencyList.indexOf(symbol.uppercase())
            val flag = flagList.getDrawable(i)
            val currencyName = countryList[i]
            val currency = Country(flag!!, symbol, currencyName, "0.00", 0, 0)
            selected.add(currency)
        }





        for (i in currencyList.indices) {
            val code = currencyList[i]
            val name = countryList[i]
            val flag = flagList.getDrawable(i)
            val currency = Country(flag!!, code, name, "0.00", 0, 0)
            unSelected.add(currency)
        }

        val list = unSelected.minus(selected).toList()
        Log.e(javaClass.simpleName, "list-->${list.size}")
        unSelected = ArrayList<Country>(list)

        Log.e(javaClass.simpleName, "unSelected-->${unSelected.size}")
        Log.e(javaClass.simpleName, "Selected-->${selected.size}")

//        for (index in 0 until jsonArray.length()) {
//            val symbol: String = jsonArray.getString(index)
//
//            var i = currencyList.indexOf(symbol.uppercase())
//            val flag = flagList.getDrawable(i)
//            val currencyName = countryList[i]
//
//            val currency = Country(flag!!, symbol, currencyName, "0.00", false, false)
//            selected.add(currency)
//
//            val selectedIndex = unSelected.indexOf(currency)
//            Log.e(javaClass.simpleName, "selectedIndex-->$selectedIndex")
//            if (selectedIndex > -1) {
//                unSelected.removeAt(selectedIndex)
//            }
//
//
//        }


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

    fun <T> Collection<T>.filterNotIn(collection: Collection<T>): Collection<T> {
        val set = collection.toSet()
        return filterNot { set.contains(it) }
    }
}