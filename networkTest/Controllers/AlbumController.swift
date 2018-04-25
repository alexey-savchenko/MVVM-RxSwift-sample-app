//
//  AlbumController.swift
//  networkTest
//
//  Created by Alexey Savchenko on 25.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

final class AlbumController: UIViewController {

  // MARK: Init and deinit
  init(_ viewModel: AlbumControllerViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  deinit {
    print("\(self) dealloc")
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Properties
  private let viewModel: AlbumControllerViewModelType

  // MARK: UI
  private let textLabel = UILabel()

  // MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    fillWith(viewModel)
  }

  // MARK: Functions
  private func fillWith(_ viewModel: AlbumControllerViewModelType) {
    
  }

  private func setupUI() {
    view.backgroundColor = .white
    view.addSubview(textLabel)

    textLabel.snp.makeConstraints { (make) in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(26)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
    }

    textLabel.font = UIFont.boldSystemFont(ofSize: 36)
  }
  
}
