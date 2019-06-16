//
//  RFAnalytics.swift
//  v1.1
//
//  Copyright (c) 2015-2017 RavingFans Pty Ltd. All rights reserved.
//
//  .------------------------------------------------------------------------------------------------------------
//  |                                        I N T E G R A T I O N
//  |
//  | 1. Add RavingFans™ pod to your podfile, run `pod install` at your project dir.
//  |
//  | 2. Import RavingFans™ module to your AppDelegate class -
//  |      Swift: `import RavingFansSDK`
//  |      Obj-C: `#import RavingFansSDK`
//  |
//  | 2. Upon `applicationDidBecomeActive:`, report that session has started:
//  |    Swfit:  RavingFans.sessionStarted("yourAppKey")
//  |    Obj-C:  [RavingFans sessionStarted:@"yourAppKey"];
//  |
//  | 3. Upon `applicationWillResignActive:`, report that session has ended:
//  |    Swfit:  RavingFans.sessionEnded()
//  |    Obj-C:  [RavingFans sessionEnded];
//  |
//  `------------------------------------------------------------------------------------------------------------

import Foundation

@objcMembers
public class RavingFans: NSObject {
    
    private let kUserDefaultsRandomId = "FTS_RandomId"
    
    private static var _instance: RavingFans?
    
    private var appKey: String
    private var sessionId: String = ""
    private var randomId: String = ""
    
    private var _request: RFRequest?
    
    private static func instance(appKey: String) -> RavingFans {
        if _instance == nil {
            _instance = RavingFans(appKey: appKey)
        }
        return _instance!
    }
    
    public static func sessionStarted(appKey: String) {
        instance(appKey: appKey).sessionStarted()
    }

    public static func sessionEnded() {
        assert(_instance != nil, "RavingFans.sessionStarted() has to be called before calling sessionEnded.")
        // key isn't required, becuse session had to be started.
        instance(appKey: "").sessionEnded()
    }

    private init(appKey key: String) {
        appKey = key
        
        super.init()
        
        randomId = readRandomId()
    }
    
    private func sessionStarted() {
        sessionId = NSUUID().uuidString
        let tz = NSTimeZone.default.identifier;
        
        _request = RFRequest(appKey: appKey, randomId: randomId, sessionId: sessionId, command: "session/started", timezone: tz) { (success, error) -> () in
            if !success {
                // this will also retain "self" and the request until it's called.
                print("RavingFans error reporting session \(self.sessionId) started: \(String(describing: error))")
            }
        }
    }
    
    private func sessionEnded() {
        let tz = NSTimeZone.default.identifier;

        _request = RFRequest(appKey: appKey, randomId: randomId, sessionId: sessionId, command: "session/ended", timezone: tz) { (success, error) -> () in
            if !success {
                // this will also retain "self" and the request until it's called.
                print("RavingFans error reporting session \(self.sessionId) ended: \(String(describing: error))")
            }
        }
    }
    
    private func readRandomId() -> String {
        let defaults = UserDefaults.standard
        
        var randomId = defaults.string(forKey: kUserDefaultsRandomId)

        if randomId == nil {
            randomId = NSUUID().uuidString
            defaults.set(randomId, forKey: kUserDefaultsRandomId)
        }
        
        return randomId!
    }

    private class RFRequest: NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
        
        private let kHost = "https://ravingfans.bouqt.com"
        
        typealias RFRequestCompletion = (_ success: Bool, _ error: NSError?) -> ()
        
        var request: NSURLRequest!
        var onComplete: RFRequestCompletion?
        var answer: String = ""
        var connection: NSURLConnection!
        
        init(appKey: String, randomId: String, sessionId: String, command: String, timezone: String, onComplete completeBlock: RFRequestCompletion?) {
            super.init()
            
            onComplete = completeBlock
            
            let customAllowedSet = NSCharacterSet(charactersIn:"=\"#%/<>?@\\^`{|}").inverted
            let tz = timezone.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
            
            let path = "\(kHost)/\(command)?key=\(appKey)&did=\(randomId)&sid=\(sessionId)&tz=\(tz!)"
            let url = URL(string: path)!
            request = NSURLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10);

            connection = NSURLConnection(request: request as URLRequest, delegate: self, startImmediately: true)
        }
        
        func connectionDidFinishLoading(_ connection: NSURLConnection) {
            if let completeBlock = onComplete {
                completeBlock(answer == "OK", nil)
            }
        }

        func connection(_ connection: NSURLConnection, didReceive response: URLResponse) {
        }

        func connection(_ connection: NSURLConnection, didReceive data: Data) {
            if let str = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) {
                answer += String(str)
            }
        }
        
        func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
            if let completeBlock = onComplete {
                completeBlock(false, error as NSError)
            }
        }
    }
}
