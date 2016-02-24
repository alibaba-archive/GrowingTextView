//
//  GrowingInternalTextView.swift
//  GrowingTextView
//
//  Created by Xin Hong on 16/2/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

internal class GrowingInternalTextView: UITextView, NSCopying {
    var placeholder: NSAttributedString? {
        didSet {
            setNeedsDisplay()
        }
    }
    var shouldDisplayPlaceholder = true {
        didSet {
            if shouldDisplayPlaceholder != oldValue {
                setNeedsDisplay()
            }
        }
    }

    private var scrollEnabledTemp = false

    override var text: String! {
        willSet {
            // If one of GrowingTextView's superviews is a scrollView, and self.scrollEnabled is false, setting the text programatically will cause UIKit to search upwards until it finds a scrollView with scrollEnabled true, then scroll it erratically. Setting scrollEnabled temporarily to true prevents this.
            scrollEnabledTemp = scrollEnabled
            scrollEnabled = true
        }
        didSet {
            scrollEnabled = scrollEnabledTemp
        }
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        guard let placeholder = placeholder where shouldDisplayPlaceholder else {
            return
        }
        let placeholderSize = sizeForAttributedString(placeholder)
        let xPosition: CGFloat = textContainer.lineFragmentPadding + textContainerInset.left
        let yPosition: CGFloat = (textContainerInset.top - textContainerInset.bottom) / 2
        let rect = CGRect(origin: CGPoint(x: xPosition, y: yPosition), size: placeholderSize)
        placeholder.drawInRect(rect)
    }

    func copyWithZone(zone: NSZone) -> AnyObject {
        let textView = GrowingInternalTextView(frame: frame)
        textView.scrollEnabled = scrollEnabled
        textView.shouldDisplayPlaceholder = shouldDisplayPlaceholder
        textView.placeholder = placeholder
        textView.text = text
        textView.font = font
        textView.textColor = textColor
        textView.textAlignment = textAlignment
        textView.editable = editable
        textView.selectedRange = selectedRange
        textView.dataDetectorTypes = dataDetectorTypes
        textView.returnKeyType = returnKeyType
        textView.keyboardType = keyboardType
        textView.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically

        textView.textContainerInset = textContainerInset
        textView.textContainer.lineFragmentPadding = textContainer.lineFragmentPadding
        textView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        textView.contentInset = contentInset
        textView.contentMode = contentMode

        return textView
    }

    private func sizeForAttributedString(attributedString: NSAttributedString) -> CGSize {
        let size = attributedString.size()
        return CGRectIntegral(CGRect(origin: CGPointZero, size: size)).size
    }
}
