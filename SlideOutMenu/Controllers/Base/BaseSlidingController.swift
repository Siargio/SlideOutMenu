//
//  BaseSlidingController.swift
//  SlideOutMenu
//
//  Created by Sergio on 23.02.23.
//

import UIKit

class RightContainerView: UIView {}
class MenuContainerView: UIView {}
class DarkCoverView: UIView {}

class BaseSlidingController: UIViewController {

    //MARK: - Property

    var rightViewController: UIViewController = UINavigationController(rootViewController: HomeController())
    let menuController = ChatroomMenuContainerController()
    var redViewLeadingConstraint: NSLayoutConstraint!
    var redViewTrailingConstraint: NSLayoutConstraint!
    fileprivate let menuWidth: CGFloat = 300
    fileprivate let velocityOpenThreshold: CGFloat = 500
    fileprivate var isMenuOpened = false

    //MARK: - UIElements
    
    let redView: RightContainerView = {
        let view = RightContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let blueView: MenuContainerView = {
        let view = MenuContainerView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let darkCoverView: DarkCoverView = {
        let view = DarkCoverView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss))
        darkCoverView.addGestureRecognizer(tapGesture)
    }

    //MARK: - Setups

    private func setupHierarchy() {
        view.addSubview(redView)
        view.addSubview(blueView)
    }

    @objc func handleTapDismiss() {
        closeMenu()
    }

    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var x = translation.x

        x = isMenuOpened ? x + menuWidth : x
        x = min(menuWidth, x)
        x = max(0, x)

        redViewLeadingConstraint.constant = x
        redViewTrailingConstraint.constant = x
        darkCoverView.alpha = x / menuWidth

        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }

    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)

        if isMenuOpened {
            if abs(velocity.x) > velocityOpenThreshold {
                closeMenu()
                return
            }
            if abs(translation.x) < menuWidth / 2 {
                openMenu()
            } else {
                closeMenu()
            }
        } else {
            if velocity.x > velocityOpenThreshold {
                openMenu()
                return
            }
            if translation.x < menuWidth / 2 {
                closeMenu()
            } else {
                openMenu()
            }
        }
    }

    func openMenu() {
        isMenuOpened = true
        redViewLeadingConstraint.constant = menuWidth
        redViewTrailingConstraint.constant = menuWidth
        performAnimations()
        setNeedsStatusBarAppearanceUpdate()
    }

    func closeMenu() {
        redViewLeadingConstraint.constant = 0
        redViewTrailingConstraint.constant = 0
        isMenuOpened = false
        performAnimations()
        setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isMenuOpened ? .lightContent : .default
    }

    func didSelectMenuItem(indexPath: IndexPath) {
        preformRightViewCleanUp()
        closeMenu()

        switch indexPath.row {
        case 0:
            rightViewController = UINavigationController(rootViewController: HomeController())
        case 1:
            rightViewController = UINavigationController(rootViewController: ListController())
        case 2:
            rightViewController = BookmarksController()
        default:
            print("fafaf")
        }

        redView.addSubview(rightViewController.view)
        addChild(rightViewController)

        // НЕРАБОТАЕТ
        redView.bringSubviewToFront(darkCoverView)
    }

    fileprivate func   preformRightViewCleanUp() {
        rightViewController.view.removeFromSuperview()
        rightViewController.removeFromParent()
    }

    fileprivate func performAnimations() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {

            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpened ? 1 : 0
        }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            blueView.topAnchor.constraint(equalTo: view.topAnchor),
            blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: menuWidth)
        ])

        redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        redViewLeadingConstraint.isActive = true

        redViewTrailingConstraint = redView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        redViewTrailingConstraint.isActive = true

        setupViewControllers()
    }

    private func setupViewControllers() {
        let homeView = rightViewController.view!
        let menuView = menuController.view!

        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        redView.addSubview(homeView)
        blueView.addSubview(menuView)

        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: redView.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            homeView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            homeView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),

            menuView.topAnchor.constraint(equalTo: blueView.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            menuView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor),
            menuView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor)
        ])

        addChild(rightViewController)
        addChild(menuController)
    }
}
