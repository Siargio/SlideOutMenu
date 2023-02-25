//
//  CustomMenuHeaderView.swift
//  SlideOutMenu
//
//  Created by Sergio on 23.02.23.
//

import UIKit

class CustomMenuHeaderView: UIView {

    //MARK: - UIElements
    let profileImageView: UIImageView = {
        let image = UIImage(named: "girlProfile")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 50 / 2
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Anastasia Horop"
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        return label
    }()

    let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "@Anastasia"
        return label
    }()

    let statsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "42 Following 7091 Followers"
        return label
    }()

    //MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        setupStackView()
        setupStatsAttributeText()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Setups

    fileprivate func setupStatsAttributeText() {
        statsLabel.font = UIFont.systemFont(ofSize: 14)

        let attributedText = NSMutableAttributedString(string: "42 ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium)])

        attributedText.append(NSAttributedString(string: "Following  ", attributes: [.foregroundColor: UIColor.black]))
        attributedText.append(NSAttributedString(string: "7091 ", attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .medium)]))
        attributedText.append(NSAttributedString(string: "Followers", attributes: [.foregroundColor: UIColor.black]))

        statsLabel.attributedText = attributedText
    }

    fileprivate func setupStackView() {
        let rightSpacerView = UIView()
        let arrangeSubviews = [
            //UIView(),
            UIStackView(arrangedSubviews: [profileImageView, rightSpacerView]),
            nameLabel,
            userNameLabel,
            SpacerView(space: 16),
            statsLabel
         ]
        let stackView = UIStackView(arrangedSubviews: arrangeSubviews)
        stackView.axis = .vertical
        stackView.spacing = 4

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        stackView.isLayoutMarginsRelativeArrangement = translatesAutoresizingMaskIntoConstraints
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 24, right: 24)

        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
