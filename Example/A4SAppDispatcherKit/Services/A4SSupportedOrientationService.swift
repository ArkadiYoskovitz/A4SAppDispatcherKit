//
//  A4SSupportedOrientationService.swift
//  A4SAppDispatcherKit_Example
//
//  Created by Arkadi Yoskovitz on 8/24/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import A4SAppDispatcherKit

final class A4SSupportedOrientationService : NSObject {
    var lastOrientationDevice : UIDeviceOrientation!
    var lastOrientationMask   : UIInterfaceOrientationMask!
}
extension A4SSupportedOrientationService : A4SAppDelegateService {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        lastOrientationDevice = UIDevice.current.orientation
        lastOrientationMask   = .portrait
        return true
    }
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        let currentOrientation = UIDevice.current.orientation
        let isLandscape = UIDevice.current.orientation.isLandscape
        
        guard isLandscape else { return .portrait }
        
        lastOrientationDevice = currentOrientation
        
        guard let _ = window else { lastOrientationMask = .portrait ; return  lastOrientationMask }
        
        let shouldAllowLandscape = true
        switch shouldAllowLandscape {
        case true : lastOrientationMask = [.landscape,.portrait]
        case false: lastOrientationMask = .portrait
        }
        return lastOrientationMask
    }
}
