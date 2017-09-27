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

    fileprivate var messages = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    fileprivate func setupUI() {
        configureGrowingTextView()
        navigationItem.title = "GrowingTextView"
        automaticallyAdjustsScrollViewInsets = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }

    fileprivate func configureGrowingTextView() {
        textView.returnKeyType = .send
        textView.enablesReturnKeyAutomatically = true
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.placeholder = NSAttributedString(string: "说点什么...", attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: 16)])
        textView.maxNumberOfLines = 5
        textView.delegate = self
    }

    fileprivate func scrollToBottom(animated: Bool) {
        guard messages.count > 0 else {
            return
        }
        tableView.scrollToRow(at: IndexPath(row: 0, section: messages.count - 1), at: .bottom, animated: animated)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            inputBarBottomSpace.constant = keyboardFrame.height
            view.setNeedsLayout()
            view.layoutIfNeeded()
            scrollToBottom(animated: false)
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        inputBarBottomSpace.constant = 0
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

extension ExampleViewController: GrowingTextViewDelegate {
    func growingTextView(_ growingTextView: GrowingTextView, willChangeHeight height: CGFloat, difference: CGFloat) {
        print("Height Will Change To: \(height)  Diff: \(difference)")

        inputBarHeight.constant = height
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

    func growingTextView(_ growingTextView: GrowingTextView, didChangeHeight height: CGFloat, difference: CGFloat) {
        print("Height Did Change!")
    }

    func growingTextViewShouldReturn(_ growingTextView: GrowingTextView) -> Bool {
        guard let text = growingTextView.text, text.characters.count > 0 else {
            return false
        }
        messages.append(text)
        growingTextView.text = nil
        tableView.beginUpdates()
        tableView.insertSections(IndexSet(integer: messages.count - 1), with: .fade)
        tableView.endUpdates()
        scrollToBottom(animated: true)
        return false
    }
}

extension ExampleViewController: UITableViewDataSource, UITableViewDelegate {
    fileprivate func isLeftMessageCell(withIndexPath indexPath: IndexPath) -> Bool {
        return indexPath.section % 2 == 0
    }

    fileprivate func isRightMessageCell(withIndexPath indexPath: IndexPath) -> Bool {
        return indexPath.section % 2 == 1
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        _ = textView.resignFirstResponder()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = messages[indexPath.section]
        if isLeftMessageCell(withIndexPath: indexPath) {
            return LeftMessageCell.rowHeight(for: message)
        } else if isRightMessageCell(withIndexPath: indexPath) {
            return RightMessageCell.rowHeight(for: message)
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.section]
        if isLeftMessageCell(withIndexPath: indexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: kLeftMessageCellID, for: indexPath) as! LeftMessageCell
            cell.isUserInteractionEnabled = false
            cell.contentLabel.text = message
            cell.contentLabelTrainingSpace.constant = LeftMessageCell.trainingSpace(for: message)
            cell.layoutIfNeeded()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kRightMessageCellID, for: indexPath) as! RightMessageCell
            cell.isUserInteractionEnabled = false
            cell.contentLabel.text = message
            cell.contentLabelLeadingSpace.constant = RightMessageCell.leadingSpace(for: message)
            cell.layoutIfNeeded()
            return cell
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        tableView.reloadData()
    }
}
