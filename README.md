# GrowingTextView
GrowingTextView is a text view which grows with the text changes and starts scrolling when the content reaches a specified number of lines.

![Example](Gif/GrowingTextViewExample.gif "GrowingTextViewExample")


## How To Get Started
### Carthage
Specify "GrowingTextView" in your ```Cartfile```:
```ogdl 
github "teambition/GrowingTextView"
```
### CocoaPods (version equal or above 0.1.4)

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate features into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'TBGrowingTextView', '~> 0.1.4'
```

Then, run the following command:

```bash
$ pod install
```



### Usage
####  Configuration
```swift
textView.maxNumberOfLines = ...
textView.minNumberOfLines = ...
textView.maxHeight = ...
textView.minHeight = ...
textView.isGrowingAnimationEnabled = ...
textView.animationDuration = ...
textView.contentInset = ...
textView.isScrollEnabled = ...
textView.isPlaceholderEnabled = ...
textView.placeholder = ...
textView.text = ...
textView.font = ...
textView.textColor = ...
textView.textAlignment = ...
textView.isEditable = ...
textView.selectedRange = ...
textView.dataDetectorTypes = ...
textView.returnKeyType = ...
textView.keyboardType = ...
textView.enablesReturnKeyAutomatically = ...

// assign delegate
textView.delegate = self
```

####  Implement delegate
```swift
optional func growingTextViewShouldBeginEditing(_ growingTextView: GrowingTextView) -> Bool

optional func growingTextViewShouldEndEditing(_ growingTextView: GrowingTextView) -> Bool

optional func growingTextViewDidBeginEditing(_ growingTextView: GrowingTextView)

optional func growingTextViewDidEndEditing(_ growingTextView: GrowingTextView)

optional func growingTextView(_ growingTextView: GrowingTextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool

optional func growingTextViewDidChange(_ growingTextView: GrowingTextView)

optional func growingTextViewDidChangeSelection(_ growingTextView: GrowingTextView)

optional func growingTextView(_ growingTextView: GrowingTextView, willChangeHeight height: CGFloat, difference: CGFloat)

optional func growingTextView(_ growingTextView: GrowingTextView, didChangeHeight height: CGFloat, difference: CGFloat)

optional func growingTextViewShouldReturn(_ growingTextView: GrowingTextView) -> Bool
```

## Minimum Requirement
iOS 8.0

## Release Notes
* [Release Notes](https://github.com/teambition/GrowingTextView/releases)

## License
GrowingTextView is released under the MIT license. See [LICENSE](https://github.com/teambition/GrowingTextView/blob/master/LICENSE.md) for details.

## More Info
Have a question? Please [open an issue](https://github.com/teambition/GrowingTextView/issues/new)!
