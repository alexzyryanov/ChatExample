//
//  RoomViewController.swift
//  ChatExample
//
//  Created by Alexander Zyryanov on 10.09.2025.
//

import UIKit

class RoomViewController: UIViewController {
    var viewModel: RoomViewModelProtocol
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TextRoomTableViewCell.self,
                           forCellReuseIdentifier: TextRoomTableViewCell.reuseId)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var dataSource: UITableViewDiffableDataSource<SectionType, ChatRoom> = {
        UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: TextRoomTableViewCell.reuseId,
                                                     for: indexPath) as! TextRoomTableViewCell
            cell.setup(item)
            return cell
        }
    }()
    
    init(_ viewModel: RoomViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setConstraint()
        applySnapshot(animatingDifferences: false)
        
        viewModel.onDataChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.applySnapshot()
            }
        }
    }
    
    private func setLayout() {
        title = "Room"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }
    
    private func setConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, ChatRoom>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.data, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences) { [weak self] in
            guard let self = self else { return }
            
            if let lastIndexPath = self.dataSource.indexPath(for: self.viewModel.data.last!) {
                self.tableView.scrollToRow(at: lastIndexPath, at: .top, animated: true)
            }
        }
    }
}
