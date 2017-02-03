# Fork of OneDrive SDK

This fork add ability to get email address of signed user. Original repository [link](https://github.com/OneDrive/onedrive-sdk-ios).

## 1. Installation
###Install via Cocoapods
* [Install Cocoapods](http://guides.cocoapods.org/using/getting-started.html) - Follow the getting started guide to install Cocoapods.
* Add the following to your Podfile : `pod 'OneDriveSDK', :git => 'https://github.com/MintSet/onedrive-sdk-ios.git', :branch => 'userEmail'`
* Run the command `pod install` to install the latest OneDriveSDK pod.
* Add `#import <OneDriveSDK/OneDriveSDK.h>` to all files that need to reference the SDK.

## 2. Getting user email
### 1. Setting your application Id and scopes

```
[ODClient setMicrosoftAccountAppId:<applicationId> scopes:@[<scopes>, @"openid"]]
```
`@"openid"` must be add to array of scopes.

### 2. Getting an authenticated ODClient object
Get an ODClient as described in original [README.md](https://github.com/OneDrive/onedrive-sdk-ios#23-getting-an-authenticated-odclient-object).

### 3. Getting NSString of signed user
Use property `userEmail` of ODClient object.
