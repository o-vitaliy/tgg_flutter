import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    // set orientations you want to be allowed in this property by default
    var orientationLock = UIInterfaceOrientationMask.all

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController

        let flutterMethodChannel = FlutterMethodChannel(name: "com.edicasoft.tgg/channel", binaryMessenger: controller.binaryMessenger)
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
                guard let videoPaths = arguments["videoPaths"] as? [String] else {
                    print("Bipin - Video paths reading failed.")
                    return
                }
                guard let output = arguments["output"] as? String else {
                    print("Bipin - output reading failed.")
                    return
                }

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
                guard let enabled = arguments["enabled"] as? Bool else {
                    print("Bipin - enabled reading failed.")
                    return
                }
                ScreenRotation.enable(enabled)
            }
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func application(_: UIApplication, supportedInterfaceOrientationsFor _: UIWindow?) -> UIInterfaceOrientationMask {
        return orientationLock
    }
}

extension String: Error {}
