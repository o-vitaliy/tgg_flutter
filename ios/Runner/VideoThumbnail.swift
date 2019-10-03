import AVFoundation
import AVKit
import Flutter
import UIKit

struct VideoThumbnail {
      static func getVideoThumbnail(path: String) throws -> Data? {
            let asset = AVURLAsset(url: URL(fileURLWithPath: path))
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            let uiImage = UIImage(cgImage: cgImage)
            return UIImageJPEGRepresentation(uiImage, 1.0)
      }
}
