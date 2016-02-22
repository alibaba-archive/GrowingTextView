#GrowingTextView
GrowingTextView is a text view which grows with the text changes and starts scrolling when the content reaches a specified number of lines.

![Example](Gif/GrowingTextViewExample.gif "GrowingTextViewExample")


##How To Get Started
###Carthage
Specify "GrowingTextView" in your Cartfile:
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
textView.growingAnimationEnabled = ...
textView.animationDuration = ...
textView.contentInset = ...
textView.scrollEnabled = ...
textView.placeholderEnabled = ...
textView.placeholder = ...
textView.text = ...
textView.font = ...
textView.textColor = ...
textView.textAlignment = ...
textView.editable = ...
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
optional func growingTextViewShouldBeginEditing(growingTextView: GrowingTextView) -> Bool

optional func growingTextViewShouldEndEditing(growingTextView: GrowingTextView) -> Bool

optional func growingTextViewDidBeginEditing(growingTextView: GrowingTextView)

optional func growingTextViewDidEndEditing(growingTextView: GrowingTextView)

optional func growingTextView(growingTextView: GrowingTextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool

optional func growingTextViewDidChange(growingTextView: GrowingTextView)

optional func growingTextViewDidChangeSelection(growingTextView: GrowingTextView)

optional func growingTextView(growingTextView: GrowingTextView, willChangeHeight height: CGFloat, difference: CGFloat)

optional func growingTextView(growingTextView: GrowingTextView, didChangeHeight height: CGFloat, difference: CGFloat)

optional func growingTextViewShouldReturn(growingTextView: GrowingTextView) -> Bool
```

## Minimum Requirement
iOS 8.0

## Release Notes
* [Release Notes](https://github.com/teambition/GrowingTextView/releases)

## License
GrowingTextView is released under the MIT license. See [LICENSE](https://github.com/teambition/GrowingTextView/blob/master/LICENSE.md) for details.

## More Info
Have a question? Please [open an issue](https://github.com/teambition/GrowingTextView/issues/new)!
