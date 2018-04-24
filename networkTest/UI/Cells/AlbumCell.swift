//
//  AlbumCell.swift
//  networkTest
//
//  Created by Alexey Savchenko on 24.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {

  private let titleLabel = UILabel()

  override func layoutSubviews() {
    super.layoutSubviews()
    guard contentView.subviews.isEmpty else {
      return
    }
    setupLabel()
    layoutUI()
  }

  private func setupLabel() {
    titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
    titleLabel.numberOfLines = 0
  }

  private func layoutUI() {
    contentView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { (make) in
      make.bottom.equalToSuperview().offset(-8)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
      make.top.equalToSuperview().offset(36)
    }
  }

  func configureWith(_ viewModel: AlbumCellViewModelType) {
    titleLabel.text = viewModel.title
    layoutIfNeeded()
  }
}
