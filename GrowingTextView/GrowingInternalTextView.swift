//
//  GrowingInternalTextView.swift
//  GrowingTextView
//
//  Created by Xin Hong on 16/2/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

internal class GrowingInternalTextView: UITextView {
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
        placeholder.drawInRect(bounds)
    }
}
