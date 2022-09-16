package com.currencywiki.currencyconverter.model

data class ConversionRateResponse(
    val quotes: Quotes,
    val quotes_ninty: QuotesNinty,
    val quotes_yesterday: QuotesYesterday,
    val timestamp: Int
)