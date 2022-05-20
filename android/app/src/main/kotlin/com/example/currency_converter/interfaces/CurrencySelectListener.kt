package com.example.currency_converter.interfaces

import com.example.currency_converter.model.Country
import java.util.ArrayList

interface CurrencySelectListener {

    fun onItemRemove(item: Country, position: Int)
    fun onItemAdd(item: ArrayList<Country>)



}