//
//  ChatListTableViewCell.swift
//  ChatExample
//
//  Created by Alexander Zyryanov on 10.09.2025.
//

import UIKit

protocol ChatListTableViewCellModelProtocol {
    var imageURL: URL? { get }
    var title: String? { get }
    var subTitle: String? { get }
    var dateStr: String? { get }
}

struct ChatListTableViewCellModel: ChatListTableViewCellModelProtocol {
    var imageURL: URL?
    var title: String?
    var subTitle: String?
    var dateStr: String?
}

class ChatListTableViewCell: UITableViewCell {
    static let reuseId: String = String(describing: ChatListTableViewCell.self)
    
    private let avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = .size.x56 / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 1
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        label.numberOfLines = 1
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 2
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
    
    private func setLayout() {
        selectionStyle = .none
        
        contentView.addSubview(avatarView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(subTitleLabel)
    }
    
    private func setConstraint() {
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .spacing.x16),
            avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .spacing.x16),
            avatarView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.spacing.x16),
            avatarView.heightAnchor.constraint(equalToConstant: .size.x56),
            avatarView.widthAnchor.constraint(equalToConstant: .size.x56),
            
            titleLabel.topAnchor.constraint(equalTo: avatarView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: .spacing.x16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: dateLabel.leadingAnchor, constant: -.spacing.x16),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.spacing.x16),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .spacing.x4),
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subTitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -.spacing.x16)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarView.image = nil
        titleLabel.text = nil
        subTitleLabel.text = nil
        dateLabel.text = nil
    }
    
    func setup(_ model: ChatListTableViewCellModelProtocol) {
        if let imageURL = model.imageURL {
            avatarView.load(url: imageURL)
        } else {
            avatarView.backgroundColor = .systemGray
        }
        
        titleLabel.text = model.title
        subTitleLabel.text = model.subTitle
        dateLabel.text = model.dateStr
    }
}
