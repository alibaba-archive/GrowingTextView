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
    static let shouldBeginEditing = #selector(GrowingTextViewDelegate.growingTextViewShouldBeginEditing(_:))
    static let shouldEndEditing = #selector(GrowingTextViewDelegate.growingTextViewShouldEndEditing(_:))
    static let didBeginEditing = #selector(GrowingTextViewDelegate.growingTextViewDidBeginEditing(_:))
    static let didEndEditing = #selector(GrowingTextViewDelegate.growingTextViewDidEndEditing(_:))
    static let shouldChangeText = #selector(GrowingTextViewDelegate.growingTextView(_:shouldChangeTextInRange:replacementText:))
    static let didChange = #selector(GrowingTextViewDelegate.growingTextViewDidChange(_:))
    static let didChangeSelection = #selector(GrowingTextViewDelegate.growingTextViewDidChangeSelection(_:))
    static let willChangeHeight = #selector(GrowingTextViewDelegate.growingTextView(_:willChangeHeight:difference:))
    static let didChangeHeight = #selector(GrowingTextViewDelegate.growingTextView(_:didChangeHeight:difference:))
    static let shouldReturn = #selector(GrowingTextViewDelegate.growingTextViewShouldReturn(_:))
}
