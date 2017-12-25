# RavingFansSDK

[![CI Status](http://img.shields.io/travis/ko0f/RavingFansSDK.svg?style=flat)](https://travis-ci.org/ko0f/RavingFansSDK)
[![Version](https://img.shields.io/cocoapods/v/RavingFansSDK.svg?style=flat)](http://cocoapods.org/pods/RavingFansSDK)
[![License](https://img.shields.io/cocoapods/l/RavingFansSDK.svg?style=flat)](http://cocoapods.org/pods/RavingFansSDK)
[![Platform](https://img.shields.io/cocoapods/p/RavingFansSDK.svg?style=flat)](http://cocoapods.org/pods/RavingFansSDK)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

RavingFansSDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RavingFansSDK'
```

## Changes

* Adjusted to Swift 4.
* Class name changed from `FTSAnalytics` to `RFAnalytics`.
* Endpoint upgraded to HTTPS, it is no longer required to add an `NSAppTransportSecurity` exemption.
* Code is now open source under MIT license, feel free to fork and PR.
* Published to Cocoapods, integration is now easy.

## Integration

* Import RavingFans™ module to your `AppDelegate` class -
```swift
import RavingFansSDK // swift
```
```objective
@import RavingFansSDK // objc
```

* Upon `applicationDidBecomeActive:`, report that session has started:
```swift
RavingFans.sessionStarted("yourAppKey") // swift
```
```objective
[RavingFans sessionStartedWithAppKey:@"yourAppKey"]; // objc
```

* On `applicationWillResignActive:`, report that session has ended:
```swift
RavingFans.sessionEnded() // swift
```
```objective
[RavingFans sessionEnded]; // objc
```

That's it.

## License

RavingFansSDK is available under the MIT license. See the LICENSE file for more info.
