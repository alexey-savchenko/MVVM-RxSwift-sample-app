//
//  PostController.swift
//  networkTest
//
//  Created by Alexey Savchenko on 25.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit
import RxSwift

final class CommentsController: UIViewController {

  // MARK: Init and deinit
  init(_ viewModel: CommentsControllerViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  deinit {
    print("\(self) dealloc")
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: UI
  let tableView = UITableView()

  // MARK: Properties
  private let viewModel: CommentsControllerViewModelType
  private let disposeBag = DisposeBag()

  // MARK: Functions

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindToViewModel()
  }
  private func bindToViewModel() {
    viewModel.viewModelsDriver
      .drive(tableView.rx.items) { tableView, row, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        cell.fillWith(item)
        return cell
      }.disposed(by: disposeBag)
  }

  private func setupUI() {
    view.backgroundColor = .white
    view.addSubview(tableView)

    tableView.snp.makeConstraints { (make) in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
    tableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 100
    tableView.allowsSelection = false
  }

}
