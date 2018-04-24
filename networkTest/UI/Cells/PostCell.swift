//
//  PostCell.swift
//  networkTest
//
//  Created by Alexey Savchenko on 24.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

  private let titleLabel = UILabel()
  private let bodyLabel = UILabel()
  private let labelsStackView = UIStackView()

  override func layoutSubviews() {
    super.layoutSubviews()
    guard contentView.subviews.isEmpty else {
      return
    }
    setupLabels()
    layoutUI()
  }

  private func layoutUI() {
    [titleLabel, bodyLabel].forEach {
      labelsStackView.addArrangedSubview($0)
    }
    contentView.addSubview(labelsStackView)
    labelsStackView.alignment = .fill
    labelsStackView.axis = .vertical
    labelsStackView.distribution = .fillProportionally
    labelsStackView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }

  private func setupLabels() {
    [titleLabel, bodyLabel].forEach {
      $0.numberOfLines = 0
      $0.textAlignment = NSTextAlignment.justified
    }

    titleLabel.font = UIFont.boldSystemFont(ofSize: 27)
    bodyLabel.font = UIFont.systemFont(ofSize: 17)
  }

  func configureWith(_ viewModel: PostCellViewModelType) {
    titleLabel.text = viewModel.title
    bodyLabel.text = viewModel.body
  }
}
