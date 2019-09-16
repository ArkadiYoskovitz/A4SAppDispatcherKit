//
//  AppDelegate.swift
//  A4SAppDispatcherKit
//
//  Created by ArkadiGiniApps on 08/24/2018.
//  Copyright (c) 2018 ArkadiGiniApps. All rights reserved.
//

import UIKit
import AFSAppDispatcherKit

@UIApplicationMain
open class AppDelegate : AFSAppDelegateDispatcher
{
    open var window : UIWindow?

    override open func obtainServices() -> [AFSAppDelegateService]
    {
        return [
            A4SSupportedOrientationService(),
        ]
    }
    
    open override func applicationDidBecomeActive(_ application: UIApplication)
    {
        super.applicationDidBecomeActive(application)
    }
}
