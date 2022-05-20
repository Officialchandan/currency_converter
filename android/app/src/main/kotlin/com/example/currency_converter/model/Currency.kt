package com.example.currency_converter.model

import android.graphics.drawable.Drawable
import java.io.Serializable


data class Currency(

    var flag: Drawable,
    var code: String,
    var name: String,
    var value: String,
    var differenc: String,
    var favorite: Boolean,
    var selected: Boolean,


    ):Serializable