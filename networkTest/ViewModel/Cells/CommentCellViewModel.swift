//
//  CommentCellViewModel.swift
//  networkTest
//
//  Created by Alexey Savchenko on 25.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

protocol CommentCellViewModelType {
  var name: String { get }
  var body: String { get }
  var email: String { get }
}

struct CommentCellViewModel: CommentCellViewModelType {

  init(_ comment: Comment) {
    self.comment = comment
  }

  private let comment: Comment

  var name: String {
    return comment.name
  }

  var body: String {
    return comment.body
  }

  var email: String {
    return comment.email
  }
}
