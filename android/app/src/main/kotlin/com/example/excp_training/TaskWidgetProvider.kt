package com.example.excp_training

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.util.Log
import android.widget.RemoteViews

class TaskWidgetProvider : AppWidgetProvider() {
    private val TAG = "TaskWidgetProvider"

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        Log.d(TAG, "onUpdate called with appWidgetIds: ${appWidgetIds.joinToString()}")
        for (appWidgetId in appWidgetIds) {
            Log.d(TAG, "Updating widget with ID: $appWidgetId")
            updateWidget(context, appWidgetManager, appWidgetId)
        }
    }

    private fun updateWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
        Log.d(TAG, "updateWidget called for widget ID: $appWidgetId")

        val views = RemoteViews(context.packageName, R.layout.widget_layout)

        // Set up the intent for the service
        val serviceIntent = Intent(context, TaskWidgetService::class.java)
        views.setRemoteAdapter(R.id.task_list_view, serviceIntent)

        // Set empty view
        views.setEmptyView(R.id.task_list_view, R.id.empty_view)

        // Set up the pending intent template for item clicks
        val clickIntent = Intent(context, MainActivity::class.java)
        val clickPendingIntent = PendingIntent.getActivity(
            context,
            0,
            clickIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
        views.setPendingIntentTemplate(R.id.task_list_view, clickPendingIntent)

        // Update the widget
        appWidgetManager.updateAppWidget(appWidgetId, views)
        Log.d(TAG, "Widget updated successfully for ID: $appWidgetId")
    }

    override fun onReceive(context: Context?, intent: Intent?) {
    super.onReceive(context, intent)

    if (intent?.action == AppWidgetManager.ACTION_APPWIDGET_UPDATE) {
        Log.d("TaskWidgetProvider", "Received ACTION_APPWIDGET_UPDATE broadcast")
        val appWidgetManager = AppWidgetManager.getInstance(context)
        val componentName = ComponentName(context!!, TaskWidgetProvider::class.java)
        val appWidgetIds = appWidgetManager.getAppWidgetIds(componentName)

        for (appWidgetId in appWidgetIds) {
            updateWidget(context, appWidgetManager, appWidgetId)
        }
    }
}
}