//
//  ChatroomMenuCell.swift
//  SlideOutMenu
//
//  Created by Sergio on 24.02.23.
//

import UIKit

class ChatroomMenuCell: UITableViewCell {

    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "selectColor")
        view.layer.cornerRadius = 5
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubview(bgView)
        bgView.fillSuperView(padding: .init(top: 0, left: 5, bottom: 0, right: 5))
        sendSubviewToBack(bgView)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        bgView.isHidden = !selected

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
