package com.currencywiki.currencyconverter.model

import android.graphics.drawable.Drawable

data class Country(

    var flag: Drawable,
    var code: String,
    var name: String,
    var value: String,
    var favorite: Int,
    var selected: Int,


    )