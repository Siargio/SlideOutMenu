//
//  ChatroomMenuContainerController.swift
//  SlideOutMenu
//
//  Created by Sergio on 24.02.23.
//

import UIKit

class ChatroomMenuContainerController: UIViewController {

    //MARK: - Property

    let chatroomGroups = ModelChat.modelChat
    var filteredResult = [[String]]()

    //MARK: - UIElements

    let viewSearch: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundSearchView")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    let rocketImage: UIImageView = {
        let image = UIImage(named: "air")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 3
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "backgroundColorForChat")
        tableView.register(MyCustomHeader.self,
                           forHeaderFooterViewReuseIdentifier: "sectionHeader")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        delegate()
        setupSearchBar()
        searchBar.delegate = self

        filteredResult = chatroomGroups
    }

    //MARK: - Setups

    private func setupHierarchy() {
        view.backgroundColor = UIColor(named: "backgroundColorForChat")
        view.addSubview(tableView)
        view.addSubview(viewSearch)
        viewSearch.addSubview(searchBar)
        viewSearch.addSubview(rocketImage)
    }

    private func setupSearchBar() {
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
                string: "Enter some filter",
                attributes: [.foregroundColor: UIColor.gray])
        } else {
            // Fallback on earlier versions
        }

        UIView.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .gray

        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .white
    }

    private func delegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension ChatroomMenuContainerController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let text = section == 0 ? "UNREADS" : section == 1 ? "CHANNELS" : "DERECT MESSAGES"

        let label = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! MyCustomHeader
        label.title.text = text
        return label
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredResult.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResult[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ChatroomMenuCell(style: .default, reuseIdentifier: nil)

        let text = filteredResult[indexPath.section][indexPath.row]
        cell.textLabel?.text = text
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)

        let attributedText = NSMutableAttributedString(
            string: "#  ",
            attributes:
                [.foregroundColor: UIColor(named: "textColorHeader") ?? "textColorHeader",
                 .font: UIFont.systemFont(ofSize: 18, weight: .regular)])

        attributedText.append(NSAttributedString(
            string: text,
            attributes: [.foregroundColor: UIColor.white]))

        cell.textLabel?.attributedText = attributedText

        return cell
    }
}

//MARK: - UISearchBarDelegate

extension ChatroomMenuContainerController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
            filteredResult = chatroomGroups
            tableView.reloadData()
            return
        }

        filteredResult = chatroomGroups.map({ (group) in
            return group.filter { $0.lowercased().contains(searchText.lowercased()
            )}
        })
        tableView.reloadData()
    }
}

//MARK: - SetupLayout

extension ChatroomMenuContainerController {

    func setupLayout() {
        NSLayoutConstraint.activate([
            viewSearch.topAnchor.constraint(equalTo: view.topAnchor),
            viewSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewSearch.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),

            rocketImage.leadingAnchor.constraint(equalTo: viewSearch.leadingAnchor, constant: 17),
            rocketImage.bottomAnchor.constraint(equalTo: viewSearch.bottomAnchor, constant: -8),
            rocketImage.heightAnchor.constraint(equalToConstant: 44),
            rocketImage.widthAnchor.constraint(equalToConstant: 44),

            searchBar.bottomAnchor.constraint(equalTo: viewSearch.bottomAnchor, constant: -4),
            searchBar.trailingAnchor.constraint(equalTo: viewSearch.trailingAnchor),
            searchBar.leadingAnchor.constraint(equalTo: rocketImage.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: viewSearch.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
