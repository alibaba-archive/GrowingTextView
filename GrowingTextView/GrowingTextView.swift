//
//  GrowingTextView.swift
//  GrowingTextView
//
//  Created by Xin Hong on 16/2/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

public class GrowingTextView: UIView {
    public var delegate: GrowingTextViewDelegate?

    public var maxNumberOfLines: Int?
    public var minNumberOfLines = 0
    public var maxHeight: CGFloat?
    public var minHeight: CGFloat = 0
    public var growingAnimationEnabled = true
    public var animationDuration: NSTimeInterval = 0.1
    public var placeholderEnabled = true {
        didSet {
            textView.shouldDisplayPlaceholder = textView.text.characters.count == 0 && placeholderEnabled
        }
    }
    public var placeholder: NSAttributedString? {
        didSet {
            textView.placeholder = placeholder
        }
    }
    public var contentInset = UIEdgeInsetsZero {
        didSet {
            updateTextViewFrame()
        }
    }

    public var text: String? {
        didSet {
            textView.text = text
        }
    }
    public var font: UIFont? {
        didSet {
            textView.font = font
        }
    }
    public var textColor: UIColor? {
        didSet {
            textView.textColor = textColor
        }
    }
    public var textAlignment: NSTextAlignment = .Left {
        didSet {
            textView.textAlignment = textAlignment
        }
    }
    public var editable = true {
        didSet {
            textView.editable = editable
        }
    }
    public var selectedRange: NSRange? {
        didSet {
            if let selectedRange = selectedRange {
                textView.selectedRange = selectedRange
            }
        }
    }
    public var dataDetectorTypes: UIDataDetectorTypes = .None {
        didSet {
            textView.dataDetectorTypes = dataDetectorTypes
        }
    }
    public var scrollEnabled = true {
        didSet {
            textView.scrollEnabled = scrollEnabled
        }
    }
    public var returnKeyType: UIReturnKeyType = .Default {
        didSet {
            textView.returnKeyType = returnKeyType
        }
    }
    public var keyboardType: UIKeyboardType = .Default {
        didSet {
            textView.keyboardType = keyboardType
        }
    }
    public var enablesReturnKeyAutomatically = false {
        didSet {
            textView.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
        }
    }

    private lazy var textView: GrowingInternalTextView = { [unowned self] in
        let textView = GrowingInternalTextView(frame: CGRect.zero)
        textView.scrollEnabled = self.scrollEnabled
        textView.showsHorizontalScrollIndicator = false
        textView.contentInset = UIEdgeInsetsZero
        textView.contentMode = .Redraw
        return textView
    }()

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
            textView.backgroundColor = backgroundColor
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
    public func hasText() -> Bool {
        return textView.hasText()
    }

    public func scrollRangeToVisible(range: NSRange) {
        textView.scrollRangeToVisible(range)
    }

    public func calculateHeight() -> CGFloat {
        return ceil(textView.sizeThatFits(textView.frame.size).height + contentInset.top + contentInset.bottom)
    }

    public func updateHeight() {
        var newHeight = calculateHeight()
        if newHeight < minHeight || !textView.hasText() {
            newHeight = minHeight
        }
        if let maxHeight = maxHeight where newHeight > maxHeight {
            newHeight = maxHeight
        }

        if newHeight != textView.frame.height {
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
                    self.updateGrowingTextView(newHeight)
                    }, completion: { (finished) -> Void in
                        self.delegate?.growingTextView(self, didChangeHeight: newHeight)
                })
            } else {
                updateGrowingTextView(newHeight)
                self.delegate?.growingTextView(self, didChangeHeight: newHeight)
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

    private func updateGrowingTextView(newHeight: CGFloat) {
        delegate?.growingTextView(self, willChangeHeight: newHeight)
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
        if !textView.hasText() && text.isEmpty {
            return false
        }
        if let delegate = delegate {
            return delegate.growingTextView(self, shouldChangeTextInRange: range, replacementText: text)
        }
        if text == "\n" {
            
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

