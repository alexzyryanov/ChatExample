//
//  ChatListViewController.swift
//  ChatExample
//
//  Created by Alexander Zyryanov on 10.09.2025.
//

import UIKit

class ChatListViewController: UIViewController {
    var viewModel: ChatListViewModelProtocol
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        return refresh
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ChatListTableViewCell.self,
                           forCellReuseIdentifier: ChatListTableViewCell.reuseId)
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var dataSource: UITableViewDiffableDataSource<SectionType, ChatListRoom> = {
        UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatListTableViewCell.reuseId,
                                                     for: indexPath) as! ChatListTableViewCell
            cell.setup(item.model)
            return cell
        }
    }()
    
    init(_ viewModel: ChatListViewModelProtocol) {
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
    }
    
    private func setLayout() {
        title = "Chat List"
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
    
    @objc private func didPullToRefresh() {
        Task {
            await updateTable()
        }
    }
    
    private func updateTable() async {
        try? await viewModel.fetch()
        refreshControl.endRefreshing()
        applySnapshot()
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, ChatListRoom>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.data, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

extension ChatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return nil }
        
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "Delete") { [weak self] _, _, completion in
            guard let self = self else { return }
            if let index = self.viewModel.data.firstIndex(where: { $0.id == item.id }) {
                self.viewModel.remove(at: index)
            }
            applySnapshot()
            completion(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(RoomViewController(RoomViewModel()), animated: true)
    }
}
