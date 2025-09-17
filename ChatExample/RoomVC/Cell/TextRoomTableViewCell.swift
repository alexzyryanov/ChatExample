//
//  TextRoomTableViewCell.swift
//  ChatExample
//
//  Created by Alexander Zyryanov on 11.09.2025.
//

import UIKit

class TextRoomTableViewCell: BaseRoomTableViewCell {
    static let reuseId: String = String(describing: TextRoomTableViewCell.self)
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = .zero
        return label
    }()

    override func setLayout() {
        super.setLayout()
        
        bubleView.addSubview(messageLabel)
    }
    
    override func setConstraint() {
        super.setConstraint()
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: bubleView.topAnchor, constant: .spacing.x8),
            messageLabel.leadingAnchor.constraint(equalTo: bubleView.leadingAnchor, constant: .spacing.x8),
            messageLabel.trailingAnchor.constraint(equalTo: bubleView.trailingAnchor, constant: -.spacing.x8),
            messageLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -.spacing.x4)
        ])
    }
    
    func setup(_ model: ChatRoom) {
        switch model.model {
        case .text(let text):
            messageLabel.text = text
        }
        
        dateLabel.text = Date().toTimeString()
        bubleView.backgroundColor = model.isForward ? .systemGreen : .systemGray6
        
        NSLayoutConstraint.deactivate([leadingConstraint, trailingConstraint])
        if model.isForward {
            NSLayoutConstraint.activate([trailingConstraint])
        } else {
            NSLayoutConstraint.activate([leadingConstraint])
        }
    }
}
