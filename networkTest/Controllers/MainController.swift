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
  private func setupTableView() {
    tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
    tableView.register(AlbumCell.self, forCellReuseIdentifier: "AlbumCell")
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.top.equalTo(modeSelectionSegment.snp.bottom).offset(8)
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }

  private func setupModeSelectionSegment() {
    view.addSubview(modeSelectionSegment)
    modeSelectionSegment.snp.makeConstraints { (make) in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
    }
    modeSelectionSegment.selectedSegmentIndex = 1
  }

  fileprivate func setupUI() {
    view.backgroundColor = .white
    setupModeSelectionSegment()
    setupTableView()
  }

  private func setupBindings() {
    setupTableViewBindings()
    setupModeSelectionSegmentBindings()
  }

  private func setupModeSelectionSegmentBindings() {
    modeSelectionSegment.rx
      .selectedSegmentIndex
      .asObservable()
      .map(FetchTarget.init)
      .flatMap(ignoreNil)
      .subscribe(viewModel.modeSelectedSubject)
      .disposed(by: disposeBag)
  }

  private func setupTableViewBindings() {

    viewModel.cellViewModelsDriver
      .drive(tableView.rx.items) { tableView, row, viewModel in
        let cell = viewModel.either(ifLeft: { (albumViewModel) -> UITableViewCell in
          let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell") as! AlbumCell
          cell.configureWith(albumViewModel)
          return cell
        }, ifRight: { (postViewModel) -> UITableViewCell in
          let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
          cell.configureWith(postViewModel)
          return cell
        })
        return cell
      }.disposed(by: disposeBag)

    tableView.rx
      .modelSelected(Either<AlbumCellViewModelType, PostCellViewModelType>.self)
      .subscribe(viewModel.viewModelSelectedSubject)
      .disposed(by: disposeBag)

  }
}
