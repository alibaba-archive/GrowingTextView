//
//  Protocol.swift
//  GrowingTextView
//
//  Created by Xin Hong on 16/2/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

@objc public protocol GrowingTextViewDelegate: NSObjectProtocol {
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
}

internal struct DelegateSelectors {
    static let shouldBeginEditing: Selector = "growingTextViewShouldBeginEditing:"
    static let shouldEndEditing: Selector = "growingTextViewShouldEndEditing:"
    static let didBeginEditing: Selector = "growingTextViewDidBeginEditing:"
    static let didEndEditing: Selector = "growingTextViewDidEndEditing:"
    static let shouldChangeText: Selector = "growingTextView:shouldChangeTextInRange:replacementText:"
    static let didChange: Selector = "growingTextViewDidChange:"
    static let didChangeSelection: Selector = "growingTextViewDidChangeSelection:"
    static let willChangeHeight: Selector = "growingTextView:willChangeHeight:difference:"
    static let didChangeHeight: Selector = "growingTextView:didChangeHeight:difference:"
    static let shouldReturn: Selector = "growingTextViewShouldReturn:"
}
