package com.example.currency_converter.model

data class ConversionRateResponse(
    val quotes: Quotes,
    val quotes_ninty: QuotesNinty,
    val quotes_yesterday: QuotesYesterday,
    val timestamp: Int
)