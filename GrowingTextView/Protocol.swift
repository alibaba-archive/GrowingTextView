//
//  Protocol.swift
//  GrowingTextView
//
//  Created by Xin Hong on 16/2/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

public protocol GrowingTextViewDelegate {
    func growingTextViewShouldBeginEditing(growingTextView: GrowingTextView) -> Bool
    func growingTextViewShouldEndEditing(growingTextView: GrowingTextView) -> Bool

    func growingTextViewDidBeginEditing(growingTextView: GrowingTextView)
    func growingTextViewDidEndEditing(growingTextView: GrowingTextView)

    func growingTextView(growingTextView: GrowingTextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
    func growingTextViewDidChange(growingTextView: GrowingTextView)
    func growingTextViewDidChangeSelection(growingTextView: GrowingTextView)

    func growingTextView(growingTextView: GrowingTextView, willChangeHeight height: CGFloat, difference: CGFloat)
    func growingTextView(growingTextView: GrowingTextView, didChangeHeight height: CGFloat, difference: CGFloat)

    func growingTextViewShouldReturn(growingTextView: GrowingTextView) -> Bool
}

public extension GrowingTextViewDelegate {
    func growingTextViewShouldBeginEditing(growingTextView: GrowingTextView) -> Bool {
        return true
    }

    func growingTextViewShouldEndEditing(growingTextView: GrowingTextView) -> Bool {
        return true
    }

    func growingTextViewDidBeginEditing(growingTextView: GrowingTextView) {

    }

    func growingTextViewDidEndEditing(growingTextView: GrowingTextView) {

    }

    func growingTextView(growingTextView: GrowingTextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return true
    }

    func growingTextViewDidChange(growingTextView: GrowingTextView) {

    }

    func growingTextViewDidChangeSelection(growingTextView: GrowingTextView) {

    }

    func growingTextView(growingTextView: GrowingTextView, willChangeHeight height: CGFloat, difference: CGFloat) {

    }

    func growingTextView(growingTextView: GrowingTextView, didChangeHeight height: CGFloat, difference: CGFloat) {

    }

    func growingTextViewShouldReturn(growingTextView: GrowingTextView) -> Bool {
        return true
    }
}
