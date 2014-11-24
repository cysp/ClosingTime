//  Copyright (c) 2014 Scott Talbot. All rights reserved.

import UIKit


@UIApplicationMain
class ApplicationDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? {
        didSet {
            window?.makeKeyAndVisible()
        }
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let sm = ApplicationStateManager.instantiateSharedStateManager(application);

        let urlObject: NSURL? = launchOptions?[UIApplicationLaunchOptionsURLKey] as? NSURL
        let sourceApplication: String? = launchOptions?[UIApplicationLaunchOptionsSourceApplicationKey] as? String
        let annotation: AnyObject? = launchOptions?[UIApplicationLaunchOptionsAnnotationKey]

        if let url = urlObject {
            sm.handleURL(url, sourceApplication: sourceApplication, annotation: annotation)
        }

        return true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        let sm = ApplicationStateManager.sharedStateManager();
        sm.handleURL(url, sourceApplication: sourceApplication, annotation: annotation)
        return true
    }
}

