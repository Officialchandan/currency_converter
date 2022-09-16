package com.currencywiki.currencyconverter.widget_service

import android.content.Intent
import android.widget.RemoteViewsService


class ListWidgetService : RemoteViewsService() {
    override fun onGetViewFactory(intent: Intent): RemoteViewsFactory {
        return WidgetDataProvider(this, intent)
    }
}