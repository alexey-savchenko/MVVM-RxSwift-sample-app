//
//  PhotoCell.swift
//  networkTest
//
//  Created by Alexey Savchenko on 25.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

  // MARK: UI
  let thumbnailImageView = UIImageView()
  let titleLabel = UILabel()
  let contentStackView = UIStackView()

  // MARK: Functions
  override func layoutSubviews() {
    super.layoutSubviews()
    guard contentView.subviews.isEmpty else {
      return
    }
    configureLabel()
    layoutUI()
  }

  private func layoutUI() {
    contentView.addSubview(contentStackView)
    [titleLabel, thumbnailImageView].forEach {
      contentStackView.addArrangedSubview($0)
    }
    contentStackView.snp.makeConstraints { (make) in
      make.leading.equalToSuperview().offset(20)
      make.top.equalToSuperview().offset(20)
      make.bottom.equalToSuperview().offset(-20)
      make.trailing.equalToSuperview().offset(-20)
    }
    contentStackView.axis = .horizontal
    contentStackView.alignment = .fill
    contentStackView.distribution = .fillProportionally
  }

  private func configureLabel() {
    titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
  }

  func fillWith(_ viewModel: PhotoCellViewModelType) {
    titleLabel.text = viewModel.title
    layoutIfNeeded()
  }
}
