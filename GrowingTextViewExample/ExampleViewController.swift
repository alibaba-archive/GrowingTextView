//
//  ExampleViewController.swift
//  GrowingTextViewExample
//
//  Created by 洪鑫 on 16/2/16.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import UIKit
import GrowingTextView

class ExampleViewController: UIViewController {
    @IBOutlet weak var inputBarBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var inputBarHeight: NSLayoutConstraint!
    @IBOutlet weak var textView: GrowingTextView!
    @IBOutlet weak var tableView: UITableView!

    private var messages = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    private func setupUI() {
        configureGrowingTextView()
        navigationItem.title = "GrowingTextView"
        automaticallyAdjustsScrollViewInsets = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    private func configureGrowingTextView() {
        textView.returnKeyType = .Send
        textView.enablesReturnKeyAutomatically = true
        textView.font = UIFont.systemFontOfSize(16)
        textView.placeholder = NSAttributedString(string: "说点什么...", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSFontAttributeName: UIFont.systemFontOfSize(16)])
        textView.delegate = self
    }

    private func scrollToBottom(animated animated: Bool) {
        guard messages.count > 0 else {
            return
        }
        tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: messages.count - 1), atScrollPosition: .Bottom, animated: animated)
    }

    func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue {
            inputBarBottomSpace.constant = keyboardFrame.height
            view.setNeedsLayout()
            view.layoutIfNeeded()
            scrollToBottom(animated: false)
        }
    }

    func keyboardWillHide(notification: NSNotification) {
        inputBarBottomSpace.constant = 0
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

extension ExampleViewController: GrowingTextViewDelegate {
    func growingTextView(growingTextView: GrowingTextView, didChangeHeight height: CGFloat, difference: CGFloat) {
        print("Height Changed: \(height)  Diff: \(difference)")

        inputBarHeight.constant = height
        UIView.animateWithDuration(0.1, delay: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                self.view.layoutIfNeeded()
            }) { (finished) -> Void in
                self.scrollToBottom(animated: true)
        }
    }

    func growingTextViewShouldReturn(growingTextView: GrowingTextView) -> Bool {
        guard let text = growingTextView.text where text.characters.count > 0 else {
            return false
        }
        messages.append(text)
        growingTextView.text = nil
        tableView.beginUpdates()
        tableView.insertSections(NSIndexSet(index: messages.count - 1), withRowAnimation: .Fade)
        tableView.endUpdates()
        scrollToBottom(animated: true)
        return false
    }
}

extension ExampleViewController: UITableViewDataSource, UITableViewDelegate {
    private func isLeftMessageCellWithIndexPath(indexPath: NSIndexPath) -> Bool {
        return indexPath.section % 2 == 0
    }

    private func isRightMessageCellWithIndexPath(indexPath: NSIndexPath) -> Bool {
        return indexPath.section % 2 == 1
    }

    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return messages.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let message = messages[indexPath.section]
        if isLeftMessageCellWithIndexPath(indexPath) {
            return LeftMessageCell.rowHeightForMessage(message)
        } else if isRightMessageCellWithIndexPath(indexPath) {
            return RightMessageCell.rowHeightForMessage(message)
        }
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let message = messages[indexPath.section]
        if isLeftMessageCellWithIndexPath(indexPath) {
            let cell = tableView.dequeueReusableCellWithIdentifier(kLeftMessageCellID, forIndexPath: indexPath) as! LeftMessageCell
            cell.userInteractionEnabled = false
            cell.contentLabel.text = message
            cell.contentLabelTrainingSpace.constant = LeftMessageCell.trainingSpaceForMessage(message)
            cell.layoutIfNeeded()
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(kRightMessageCellID, forIndexPath: indexPath) as! RightMessageCell
            cell.userInteractionEnabled = false
            cell.contentLabel.text = message
            cell.contentLabelLeadingSpace.constant = RightMessageCell.leadingSpaceForMessage(message)
            cell.layoutIfNeeded()
            return cell
        }
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        tableView.reloadData()
    }
}

