package com.currencywiki.currencyconverter.interfaces

import com.currencywiki.currencyconverter.model.Country
import java.util.ArrayList

interface CurrencySelectListener {

    fun onItemRemove(item: Country, position: Int)
    fun onItemAdd(item: ArrayList<Country>)



}