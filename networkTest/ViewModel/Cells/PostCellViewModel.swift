//
//  PostCellViewModelType.swift
//  networkTest
//
//  Created by Alexey Savchenko on 24.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

protocol PostCellViewModelType {
  var id: Int { get }
  var title: String { get }
  var body: String { get }
}

struct PostCellViewModel: PostCellViewModelType {
  init(_ post: Post) {
    self.post = post
  }

  private let post: Post

  var id: Int {
    return post.id
  }
  var title: String {
    return post.title
  }
  var body: String {
    return post.body
  }
}
