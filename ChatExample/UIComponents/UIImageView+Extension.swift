//
//  UIImageView+Extension.swift
//  ChatExample
//
//  Created by Alexander Zyryanov on 10.09.2025.
//

import UIKit

extension UIImageView {
    func load(url: URL?) {
        guard let url = url else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            }
        }
    }
}
