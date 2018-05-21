//
//  Utility.swift
//  networkTest
//
//  Created by Alexey Savchenko on 24.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import RxSwift

func ignoreNil<A>(x: A?) -> Observable<A> {
  return x.map { Observable.just($0) } ?? Observable.empty()
}
