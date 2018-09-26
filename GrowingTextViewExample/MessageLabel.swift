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
    override func draw(_ rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(top: 0, left: kMessageLabelPadding, bottom: 0, right: kMessageLabelPadding)))
    }
}
