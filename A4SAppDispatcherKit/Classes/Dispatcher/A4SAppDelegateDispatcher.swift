//
//  A4SAppDelegateDispatcher.swift
//  
//
//  Created by Arkadi Yoskovitz on 08/07/2017.
//  Copyright © 2017 Arkadi Yoskovitz. All rights reserved.
//

import UIKit
import CloudKit

open class A4SAppDelegateDispatcher : UIResponder {
    
    ///
    /// Used to obtain an array of A4SAppDelegateService which are used as plugins,
    ///     to split handling UIApplicationDelegate implementation between several distinct control objects
    ///
    /// - Returns: services array containing the A4SAppDelegateService objects
    ///
    open func obtainServices() -> [A4SAppDelegateService] {
        
        return []
    }
    
    fileprivate lazy var _services : [A4SAppDelegateService] = {
        return self.obtainServices()
    }()
    
    open override func responds(to aSelector: Selector!) -> Bool {
        
        // 01 Check if the selector is member of UIApplicationDelegate
        if let input = aSelector, input.isMember(of: UIApplicationDelegate.self) {
            
            // 02 Check if the selector is handled in one of the stored service objects
            for service in _services where service.responds(to: input) {
                return true
            }
            
            // 03 Check if the selector is handled by our subclass, this is generally relavent only for
            // if a selector is member of UIApplicationDelegate but not in _services array check for sub classers
            // if let aSuperType = superclass , method(for: input) != aSuperType.instanceMethod(for: input)
            if overridesSelector(input)
            {
                return super.responds(to: input)
            }
            
            if  input == #selector(getter: UIApplicationDelegate.window) ||
                input == #selector(setter: UIApplicationDelegate.window)
            {
                return super.responds(to: input)
            }
            
            return false
        } else {
            return super.responds(to: aSelector)
        }
    }
}
extension A4SAppDelegateDispatcher : UIApplicationDelegate {
    
