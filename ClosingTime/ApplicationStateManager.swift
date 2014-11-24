//  Copyright (c) 2014 Scott Talbot. All rights reserved.

import UIKit

import STURLEncoding


var gStateManager: ApplicationStateManager? = nil


public class UrlAndDate: NSObject {
    let url: NSURL
    let date: NSDate

    override convenience init() {
        self.init(NSURL(), date: nil)
    }
    convenience init(_ url: NSURL) {
        self.init(url, date: nil)
    }
    init(_ url_: NSURL, date date_: NSDate?) {
        url = url_
        if let d = date_ {
            date = d
        } else {
            date = NSDate()
        }
        super.init()
    }
}



public class ApplicationStateManager: NSObject {

    class func instantiateSharedStateManager(application: UIApplication) -> ApplicationStateManager {
        gStateManager = ApplicationStateManager(application)
        return gStateManager!
    }
    class func sharedStateManager() -> ApplicationStateManager {
        return gStateManager!
    }


    let application: UIApplication

    init(_ application_: UIApplication) {
        application = application_
        super.init()
    }


    var _urls: [UrlAndDate] = []
    public func urls() -> [UrlAndDate] {
        return _urls
    }

    public func handleURL(url: NSURL, sourceApplication: String?, annotation: AnyObject?) {
        let components = STURLQueryStringEncoding.componentsFromQueryString(url.query)
        if components == nil {
            return
        }

        let application = self.application

        if let callbackUrlString = components["x-callback-url"] as? String {
            if let callbackUrl = NSURL(string: callbackUrlString) {
                let t = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_MSEC * 200))
                dispatch_after(t, dispatch_get_main_queue()) { () -> Void in
                    application.openURL(callbackUrl)
                    return
                }
                _urls.append(UrlAndDate(callbackUrl, date: nil))
            }
        }
    }
}
