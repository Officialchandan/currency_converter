package com.example.interfaces

import com.example.model.Country
import java.util.ArrayList

interface CurrencySelectListener {

    fun onItemRemove(item: Country, position: Int)
    fun onItemAdd(item: ArrayList<Country>)



}