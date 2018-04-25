//
//  PhotosResource.swift
//  networkTest
//
//  Created by Alexey Savchenko on 25.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

class PhotosResource: Resource<[Photo]> {
  convenience init(albumID: Int) {
    self.init(action: AdvancedAction.photos(albumID: albumID)) { (dataResponse) -> Observable<[Photo]> in
      return Observable.create { observer in
        switch dataResponse.result {
        case .success(let value):
          let result = JSON(value).arrayValue.map(Photo.init)
          observer.onNext(result)
        case .failure(let error):
          observer.onError(error)
        }
        return Disposables.create()
      }
    }
  }
}
