//
//  UIButton+facotry.swift
//  Med42SDKExample
//
//  Created by Graham Jenkins-Smith on 09/01/2026.
//

import UIKit

extension UIButton {
    static func create(
        title: String,
        font: UIFont,
        backgroundColor: UIColor
    ) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = font
        button.backgroundColor = backgroundColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
