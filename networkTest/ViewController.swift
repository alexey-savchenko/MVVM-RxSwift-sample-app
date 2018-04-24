//
//  ViewController.swift
//  networkTest
//
//  Created by Alexey Savchenko on 23.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class MainController: UIViewController {

  // MARK: Init and deinit
  init(_ viewModel: MainControllerViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  deinit {
    print("\(self) dealloc")
  }
  
  // MARK: Properties
  let viewModel: MainControllerViewModelType
  let disposeBag = DisposeBag()

  // MARK: UI
  let tableView = UITableView()
  let modeSelectionSegment = UISegmentedControl(items: ["Albums", "Posts"])

  // MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupBindings()
  }

  // MARK: Functions
  fileprivate func setupTableView() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.top.equalTo(modeSelectionSegment.snp.bottom).offset(8)
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }

  fileprivate func setupModeSelectionSegment() {
    view.addSubview(modeSelectionSegment)
    modeSelectionSegment.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(8)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
    }
  }

  fileprivate func setupUI() {
    view.backgroundColor = .white
    setupModeSelectionSegment()
    setupTableView()
  }

  func setupBindings() {
    setupTableViewBindings()
    setupModeSelectionSegmentBindings()
  }

  func setupModeSelectionSegmentBindings() {
    modeSelectionSegment.rx
      .selectedSegmentIndex
      .asObservable()
      .map(FetchTarget.init)
      .flatMap(ignoreNil)
      .subscribe(viewModel.modeSelectedSubject)
      .disposed(by: disposeBag)
  }

  func setupTableViewBindings() {
    // TODO: Implment

  }
}
