#GrowingTextView
GrowingTextView is a text view which grows with the text changes and starts scrolling when the content reaches a specified number of lines.

![Example](Gif/GrowingTextViewExample.gif "GrowingTextViewExample")


##How To Get Started
###Carthage
Specify "GrowingTextView" in your ```Cartfile```:
```ogdl 
github "teambition/GrowingTextView"
```

###Usage
#####  Configuration
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

#####  Implement delegate
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
