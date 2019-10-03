package com.edicasoft.tgg.actions

import android.app.Activity
import android.content.Context
import android.content.pm.ActivityInfo
import android.view.Surface
import android.view.WindowManager

object ScreenRotation {

    fun rotation(activity: Activity, enabled: Boolean) = if (enabled) {
        enabledRotation(activity)
    } else {
        disabledRotation(activity)
    }

    private fun disabledRotation(activity: Activity) {
        val rotation = (activity.getSystemService(
            Context.WINDOW_SERVICE) as WindowManager).defaultDisplay.rotation
        val orientation = when (rotation) {
            Surface.ROTATION_0 -> ActivityInfo.SCREEN_ORIENTATION_PORTRAIT
            Surface.ROTATION_90 -> ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE
            Surface.ROTATION_180 -> ActivityInfo.SCREEN_ORIENTATION_REVERSE_PORTRAIT
            else -> ActivityInfo.SCREEN_ORIENTATION_REVERSE_LANDSCAPE
        }
        activity.requestedOrientation = orientation
    }

    private fun enabledRotation(activity: Activity) {
        activity.requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_UNSPECIFIED;
    }
}