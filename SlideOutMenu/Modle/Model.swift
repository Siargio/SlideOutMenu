//
//  Model.swift
//  SlideOutMenu
//
//  Created by Sergio on 23.02.23.
//

import UIKit

struct MenuItem {
    var icon: UIImage?
    var title: String
}

extension MenuItem {
    static var menuItem: [MenuItem] = [
        MenuItem(icon: UIImage(named: "profile"), title: "Home"),
        MenuItem(icon: UIImage(named: "list"), title: "Lists"),
        MenuItem(icon: UIImage(named: "bookmarks"), title: "Bookmarks"),
        MenuItem(icon: UIImage(named: "moments"), title: "Moments")
    ]
}
