//
//  Either.swift
//  networkTest
//
//  Created by Alexey Savchenko on 24.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

enum Either<T, U> {
  case left(T)
  case right(U)

  public func either<Result>(ifLeft: (T) throws -> Result, ifRight: (U) throws -> Result) rethrows -> Result {
    switch self {
    case let .left(x):
      return try ifLeft(x)
    case let .right(x):
      return try ifRight(x)
    }
  }

  /// Maps `Right` values with `transform`, and re-wraps `Left` values.
  public func map<V>(_ transform: (U) -> V) -> Either<T, V> {
    return flatMap { .right(transform($0)) }
  }

  /// Returns the result of applying `transform` to `Right` values, or re-wrapping `Left` values.
  public func flatMap<V>(_ transform: (U) -> Either<T, V>) -> Either<T, V> {
    return either(
      ifLeft: Either<T, V>.left,
      ifRight: transform)
  }

  /// Maps `Left` values with `transform`, and re-wraps `Right` values.
  public func mapLeft<V>(_ transform: (T) -> V) -> Either<V, U> {
    return flatMapLeft { .left(transform($0)) }
  }

  /// Returns the result of applying `transform` to `Left` values, or re-wrapping `Right` values.
  public func flatMapLeft<V>(_ transform: (T) -> Either<V, U>) -> Either<V, U> {
    return either(
      ifLeft: transform,
      ifRight: Either<V, U>.right)
  }

  /// Maps `Left` values with `left` & maps `Right` values with `right`.
  public func bimap<V, W>(leftBy lf: (T) -> V, rightBy rf: (U) -> W) -> Either<V, W> {
    return either(
      ifLeft: { .left(lf($0)) },
      ifRight: { .right(rf($0)) })
  }
}
