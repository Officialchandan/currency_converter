package com.currencywiki.currencyconverter.interfaces

import com.currencywiki.currencyconverter.model.Country

interface ItemClickListener {

    fun onItemSelect(country: Country,type:Int)
    fun onItemFavorite(country: Country, position:Int, fav:Int)



}