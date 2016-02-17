//
//  RightMessageCell.swift
//  GrowingTextViewExample
//
//  Created by 洪鑫 on 16/2/17.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit

let kRightMessageCellID = "RightMessageCell"
private let leftPadding: CGFloat = UIScreen.mainScreen().bounds.width / 4
private let rightPadding: CGFloat = 20

class RightMessageCell: UITableViewCell {
    @IBOutlet weak var contentLabel: MessageLabel!
    @IBOutlet weak var contentLabelLeadingSpace: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentLabel.layer.masksToBounds = true
        contentLabel.layer.cornerRadius = 6
    }

    class func rowHeightForMessage(message: String) -> CGFloat {
        return contentLabelFrame(message).height + 15
    }

    class func leadingSpaceForMessage(message: String) -> CGFloat {
        return UIScreen.mainScreen().bounds.width - rightPadding - contentLabelFrame(message).width
    }

    private class func contentLabelFrame(message: String) -> CGRect {
        guard message.characters.count > 0 else {
            return CGRect.zero
        }
        let messageString = message as NSString
        let size = CGSize(width: UIScreen.mainScreen().bounds.width - leftPadding - rightPadding, height: CGFloat.max)
        let frame = messageString.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)], context: nil)
        return CGRect(x: ceil(frame.origin.x), y: ceil(frame.origin.y), width: ceil(frame.width) + kMessageLabelPadding * 2.0, height: ceil(frame.height))
    }
}
