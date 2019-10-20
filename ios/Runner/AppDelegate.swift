import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, FlutterStreamHandler {
    // set orientations you want to be allowed in this property by default
    var orientationLock = UIInterfaceOrientationMask.all
    
    private var eventSink: FlutterEventSink?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        
        let flutterMethodChannel = FlutterMethodChannel(name: "com.edicasoft.tgg/methods", binaryMessenger: controller.binaryMessenger)
        flutterMethodChannel.setMethodCallHandler {
            (call: FlutterMethodCall, result: FlutterResult) -> Void in
            guard let arguments = call.arguments as? [String: Any?] else {
                print("Bipin - Argument failed")
                return
            }
            if call.method == "getVideoThumbnail" {
                guard let videoPath = arguments["videoPath"] as? String else {
                    print("Bipin - VideoPath failed")
                    return
                }
                print("Video path: \(videoPath)")
                do {
                    let data = try VideoThumbnail.getVideoThumbnail(path: videoPath)
                    // FIXME: Showing warning when fetching video thumbnail
                    if let data = data {
                        print("Bipin - data: \(data)")
                        result(FlutterStandardTypedData(bytes: data))
                    } else {
                        result(FlutterError(code: "UNAVAILABLE", message: "Video thumbnail not found", details: nil))
                    }
                } catch {
                    result(FlutterError(code: "UNAVAILABLE", message: "Video thumbnail not found", details: nil))
                }
            } else if call.method == "createMovie" {
                let videoPaths = arguments["videoPaths"] as! [String]
                let output = arguments["output"] as! String
                
                do {
                    print("Bipin - Video Paths: \(videoPaths) output: \(output)")
                    let moviePath = try VideoJoiner.createMovie(output: output, videoPaths: videoPaths)
                    if let moviePath = moviePath {
                        print("Bipin - movie path: \(String(describing: moviePath))")
                        result(moviePath)
                    } else {
                        result(FlutterError(code: "UNAVAILABLE", message: "Movie creation failed", details: nil))
                    }
                } catch {
                    result(FlutterError(code: "UNAVAILABLE", message: "Movie creation failed", details: nil))
                }
            } else if call.method == "screenRotation" {
                let enabled:Bool = arguments["enabled"] as! Bool
                ScreenRotation.enable(enabled)
                result("ok")
            } else if call.method == "uploadAws" {
                let accessKeyId:String = arguments["accessKeyId"] as! String
                let secretAccessKey:String = arguments["secretAccessKey"] as! String
                let bucketId:String = arguments["bucketId"] as! String
                let fileUrl:String = arguments["fileUrl"] as! String
                
                AwsUploader.uploadAws(accessKeyId: accessKeyId, secretAccessKey: secretAccessKey, bucketId: bucketId, fileUrl: fileUrl, eventSink:self.eventSink!)
                result(nil)
            }
        }
        
        let flutterEventChannel = FlutterEventChannel(name:  "com.edicasoft.tgg/events", binaryMessenger: controller.binaryMessenger)
        flutterEventChannel.setStreamHandler(self)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func application(_: UIApplication, supportedInterfaceOrientationsFor _: UIWindow?) -> UIInterfaceOrientationMask {
        return orientationLock
    }
    
    func onListen(withArguments arguments: Any?,eventSink: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = eventSink
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
    
}

extension String: Error {}
