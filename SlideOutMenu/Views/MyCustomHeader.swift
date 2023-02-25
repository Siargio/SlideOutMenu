//
//  MyCustomHeader.swift
//  SlideOutMenu
//
//  Created by Sergio on 24.02.23.
//

import UIKit

class MyCustomHeader: UITableViewHeaderFooterView {

    let title: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "textColorHeader")
        label.backgroundColor = UIColor(named: "backgroundColorForChat")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = UIColor(named: "backgroundColorForChat")

            configureContents()
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureContents() {
        contentView.addSubview(title)

        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
