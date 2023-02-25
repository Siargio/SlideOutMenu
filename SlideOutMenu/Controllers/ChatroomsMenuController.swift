////
////  ChatroomsMenuController.swift
////  SlideOutMenu
////
////  Created by Sergio on 24.02.23.
////
//
//import UIKit
//
//class ChatroomsMenuController: UITableViewController {
//
//    //MARK: - Property
//
//    let chatroomGroups = ModelChat.modelChat
//
//    //MARK: - LifeCycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.backgroundColor = .purple
//        tableView.separatorStyle = .none
//
//        tableView.backgroundColor = UIColor(named: "backgroundColorForChat")
//        tableView.register(MyCustomHeader.self,
//               forHeaderFooterViewReuseIdentifier: "sectionHeader")
//    }
//
//    //MARK: - Setups
//
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let text = section == 0 ? "UNREADS" : section == 1 ? "CHANNELS" : "DERECT MESSAGES"
//
//        let label = tableView.dequeueReusableHeaderFooterView(withIdentifier:
//                       "sectionHeader") as! MyCustomHeader
//        label.title.text = text
//        return label
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return chatroomGroups.count
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return chatroomGroups[section].count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = ChatroomMenuCell(style: .default, reuseIdentifier: nil)
//
//        let text = chatroomGroups[indexPath.section][indexPath.row]
//        cell.textLabel?.text = text
//        cell.backgroundColor = .clear
//        cell.textLabel?.textColor = .white
//        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//
//        let attributedText = NSMutableAttributedString(string: "#  ", attributes: [.foregroundColor: UIColor(named: "textColorHeader") ?? "textColorHeader", .font: UIFont.systemFont(ofSize: 18, weight: .regular)])
//
//        attributedText.append(NSAttributedString(string: text, attributes: [.foregroundColor: UIColor.white]))
//
//        cell.textLabel?.attributedText = attributedText
//
//        cell.textLabel?.attributedText = attributedText
//        return cell
//    }
//}
