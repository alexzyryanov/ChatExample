//
//  RoomViewModel.swift
//  ChatExample
//
//  Created by Alexander Zyryanov on 10.09.2025.
//

import Foundation

protocol RoomViewModelProtocol {
    var data: [ChatRoom] { get }
    var onDataChanged: (() -> Void)? { get set }
}

class RoomViewModel: RoomViewModelProtocol {
    var onDataChanged: (() -> Void)?
    var data: [ChatRoom] = [
        .init(isForward: true,
              model: .text("Hello")),
        .init(isForward: false,
              model: .text("Hello"))
    ]
    
    private var timer: Timer?
    private let messages = [
        "How are you?",
        "What's up?",
        "Let's go!",
        "Cool",
        "SwiftUI or UIKit?"
    ]
    
    init() {
        startTimer()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            self?.addRandomMessage()
        }
    }
    
    private func addRandomMessage() {
        let randomText = messages.randomElement() ?? "Hello!"
        let randomIsForward = Bool.random()
        
        let newMessage = ChatRoom(isForward: randomIsForward,
                                  model: .text(randomText))
        data.append(newMessage)
        onDataChanged?()
    }
}

struct ChatRoom {
    let id = UUID()
    let isForward: Bool
    let model: MessageType
}

extension ChatRoom: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

enum MessageType: Hashable {
    case text(_ text: String)
}
