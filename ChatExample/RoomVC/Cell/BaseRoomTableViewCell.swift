//
//  BaseRoomTableViewCell.swift
//  ChatExample
//
//  Created by Alexander Zyryanov on 11.09.2025.
//

import UIKit

class BaseRoomTableViewCell: UITableViewCell {
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    let bubleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .spacing.x4
        return view
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        selectionStyle = .none
        
        contentView.addSubview(bubleView)
        bubleView.addSubview(dateLabel)
    }
    
    func setConstraint() {
        bubleView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leadingConstraint = bubleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .spacing.x16)
        trailingConstraint = bubleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.spacing.x16)
        
        NSLayoutConstraint.activate([
            bubleView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.7),
            bubleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .spacing.x4),
            bubleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.spacing.x4),
            
            dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: bubleView.leadingAnchor, constant: .spacing.x4),
            dateLabel.trailingAnchor.constraint(equalTo: bubleView.trailingAnchor, constant: -.spacing.x4),
            dateLabel.bottomAnchor.constraint(equalTo: bubleView.bottomAnchor, constant: -.spacing.x4)
        ])
    }
}
