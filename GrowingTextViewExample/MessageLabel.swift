//
//  MessageLabel.swift
//  GrowingTextViewExample
//
//  Created by 洪鑫 on 16/2/17.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

let kMessageLabelPadding: CGFloat = 10

class MessageLabel: UILabel {
    override func drawRect(rect: CGRect) {
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(0, kMessageLabelPadding, 0, kMessageLabelPadding)))
    }
}
