//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by Sergio on 21.02.23.
//

import UIKit

final class HomeController: UITableViewController {

    //MARK: - Property

   // let menuController = MenuController()

    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        setupNavigationItems()
    }

    //MARK: - Setups

    @objc func handleOpen() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.openMenu()
    }

    @objc func handleHide() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.closeMenu()
    }

    fileprivate func setupNavigationItems() {
        navigationItem.title = "Home"
        navigationItem.titleView?.backgroundColor = .black

        setupCircularNavigationButton()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(handleHide))
    }

    private func setupCircularNavigationButton() {
        let image = UIImage(named: "girlProfile")?.withRenderingMode(.alwaysOriginal)

        let customView = UIButton(type: .system)
        customView.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        customView.setImage(image, for: .normal)
        customView.imageView?.contentMode = .scaleAspectFit

        customView.layer.cornerRadius = 20
        customView.clipsToBounds = true

        customView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 40).isActive = true

        let barButtonItem = UIBarButtonItem(customView: customView)

        navigationItem.leftBarButtonItem = barButtonItem
    }
}

//MARK: - Extensions

extension HomeController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")

        cell.textLabel?.text = "Row: \(indexPath.row)"
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        return cell
    }
}
