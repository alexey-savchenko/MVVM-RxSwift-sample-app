//
//  AlbumCellViewModel.swift
//  networkTest
//
//  Created by Alexey Savchenko on 24.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

protocol AlbumCellViewModelType {
  var title: String { get }
}

class AlbumCellViewModel: AlbumCellViewModelType {
  init(_ album: Album) {
    self.album = album
  }

  private let album: Album

  var title: String {
    return album.title
  }
}
