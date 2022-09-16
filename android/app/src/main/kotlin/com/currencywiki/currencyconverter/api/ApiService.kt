package com.currencywiki.currencyconverter.api

import com.google.gson.JsonObject
import io.reactivex.Observable
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Path


interface ApiService {


    @GET("quotes/784565d2-9c14-4b25-8235-06f6c5029b15")
    fun getConversionRate(): Observable<Response<JsonObject>>


    @GET("quotes/{from}/{to}/784565d2-9c14-4b25-8235-06f6c5029b15")
    fun convertRate(
        @Path("from") from: String,
        @Path("to") to: String,
        ): Observable<Response<JsonObject>>

}