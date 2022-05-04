package com.example.currency_converter.widget_service

import android.content.Intent
import android.widget.RemoteViewsService


class ListWidgetService : RemoteViewsService() {
    override fun onGetViewFactory(intent: Intent): RemoteViewsFactory {
        return WidgetDataProvider(this, intent)
    }
}