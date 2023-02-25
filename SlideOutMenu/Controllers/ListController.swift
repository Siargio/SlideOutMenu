//
//  ListController.swift
//  SlideOutMenu
//
//  Created by Sergio on 24.02.23.
//

import UIKit

class ListController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        navigationItem.title = "List"
        navigationController?.navigationBar.prefersLargeTitles = true

            let label = UILabel()
            label.text = "Label"
            label.font = .systemFont(ofSize: 50, weight: .medium)
            label.textColor = .black
            label.frame = view.frame
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)
    }
}