    @available(iOS 2.0, *)
    open func applicationDidFinishLaunching(_ application: UIApplication) {
        
        for service in _services {
            service.applicationDidFinishLaunching?(application)
        }
    }
    
    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        for service in _services {
            guard let serviceResult = service.application?(application, willFinishLaunchingWithOptions: launchOptions) else { continue }
            guard !serviceResult else { continue }
            return false
        }
        return true
    }
    
    @available(iOS 3.0, *)
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        for service in _services {
            guard let serviceResult = service.application?(application, didFinishLaunchingWithOptions: launchOptions) else { continue }
            guard !serviceResult else { continue }
            return false
        }
        return true
    }
    
    @available(iOS 2.0, *)
    open func applicationDidBecomeActive(_ application: UIApplication) {
        
        for service in _services {
            service.applicationDidBecomeActive?(application)
        }
    }
    
    @available(iOS 2.0, *)
    open func applicationWillResignActive(_ application: UIApplication) {
        
        for service in _services {
            service.applicationWillResignActive?(application)
        }
    }
    
    @available(iOS, introduced: 2.0, deprecated: 9.0, message: "Please use application:openURL:options:")
    open func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        
        for service in _services {
            guard let serviceResult = service.application?(application, handleOpen: url) else { continue }
            guard !serviceResult else { continue }
            return false
        }
        return true
    }
    
    @available(iOS, introduced: 4.2, deprecated: 9.0, message: "Please use application:openURL:options:")
    open func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        for service in _services {
            guard let serviceResult = service.application?(application, open: url, sourceApplication: sourceApplication, annotation: annotation) else { continue }
            guard !serviceResult else { continue }
            return false
        }
        return true
    }
    @available(iOS 9.0, *)
    open func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {

        for service in _services {

            guard let serviceResult = service.application?(app, open: url, options: options) else { continue }
            guard !serviceResult else { continue }
            return false
        }
        return true
    }
    
    @available(iOS 2.0, *)
    open func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        
        for service in _services {
            service.applicationDidReceiveMemoryWarning?(application)
        }
    }
    
    @available(iOS 2.0, *)
    open func applicationWillTerminate(_ application: UIApplication) {
        
        for service in _services {
            service.applicationWillTerminate?(application)
        }
    }
    
    @available(iOS 2.0, *)
    open func applicationSignificantTimeChange(_ application: UIApplication) {
        
        for service in _services {
            service.applicationSignificantTimeChange?(application)
        }
    }
    
    @available(iOS 2.0, *)
    open func application(_ application: UIApplication, willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        
        for service in _services {
            service.application?(application, willChangeStatusBarOrientation: newStatusBarOrientation, duration: duration)
        }
    }
    
    @available(iOS 2.0, *)
    open func application(_ application: UIApplication, didChangeStatusBarOrientation oldStatusBarOrientation: UIInterfaceOrientation) {
        
        for service in _services {
            service.application?(application, didChangeStatusBarOrientation: oldStatusBarOrientation)
        }
    }
    
    @available(iOS 2.0, *)
    open func application(_ application: UIApplication, willChangeStatusBarFrame newStatusBarFrame: CGRect) {
        
        for service in _services {
            service.application?(application, willChangeStatusBarFrame: newStatusBarFrame)
        }
    }
    
    @available(iOS 2.0, *)
    open func application(_ application: UIApplication, didChangeStatusBarFrame oldStatusBarFrame: CGRect) {
        
        for service in _services {
            service.application?(application, didChangeStatusBarFrame: oldStatusBarFrame)
        }
    }
    
    // This callback will be made upon calling -[UIApplication registerUserNotificationSettings:]. The settings the user has granted to the application will be passed in as the second argument.
    @available(iOS, introduced: 8.0, deprecated: 10.0)
    open func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        
        for service in _services {
            service.application?(application, didRegister: notificationSettings)
        }
    }
    
    @available(iOS 3.0, *)
    open func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        for service in _services {
            service.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        }
    }
    
    @available(iOS 3.0, *)
    open func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        for service in _services {
            service.application?(application, didFailToRegisterForRemoteNotificationsWithError: error)
        }
    }
    
    @available(iOS, introduced: 3.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:] for user visible notifications and -[UIApplicationDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:] for silent remote notifications")
    open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
        for service in _services {
            service.application?(application, didReceiveRemoteNotification: userInfo)
        }
    }
    
    @available(iOS, introduced: 4.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
    open func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        for service in _services {
            service.application?(application, didReceive: notification)
        }
    }
    
    // Called when your app has been activated by the user selecting an action from a local notification.
    // A nil action identifier indicates the default action.
    // You should call the completion handler as soon as you've finished handling the action.
    @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
    open func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        
        for service in _services {
            service.application?(application, handleActionWithIdentifier: identifier, for: notification, completionHandler: completionHandler)
        }
    }
    
    @available(iOS, introduced: 9.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
    open func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable: Any], withResponseInfo responseInfo: [AnyHashable: Any], completionHandler: @escaping () -> Void) {
        
        for service in _services {
            service.application?(application, handleActionWithIdentifier: identifier, forRemoteNotification: userInfo, withResponseInfo: responseInfo, completionHandler: completionHandler)
        }
    }
    
    // Called when your app has been activated by the user selecting an action from a remote notification.
    // A nil action identifier indicates the default action.
    // You should call the completion handler as soon as you've finished handling the action.
    @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
    open func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable: Any], completionHandler: @escaping () -> Void) {
        
        for service in _services {
            service.application?(application, handleActionWithIdentifier: identifier, forRemoteNotification: userInfo, completionHandler: completionHandler)
        }
    }
    
    @available(iOS, introduced: 9.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
    open func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, withResponseInfo responseInfo: [AnyHashable: Any], completionHandler: @escaping () -> Void) {
        
        for service in _services {
            service.application?(application, handleActionWithIdentifier: identifier, for: notification, withResponseInfo: responseInfo, completionHandler: completionHandler)
        }
    }
    
    /*! This delegate method offers an opportunity for applications with the "remote-notification" background mode to fetch appropriate new data in response to an incoming remote notification. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
     
     This method will be invoked even if the application was launched or resumed because of the remote notification. The respective delegate methods will be invoked first. Note that this behavior is in contrast to application:didReceiveRemoteNotification:, which is not called in those cases, and which will not be invoked if this method is implemented. !*/
    @available(iOS 7.0, *)
    open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        var didPerformFetch : Bool = false
        let aSelector = #selector(UIApplicationDelegate.application(_:didReceiveRemoteNotification:fetchCompletionHandler:))
        
        for service in _services {
            
            guard service.responds(to: aSelector) else { continue }
            
            didPerformFetch = true
            service.application?(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
        }
        
        guard !didPerformFetch else { return }
        completionHandler(UIBackgroundFetchResult.noData)
    }
    
    /// Applications with the "fetch" background mode may be given opportunities to fetch updated content in the background or when it is convenient for the system. This method will be called in these situations. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
    @available(iOS 7.0, *)
    open func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        var didPerformFetch : Bool = false
        let aSelector = #selector(UIApplicationDelegate.application(_:performFetchWithCompletionHandler:))
        
        for service in _services {
            
            guard service.responds(to: aSelector) else { continue }
            
            didPerformFetch = true
            service.application?(application, performFetchWithCompletionHandler: completionHandler)
        }
        
        guard !didPerformFetch else { return }
        completionHandler(UIBackgroundFetchResult.noData)
    }
    
    // Called when the user activates your application by selecting a shortcut on the home screen,
    // except when -application:willFinishLaunchingWithOptions: or -application:didFinishLaunchingWithOptions returns NO.
    @available(iOS 9.0, *)
    open func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        for service in _services {
            service.application?(application, performActionFor: shortcutItem, completionHandler: completionHandler)
        }
    }
    
    // Applications using an NSURLSession with a background configuration may be launched or resumed in the background in order to handle the
    // completion of tasks in that session, or to handle authentication. This method will be called with the identifier of the session needing
    // attention. Once a session has been created from a configuration object with that identifier, the session's delegate will begin receiving
    // callbacks. If such a session has already been created (if the app is being resumed, for instance), then the delegate will start receiving
    // callbacks without any action by the application. You should call the completionHandler as soon as you're finished handling the callbacks.
    @available(iOS 7.0, *)
    open func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        
        for service in _services {
            service.application?(application, handleEventsForBackgroundURLSession: identifier, completionHandler: completionHandler)
        }
    }
    
    @available(iOS 8.2, *)
    open func application(_ application: UIApplication, handleWatchKitExtensionRequest userInfo: [AnyHashable: Any]?, reply: @escaping ([AnyHashable: Any]?) -> Void) {
        
        for service in _services {
            service.application?(application, handleWatchKitExtensionRequest: userInfo, reply: reply)
        }
    }
    
    @available(iOS 9.0, *)
    open func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {
        
        for service in _services {
            service.applicationShouldRequestHealthAuthorization?(application)
        }
    }
    
    @available(iOS 4.0, *)
    open func applicationDidEnterBackground(_ application: UIApplication) {
        
        for service in _services {
            service.applicationDidEnterBackground?(application)
        }
    }
    
    @available(iOS 4.0, *)
    open func applicationWillEnterForeground(_ application: UIApplication) {
        
        for service in _services {
            service.applicationWillEnterForeground?(application)
        }
    }
    
    @available(iOS 4.0, *)
    open func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
        
        for service in _services {
            service.applicationProtectedDataWillBecomeUnavailable?(application)
        }
    }
    
    @available(iOS 4.0, *)
    open func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        
        for service in _services {
            service.applicationProtectedDataDidBecomeAvailable?(application)
        }
    }
    
    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        
        for service in _services {
            guard let orientationMask = service.application?(application, supportedInterfaceOrientationsFor: window) else { continue }
            return orientationMask
        }
        return .all
    }
    
    // Applications may reject specific types of extensions based on the extension point identifier.
    // Constants representing common extension point identifiers are provided further down.
    // If unimplemented, the default behavior is to allow the extension point identifier.
    @available(iOS 8.0, *)
    open func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplicationExtensionPointIdentifier) -> Bool {
        
        for service in _services {
            guard let serviceResult = service.application?(application, shouldAllowExtensionPointIdentifier: extensionPointIdentifier) else { continue }
            guard !serviceResult else { continue }
            return false
        }
        return true
    }
    
    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, viewControllerWithRestorationIdentifierPath identifierComponents: [Any], coder: NSCoder) -> UIViewController? {
        
        for service in _services {
            guard let viewController = service.application?(application, viewControllerWithRestorationIdentifierPath: identifierComponents, coder: coder) else { continue }
            return viewController
        }
        return nil
    }
    
    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        
        for service in _services {
            guard let serviceResult = service.application?(application, shouldSaveApplicationState: coder) else { continue }
            guard serviceResult else { continue }
            return true
        }
        return false
    }
    
    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        
        for service in _services {
            guard let serviceResult = service.application?(application, shouldRestoreApplicationState: coder) else { continue }
            guard serviceResult else { continue }
            return true
        }
        return false
    }
    
    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
        
        for service in _services {
            service.application?(application, willEncodeRestorableStateWith: coder)
        }
    }
    
    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
        
        for service in _services {
            service.application?(application, didDecodeRestorableStateWith: coder)
        }
    }
    
    // Called on the main thread as soon as the user indicates they want to continue an activity in your application. The NSUserActivity object may not be available instantly,
    // so use this as an opportunity to show the user that an activity will be continued shortly.
    // For each application:willContinueUserActivityWithType: invocation, you are guaranteed to get exactly one invocation of application:continueUserActivity: on success,
    // or application:didFailToContinueUserActivityWithType:error: if an error was encountered.
    @available(iOS 8.0, *)
    open func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        
        for service in _services {
            guard let serviceResult = service.application?(application, willContinueUserActivityWithType: userActivityType) else { continue }
            guard serviceResult else { continue }
            return true
        }
        return false
    }
    
    // Called on the main thread after the NSUserActivity object is available. Use the data you stored in the NSUserActivity object to re-create what the user was doing.
    // You can create/fetch any restorable objects associated with the user activity, and pass them to the restorationHandler. They will then have the UIResponder restoreUserActivityState: method
    // invoked with the user activity. Invoking the restorationHandler is optional. It may be copied and invoked later, and it will bounce to the main thread to complete its work and call
    // restoreUserActivityState on all objects.
    @available(iOS 8.0, *)
    open func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {

        for service in _services {
            guard let serviceResult = service.application?(application, continue: userActivity, restorationHandler: restorationHandler) else { continue }
            guard serviceResult else { continue }
            return true
        }
        return false
    }
    
    // If the user activity cannot be fetched after willContinueUserActivityWithType is called, this will be called on the main thread when implemented.
    @available(iOS 8.0, *)
    open func application(_ application: UIApplication, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
        
        for service in _services {
            service.application?(application, didFailToContinueUserActivityWithType: userActivityType, error: error)
        }
        return
    }
    
    // This is called on the main thread when a user activity managed by UIKit has been updated. You can use this as a last chance to add additional data to the userActivity.
    @available(iOS 8.0, *)
    open func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {
        
        for service in _services {
            service.application?(application, didUpdate: userActivity)
        }
        return
    }
    
    // This will be called on the main thread after the user indicates they want to accept a CloudKit sharing invitation in your application.
    // You should use the CKShareMetadata object's shareURL and containerIdentifier to schedule a CKAcceptSharesOperation, then start using
    // the resulting CKShare and its associated record(s), which will appear in the CKContainer's shared database in a zone matching that of the record's owner.
    @available(iOS 10.0, *)
    open func application(_ application: UIApplication, userDidAcceptCloudKitShareWith cloudKitShareMetadata: CKShareMetadata) {
        
        for service in _services {
            service.application?(application, userDidAcceptCloudKitShareWith: cloudKitShareMetadata)
        }
        return
    }
}
