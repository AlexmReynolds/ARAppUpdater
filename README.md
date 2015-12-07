# ARAppUpdater

[![CI Status](http://img.shields.io/travis/Alex M Reynolds/ARAppUpdater.svg?style=flat)](https://travis-ci.org/Alex M Reynolds/ARAppUpdater)
[![Version](https://img.shields.io/cocoapods/v/ARAppUpdater.svg?style=flat)](http://cocoapods.org/pods/ARAppUpdater)
[![License](https://img.shields.io/cocoapods/l/ARAppUpdater.svg?style=flat)](http://cocoapods.org/pods/ARAppUpdater)
[![Platform](https://img.shields.io/cocoapods/p/ARAppUpdater.svg?style=flat)](http://cocoapods.org/pods/ARAppUpdater)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

To check for an update from the App store simply do

```objc
ARAppUpdater *updater = [[ARAppUpdater alloc] init];
[updater checkForUpdate:^{

}];
```
You can also force an update by passing in the kAPAUpdateRequired key as an option
```objc
ARAppUpdater *updater = [[ARAppUpdater alloc] initWithOptions@{kAPAUpdateRequired : @YES}];
[updater checkForUpdate:^{

}];
```
In order to check for updates by using a JSON response from a location other than the app store pass in a custom url and key path in the options

```objc
ARAppUpdater *updater = [[ARAppUpdater alloc] initWithOptions:@{kAPAUpdateRequired : @YES, kAPACustomVersionKeyPath : @"data.minimum_release.version", kAPACustomVersionURL : @"http://api-stage.vacasait.com/clients/validation/ios-housekeeper-app"}];
[updater checkForUpdate:^{

}];
```


## Requirements

## Installation

ARAppUpdater is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ARAppUpdater"
```

## Author

Alex M Reynolds, alex.michael.reynolds@gmail.com

## License

ARAppUpdater is available under the MIT license. See the LICENSE file for more info.
