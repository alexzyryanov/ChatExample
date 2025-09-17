//
//  ChatListViewModel.swift
//  ChatExample
//
//  Created by Alexander Zyryanov on 10.09.2025.
//

import Foundation

protocol ChatListViewModelProtocol {
    var data: [ChatListRoom] { get }
    func fetch() async throws
    func remove(at index: Int)
}

class ChatListViewModel: ChatListViewModelProtocol {
    var data: [ChatListRoom] = [
        .init(type: .main,
              model: ChatListTableViewCellModel(
                title: "Title",
                subTitle: "SubTitle",
                dateStr: Date().toTimeString()
              ))
    ]
    
    func fetch() async throws {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        data.insert(ChatListRoom(type: .main,
                                 model: ChatListTableViewCellModel(
                                    title: "Title",
                                    subTitle: "SubTitle",
                                    dateStr: Date().toTimeString()
                                 )), at: .zero)
    }
    
    func remove(at index: Int) {
        data.remove(at: index)
    }
}

struct ChatListRoom {
    let id = UUID()
    let type: SectionType
    let model: ChatListTableViewCellModelProtocol
}

extension ChatListRoom: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

enum SectionType {
    case main
}

extension Date {
    func toTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.locale = Locale.current
        return formatter.string(from: self)
    }
}
