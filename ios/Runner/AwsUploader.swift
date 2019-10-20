import Foundation
import AWSS3

class AwsUploader{
    static func uploadAws(accessKeyId:String, secretAccessKey:String, bucketId:String ,fileUrl:String, eventSink:  @escaping  FlutterEventSink){
        
        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKeyId, secretKey: secretAccessKey)
        let configuration = AWSServiceConfiguration(region: AWSRegionType.USEast1, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        let transferManager = AWSS3TransferManager.default()
        
        let uploadRequest:AWSS3TransferManagerUploadRequest = AWSS3TransferManagerUploadRequest()
        uploadRequest.bucket = bucketId
        uploadRequest.key = (fileUrl as NSString).lastPathComponent
        uploadRequest.body =  URL.init(string: fileUrl)!
        
        transferManager.upload(uploadRequest).continueWith(executor: AWSExecutor.mainThread(), block: { (task: AWSTask<AnyObject>) -> Any? in
            if let error = task.error as NSError? {
                logError(eventSink: eventSink, fileUrl: fileUrl, error: error.localizedDescription)
                return nil
            }
            logComplete(eventSink: eventSink, fileUrl: fileUrl)
            
            return nil
        })
        
        uploadRequest.uploadProgress = { (bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) -> Void in
            let progress = (Double(totalBytesSent) / Double(totalBytesExpectedToSend))
            logProgress(eventSink: eventSink, fileUrl: fileUrl, progress: progress)
        }
    }
    
    private static func logError(eventSink: FlutterEventSink, fileUrl:String, error:String){
        let result = [
            "fileUrl":fileUrl,
            "error":error,
            "type": "AwsUpload",
            "status":"error"
        ]
        eventSink(result)
    }
    
    private static func logProgress(eventSink: FlutterEventSink, fileUrl:String, progress:Double){
        let result:[String : Any] = [
            "fileUrl":fileUrl,
            "progress":progress,
            "type": "AwsUpload",
            "status":"progress"
        ]
        eventSink(result)
    }
    
    private static func logComplete(eventSink: FlutterEventSink, fileUrl:String){
        let result:[String : Any] = [
            "fileUrl":fileUrl,
            "type": "AwsUpload",
            "status":"complete"
        ]
        eventSink(result)
    }
}
