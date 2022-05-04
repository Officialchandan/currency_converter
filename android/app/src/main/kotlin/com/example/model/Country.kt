package com.example.model

import android.graphics.drawable.Drawable

data class Country(

    var flag: Drawable,
    var code: String,
    var name: String,
    var value: String,
    var favorite: Boolean,
    var selected: Boolean,


    )