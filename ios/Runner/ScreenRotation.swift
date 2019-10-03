//
//  ScreenRotation.swift
//  Runner
//
//  Created by Vitaliy on 10/2/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
struct ScreenRotation {
    static func enable(_ enable: Bool) {
        if enable {
            var mask: UIInterfaceOrientationMask
            switch UIDevice.current.orientation {
            case .portrait:
                mask = UIInterfaceOrientationMask.portrait
            case .portraitUpsideDown:
                mask = UIInterfaceOrientationMask.portraitUpsideDown
            case .landscapeLeft:
                mask = UIInterfaceOrientationMask.landscapeLeft
            case .landscapeRight:
                mask = UIInterfaceOrientationMask.landscapeRight
            default:
                mask = UIInterfaceOrientationMask.portrait
            }
            let orientation: UIInterfaceOrientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation ?? UIInterfaceOrientation.portrait
            lockOrientation(mask, andRotateTo: orientation)
        } else {
            lockOrientation(UIInterfaceOrientationMask.all)
        }
    }

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation: UIInterfaceOrientation) {
        lockOrientation(orientation)
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
}