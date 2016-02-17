//
//  GrowingTextView.swift
//  GrowingTextView
//
//  Created by Xin Hong on 16/2/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

public class GrowingTextView: UIView {
    // MARK: - Public properties
    public var delegate: GrowingTextViewDelegate?

    public var maxNumberOfLines: Int?
    public var minNumberOfLines = 0
    public var maxHeight: CGFloat?
    public var minHeight: CGFloat = 0
    public var growingAnimationEnabled = true
    public var animationDuration: NSTimeInterval = 0.1
    public var contentInset = UIEdgeInsetsZero {
        didSet {
            updateTextViewFrame()
        }
    }
    public var placeholderEnabled = true {
        didSet {
            textView.shouldDisplayPlaceholder = textView.text.characters.count == 0 && placeholderEnabled
        }
    }
    public var placeholder: NSAttributedString? {
        set {
            textView.placeholder = newValue
        }
        get {
            return textView.placeholder
        }
    }

    // MARK: - UITextView properties
    public var text: String? {
        set {
            textView.text = newValue
        }
        get {
            return textView.text
        }
    }
    public var font: UIFont? {
        set {
            textView.font = newValue
        }
        get {
            return textView.font
        }
    }
    public var textColor: UIColor? {
        set {
            textView.textColor = newValue
        }
        get {
            return textView.textColor
        }
    }
    public var textAlignment: NSTextAlignment {
        set {
            textView.textAlignment = newValue
        }
        get {
            return textView.textAlignment
        }
    }
    public var editable: Bool {
        set {
            textView.editable = newValue
        }
        get {
            return textView.editable
        }
    }
    public var selectedRange: NSRange? {
        set {
            if let newValue = newValue {
                textView.selectedRange = newValue
            }
        }
        get {
            return textView.selectedRange
        }
    }
    public var dataDetectorTypes: UIDataDetectorTypes {
        set {
            textView.dataDetectorTypes = newValue
        }
        get {
            return textView.dataDetectorTypes
        }
    }
    public var scrollEnabled: Bool {
        set {
            textView.scrollEnabled = newValue
        }
        get {
            return textView.scrollEnabled
        }
    }
    public var returnKeyType: UIReturnKeyType {
        set {
            textView.returnKeyType = newValue
        }
        get {
            return textView.returnKeyType
        }
    }
    public var keyboardType: UIKeyboardType {
        set {
            textView.keyboardType = newValue
        }
        get {
            return textView.keyboardType
        }
    }
    public var enablesReturnKeyAutomatically: Bool {
        set {
            textView.enablesReturnKeyAutomatically = newValue
        }
        get {
            return textView.enablesReturnKeyAutomatically
        }
    }
    public var hasText: Bool {
        return textView.hasText()
    }

    // MARK: - Private properties
    private var textView: GrowingInternalTextView = {
        let textView = GrowingInternalTextView(frame: CGRect.zero)
        textView.showsHorizontalScrollIndicator = false
        textView.contentInset = UIEdgeInsetsZero
        textView.contentMode = .Redraw
        return textView
    }()

    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}

// MARK: - Overriding
extension GrowingTextView {
    public override var backgroundColor: UIColor? {
        didSet {
//            textView.backgroundColor = backgroundColor
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        updateTextViewFrame()
    }

    public override func sizeThatFits(var size: CGSize) -> CGSize {
        if text?.characters.count == 0 {
            size.height = minHeight
        }
        return size
    }

    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textView.becomeFirstResponder()
    }

    public override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        return textView.becomeFirstResponder()
    }

    public override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        return textView.resignFirstResponder()
    }

    public override func isFirstResponder() -> Bool {
        return textView.isFirstResponder()
    }
}

// MARK: - Public
extension GrowingTextView {
    public func scrollRangeToVisible(range: NSRange) {
        textView.scrollRangeToVisible(range)
    }

    public func calculateHeight() -> CGFloat {
        return ceil(textView.sizeThatFits(textView.frame.size).height + contentInset.top + contentInset.bottom)
    }

    public func updateHeight() {
        var newHeight = calculateHeight()
        if newHeight < minHeight || !hasText {
            newHeight = minHeight
        }
        if let maxHeight = maxHeight where newHeight > maxHeight {
            newHeight = maxHeight
        }

        let difference = newHeight - frame.height
        if difference != 0 {
            if newHeight == maxHeight {
                if !textView.scrollEnabled {
                    textView.scrollEnabled = true
                    textView.flashScrollIndicators()
                }
            } else {
                textView.scrollEnabled = scrollEnabled
            }

            if growingAnimationEnabled {
                UIView.animateWithDuration(animationDuration, delay: 0, options: [.AllowUserInteraction, .BeginFromCurrentState], animations: { () -> Void in
                    self.updateGrowingTextView(newHeight: newHeight, difference: difference)
                    }, completion: { (finished) -> Void in
                        self.delegate?.growingTextView(self, didChangeHeight: newHeight, difference: difference)
                })
            } else {
                updateGrowingTextView(newHeight: newHeight, difference: difference)
                delegate?.growingTextView(self, didChangeHeight: newHeight, difference: difference)
            }
        }

        textView.shouldDisplayPlaceholder = textView.text.characters.count == 0 && placeholderEnabled
    }
}

// MARK: - Helper
extension GrowingTextView {
    private func commonInit() {
        textView.frame = CGRect(origin: CGPoint.zero, size: frame.size)
        textView.delegate = self
        textView.backgroundColor = UIColor.greenColor()
        backgroundColor = UIColor.redColor()
        addSubview(textView)
    }

    private func updateTextViewFrame() {
        var textViewFrame = frame
        textViewFrame.origin.x = contentInset.left
        textViewFrame.origin.y = contentInset.top
        textViewFrame.size.width -= contentInset.left + contentInset.right
        textViewFrame.size.height -= contentInset.top + contentInset.bottom
        textView.frame = textViewFrame
    }

    private func updateGrowingTextView(newHeight newHeight: CGFloat, difference: CGFloat) {
        delegate?.growingTextView(self, willChangeHeight: newHeight, difference: difference)
        frame.size.height = newHeight
        updateTextViewFrame()
    }
}

// MARK: - TextView delegate
extension GrowingTextView: UITextViewDelegate {
    public func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        return delegate?.growingTextViewShouldBeginEditing(self) ?? true
    }

    public func textViewShouldEndEditing(textView: UITextView) -> Bool {
        return delegate?.growingTextViewShouldEndEditing(self) ?? true
    }

    public func textViewDidBeginEditing(textView: UITextView) {
        delegate?.growingTextViewDidBeginEditing(self)
    }

    public func textViewDidEndEditing(textView: UITextView) {
        delegate?.growingTextViewDidEndEditing(self)
    }

    public func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if !hasText && text.isEmpty {
            return false
        }
        if let delegate = delegate {
            delegate.growingTextView(self, shouldChangeTextInRange: range, replacementText: text)
        }
        if text == "\n" {
            if let shouldReturn = delegate?.growingTextViewShouldReturn(self) {
                return shouldReturn
            } else {
                textView.resignFirstResponder()
                return false
            }
        }
        return true
    }

    public func textViewDidChange(textView: UITextView) {
        updateHeight()
        delegate?.growingTextViewDidChange(self)
    }

    public func textViewDidChangeSelection(textView: UITextView) {
        delegate?.growingTextViewDidChangeSelection(self)
    }
}

