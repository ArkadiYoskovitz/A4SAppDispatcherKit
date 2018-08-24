//
//  AppDelegate.swift
//  A4SAppDispatcherKit
//
//  Created by ArkadiGiniApps on 08/24/2018.
//  Copyright (c) 2018 ArkadiGiniApps. All rights reserved.
//

import UIKit
import A4SAppDispatcherKit

@UIApplicationMain
open class AppDelegate : A4SAppDelegateDispatcher {
    
    open var window : UIWindow?
    
    override open func obtainServices() -> [A4SAppDelegateService] {
        return [
            A4SSupportedOrientationService(),
        ]
    }
    
    open override func applicationDidBecomeActive(_ application: UIApplication) {
        super.applicationDidBecomeActive(application)
    }
}
