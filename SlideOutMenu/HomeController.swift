//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by Sergio on 21.02.23.
//

import UIKit

final class HomeController: UITableViewController {

    //MARK: - Property

    let menuController = MenuController()
    fileprivate var isMenuOpened = false
    fileprivate let menuWidth: CGFloat = 300
    fileprivate let velocityOpenThreshold: CGFloat = 500

    //MARK: - UIElements

    let darkCoverView = UIView()

    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .red
        setupNavigationItems()
        setupMenuController()

        setupPanGesture()
        setupDarkCoverView()
    }

    //MARK: - Setups

    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)

        if gesture.state == .changed {
            var x = translation.x

            if isMenuOpened {
                x += menuWidth
            }

            x = min(menuWidth, x)
            x = max(0, x)

            let transform = CGAffineTransform(translationX: x, y: 0)
            menuController.view.transform = transform
            navigationController?.view.transform = transform
            darkCoverView.transform = transform
            let alpha = x / menuWidth

            darkCoverView.alpha = alpha

        } else if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }

    @objc func handleOpen() {
        isMenuOpened = true
        setupMenuController()
        performAnimations(transform: CGAffineTransform(translationX: menuWidth, y: 0))
    }

    @objc func handleHide() {
        isMenuOpened = false
        performAnimations(transform: .identity)
    }

    fileprivate func  setupDarkCoverView() {
        darkCoverView.alpha = 0
        darkCoverView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        darkCoverView.isUserInteractionEnabled = false
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(darkCoverView)
        darkCoverView.frame = mainWindow?.frame ?? .zero
    }

    fileprivate func setupPanGesture() {
        // Pan Gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }

    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)

        let velocity = gesture.velocity(in: view)

        if isMenuOpened {
            if abs(velocity.x) > velocityOpenThreshold {
                handleHide()
                return
            }
            if abs(translation.x) < menuWidth / 2 {
                handleOpen()
            } else {
                handleHide()
            }
        } else {
            if velocity.x > velocityOpenThreshold {
                handleOpen()
                return
            }
            if translation.x < menuWidth / 2 {
                handleHide()
            } else {
                handleOpen()
            }
        }
    }

    fileprivate func setupNavigationItems() {
        navigationItem.title = "Home"
        navigationItem.titleView?.backgroundColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(handleHide))
    }

    fileprivate func setupMenuController() {
        menuController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(menuController.view)
        addChild(menuController)
    }

    fileprivate func performAnimations(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.menuController.view.transform = transform
            //self.view.transform = transform
            self.navigationController?.view.transform = transform
            self.darkCoverView.transform = transform

            self.darkCoverView.alpha = transform == .identity ? 0 : 1
        }
    }
}

//MARK: - extensions

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
