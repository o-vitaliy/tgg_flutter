package com.edicasoft.tgg.actions

import android.content.Context
import com.amazonaws.auth.BasicAWSCredentials
import com.amazonaws.mobileconnectors.s3.transferutility.TransferListener
import com.amazonaws.mobileconnectors.s3.transferutility.TransferState
import com.amazonaws.mobileconnectors.s3.transferutility.TransferState.COMPLETED
import com.amazonaws.mobileconnectors.s3.transferutility.TransferUtility
import com.amazonaws.mobileconnectors.s3.transferutility.TransferUtilityOptions
import com.amazonaws.services.s3.AmazonS3Client
import io.flutter.plugin.common.EventChannel
import java.io.File

class AwsUpload(
        private val context: Context,
        private val accessKeyId: String,
        private val secretAccessKey: String,
        private val bucketId: String,
        private val fileUrl: String,
        private val sink: EventChannel.EventSink?) {

    fun upload() {
        val credentials = BasicAWSCredentials(accessKeyId, secretAccessKey)
        val amazonS3 = AmazonS3Client(credentials)

        val transferUtility = TransferUtility.builder().s3Client(amazonS3)
                .context(context)
                .transferUtilityOptions(TransferUtilityOptions().apply { transferThreadPoolSize = 1 })
                .build()

        val file = File(fileUrl)

        val observer = transferUtility.upload(
                bucketId, /* The bucket to upload to */
                file.name, /* The key for the uploaded object */
                file        /* The file where the data to upload exists */
        )

        observer.setTransferListener(Listener(sink, fileUrl, observer.id))
    }

    private class Listener constructor(private val sink: EventChannel.EventSink?,
                                       private val fileUrl: String,
                                       private val taskId: Int) : TransferListener {

        override fun onStateChanged(id: Int, state: TransferState) {
            if (taskId != id) {
                return
            }

            when (state) {
                COMPLETED -> sink?.success(Complete(fileUrl).toMap())
                else -> return
            }
        }

        override fun onProgressChanged(id: Int, bytesCurrent: Long, bytesTotal: Long) {
            if (taskId != id) {
                return
            }
            val percentage: Double = bytesCurrent.toDouble() / bytesTotal.toDouble()
            sink?.success(Progress(percentage, fileUrl).toMap())
        }

        override fun onError(id: Int, ex: Exception) {
            if (taskId != id) {
                return
            }
            sink?.success(Error(ex.localizedMessage, fileUrl).toMap())
        }
    }

    companion object {
        fun upload(
                context: Context,
                accessKeyId: String,
                secretAccessKey: String,
                bucketId: String,
                fileUrl: String, sink: EventChannel.EventSink?) {


            val upload = AwsUpload(context, accessKeyId, secretAccessKey, bucketId, fileUrl, sink)
            upload.upload()
        }
    }
}

private abstract class Response(val status: String, val fileUrl: String) {
    val type = "AwsUpload"

    open fun toMap() = HashMap<String, Any>().apply {
        put("type", type)
        put("fileUrl", fileUrl)
        put("status", status)
    }
}
private class Complete(fileUrl: String) : Response("complete", fileUrl)
private class Progress(val progress: Double, fileUrl: String) : Response("progress", fileUrl) {
    override fun toMap() = super.toMap().apply {
        put("progress", progress)
    }
}
private class Error(val message: String, fileUrl: String) : Response("error", fileUrl) {
    override fun toMap() = super.toMap().apply {
        put("message", message)
    }
}
