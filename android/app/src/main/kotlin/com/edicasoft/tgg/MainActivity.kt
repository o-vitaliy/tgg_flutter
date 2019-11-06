package com.edicasoft.tgg

import android.os.Bundle
import com.edicasoft.tgg.actions.AwsUpload
import com.edicasoft.tgg.actions.ScreenRotation
import com.edicasoft.tgg.actions.VideoJoiner
import com.edicasoft.tgg.actions.VideoThumbnail
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    private val streamHandler by lazy {
        object : StreamHandler {
            var sink: EventChannel.EventSink? = null
            override fun onListen(p0: Any?, p1: EventChannel.EventSink?) {
                sink = p1
            }

            override fun onCancel(p0: Any?) {
                sink = null
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        val channel = applicationContext.packageName + SUFFIX_CHANNEL
        val stream = applicationContext.packageName + SUFFIX_STREAM

        EventChannel(flutterView, stream)
                .setStreamHandler(streamHandler)

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
                result.success(null)
            } else if (call.method == "uploadAws") {
                val accessKeyId = checkNotNull(call.argument<String>("accessKeyId"))
                val secretAccessKey = checkNotNull(call.argument<String>("secretAccessKey"))
                val bucketId = checkNotNull(call.argument<String>("bucketId"))
                val fileUrl = checkNotNull(call.argument<String>("fileUrl"))
                AwsUpload.upload(applicationContext, accessKeyId, secretAccessKey, bucketId, fileUrl,
                        streamHandler.sink)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private companion object {
        const val SUFFIX_CHANNEL = "/methods"
        const val SUFFIX_STREAM = "/events"
    }
}
