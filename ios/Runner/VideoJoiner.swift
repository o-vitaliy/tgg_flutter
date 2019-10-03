import AVFoundation
import AVKit
import Flutter
import UIKit
class VideoJoiner {
    static func createMovie(output: String, videoPaths: [String]) throws -> String? {
        var arrayVideos = [AVAsset]()
        for videoPath in videoPaths {
            let assets = AVURLAsset(url: URL(fileURLWithPath: videoPath))
            arrayVideos.append(assets)
        }

        let mainComposition = AVMutableComposition()
        let compositionVideoTrack = mainComposition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        compositionVideoTrack?.preferredTransform = CGAffineTransform(rotationAngle: .pi / 2)

        let soundtrackTrack = mainComposition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)

        var insertTime = kCMTimeZero

        for videoAsset in arrayVideos {
            try compositionVideoTrack?.insertTimeRange(CMTimeRangeMake(kCMTimeZero, videoAsset.duration), of: videoAsset.tracks(withMediaType: .video)[0], at: insertTime)
            try soundtrackTrack?.insertTimeRange(CMTimeRangeMake(kCMTimeZero, videoAsset.duration), of: videoAsset.tracks(withMediaType: .audio)[0], at: insertTime)

            insertTime = CMTimeAdd(insertTime, videoAsset.duration)
        }

        let outputFileURL = URL(fileURLWithPath: output)

//        let fileManager = FileManager()
//        fileManager.removeItemIfExisted(outputFileURL)
        let source = DispatchSemaphore(value: 0)

        let exporter = AVAssetExportSession(asset: mainComposition, presetName: AVAssetExportPresetHighestQuality)

        exporter?.outputURL = outputFileURL
        exporter?.outputFileType = AVFileType.mp4
        exporter?.shouldOptimizeForNetworkUse = true

        exporter?.exportAsynchronously {
            source.signal()
        }

        source.wait()
        return exporter?.outputURL?.path
    }
}
