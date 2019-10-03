package com.edicasoft.tgg

import android.os.Bundle
import com.edicasoft.tgg.actions.ScreenRotation
import com.edicasoft.tgg.actions.VideoJoiner
import com.edicasoft.tgg.actions.VideoThumbnail

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        val channel = applicationContext.packageName + SUFFIX_CHANNEL
        MethodChannel(flutterView, channel).setMethodCallHandler { call, result ->
            if (call.method == "getVideoThumbnail") {
                val videoPath = checkNotNull(call.argument<String>("videoPath"))
                val bytes = VideoThumbnail.getVideoThumbnail(videoPath)

                if (bytes != null && bytes.isNotEmpty()) {
                    result.success(bytes)
                } else {
                    result.error("UNAVAILABLE", "Video thumbnail not available.", null)
                }
            } else if (call.method == "createMovie") {
                val videoPaths = checkNotNull(call.argument<List<String>>("videoPaths"))
                val output = checkNotNull(call.argument<String>("output"))
                val movieVideoPath = VideoJoiner.createMovie(this, output, videoPaths)

                if (movieVideoPath != null) {
                    result.success(movieVideoPath)
                } else {
                    result.error("UNAVAILABLE", "Movie creation failed.", null)
                }
            } else if (call.method == "screenRotation") {
                val enabled = checkNotNull(call.argument<Boolean>("enabled"))
                ScreenRotation.rotation(this, enabled)
            } else {
                result.notImplemented()
            }
        }
    }

    private companion object {
        const val SUFFIX_CHANNEL = "/channel"
    }
}
