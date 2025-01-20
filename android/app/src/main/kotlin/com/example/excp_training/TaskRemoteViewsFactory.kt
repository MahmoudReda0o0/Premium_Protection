package com.example.excp_training

import android.content.Context
import android.util.Log
import android.widget.RemoteViews
import android.widget.RemoteViewsService
import java.io.File

class TaskRemoteViewsFactory(private val context: Context) : RemoteViewsService.RemoteViewsFactory {
    private var tasks: List<String> = listOf()
    private val TAG = "TaskRemoteViewsFactory"

    override fun onCreate() {
        Log.d(TAG, "onCreate")
        // No need to load tasks here, as onDataSetChanged will be called immediately after onCreate
    }

    override fun onDataSetChanged() {
        Log.d(TAG, "onDataSetChanged called")
        loadTasks()
        Log.d(TAG, "Loaded ${tasks.size} tasks")
    }

    private fun loadTasks() {
        try {
            val directory = context.getExternalFilesDir(null)
            val file = File(directory, "tasks.txt")
            if (file.exists()) {
                val tasksString = file.readText()
                Log.d(TAG, "Loading tasks from file: $tasksString")
                tasks = tasksString.split(",").filter { task -> task.isNotEmpty() }
            } else {
                Log.d(TAG, "Tasks file does not exist")
                tasks = emptyList()
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error loading tasks: ${e.message}")
            tasks = emptyList()
        }
    }

    override fun onDestroy() {
        // No cleanup needed
    }

    override fun getCount(): Int {
        Log.d(TAG, "getCount called, tasks size: ${tasks.size}")
        return tasks.size
    }

    override fun getViewAt(position: Int): RemoteViews {
        Log.d(TAG, "getViewAt called for position: $position")
        return RemoteViews(context.packageName, R.layout.task_item).apply {
            setTextViewText(R.id.task_text, tasks[position])
        }
    }

    override fun getLoadingView(): RemoteViews? {
        Log.d(TAG, "getLoadingView called")
        return null // Return null to use the default loading view
    }

    override fun getViewTypeCount(): Int {
        Log.d(TAG, "getViewTypeCount called")
        return 1 // Only one type of view is used
    }

    override fun getItemId(position: Int): Long {
        Log.d(TAG, "getItemId called for position: $position")
        return position.toLong() // Use position as the ID
    }

    override fun hasStableIds(): Boolean {
        Log.d(TAG, "hasStableIds called")
        return true // IDs are stable
    }
}