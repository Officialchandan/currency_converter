package com.example.currency_converter.interfaces

import com.example.currency_converter.model.Country

interface ItemClickListener {

    fun onItemSelect(country: Country,type:Int)
    fun onItemFavorite(country: Country, position:Int, fav:Int)



}