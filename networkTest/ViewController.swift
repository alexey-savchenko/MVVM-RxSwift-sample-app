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

class ViewController: UIViewController {

  let disposeBag = DisposeBag()
  let service: BasicNetworkService = BasicNetworkServiceImpl()
  let tableView = UITableView()

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

