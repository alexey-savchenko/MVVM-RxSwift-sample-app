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
  let service: BasicNetworkService = BasicNetworkServiceImpl()

  // MARK: UI
  let tableView = UITableView()

  // MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }

    service
      .getResource(AlbumsResourse())
      .bind(to: tableView.rx.items) { tableView, row, model in
        let cell = UITableViewCell()
        cell.textLabel?.text = model.title
        return cell
      }
      .disposed(by: disposeBag)
  }
}

