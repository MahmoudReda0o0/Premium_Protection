package com.example.excp_training

import android.content.Intent
import android.os.Bundle
import android.util.Log // Add this import
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.appwidget.AppWidgetManager
import android.content.ComponentName

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.excp_training/update_widget"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "updateWidget") {
                Log.d("MainActivity", "updateWidget method called from Flutter") // Add logging
                updateWidget()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun updateWidget() {
        val appWidgetManager = AppWidgetManager.getInstance(applicationContext)
        val ids = appWidgetManager.getAppWidgetIds(
            ComponentName(applicationContext, TaskWidgetProvider::class.java)
        )

        // Notify the widget that the data has changed
        appWidgetManager.notifyAppWidgetViewDataChanged(ids, R.id.task_list_view)

        // Send broadcast to update the widget
        val intent = Intent(applicationContext, TaskWidgetProvider::class.java)
        intent.action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
        intent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, ids)
        sendBroadcast(intent)

        Log.d("MainActivity", "Widget update broadcast sent for IDs: ${ids.joinToString()}") // Add logging
    }
}