//
//  CommentCell.swift
//  networkTest
//
//  Created by Alexey Savchenko on 25.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

final class CommentCell: UITableViewCell {

  // MARK: UI
  private let nameLabel = UILabel()
  private let emailLabel = UILabel()
  private let bodyLabel = UILabel()
  private let contentStackView = UIStackView()

  // MARK: Functions
  override func layoutSubviews() {
    super.layoutSubviews()
    guard contentView.subviews.isEmpty else {
      return
    }
    configureLabels()
    layoutUI()
  }

  private func layoutUI() {
    contentView.addSubview(contentStackView)
    [nameLabel, emailLabel, bodyLabel].forEach {
      contentStackView.addArrangedSubview($0)
    }
    contentStackView.snp.makeConstraints { (make) in
      make.leading.equalToSuperview().offset(20)
      make.top.equalToSuperview().offset(20)
      make.bottom.equalToSuperview().offset(-20)
      make.trailing.equalToSuperview().offset(-20)
    }
    contentStackView.axis = .vertical
    contentStackView.alignment = .fill
    contentStackView.distribution = .fillProportionally
    contentStackView.spacing = 8
  }

  private func configureLabels() {
    [nameLabel, emailLabel, bodyLabel].forEach {
      $0.numberOfLines = 0
    }
    nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
    emailLabel.font = UIFont.systemFont(ofSize: 14)
    bodyLabel.font = UIFont.systemFont(ofSize: 20)
  }

  func fillWith(_ viewModel: CommentCellViewModelType) {
    nameLabel.text = viewModel.name
    bodyLabel.text = viewModel.body
    emailLabel.text = viewModel.email
    layoutIfNeeded()
  }
}
