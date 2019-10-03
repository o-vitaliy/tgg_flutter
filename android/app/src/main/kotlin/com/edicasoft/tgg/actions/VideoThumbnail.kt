package com.edicasoft.tgg.actions

import android.annotation.TargetApi
import android.graphics.Bitmap
import android.media.ThumbnailUtils
import android.os.Build
import android.provider.MediaStore
import java.io.ByteArrayOutputStream

object VideoThumbnail {
    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    fun getVideoThumbnail(videoPath: String): ByteArray? {
        val bmp = ThumbnailUtils.createVideoThumbnail(
            videoPath, MediaStore.Video.Thumbnails.FULL_SCREEN_KIND
        )
        val stream = ByteArrayOutputStream()
        bmp.compress(Bitmap.CompressFormat.PNG, 100, stream)
        val byteArray = stream.toByteArray()
        bmp.recycle()
        return byteArray
    }
}