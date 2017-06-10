//
//  Shuffle.swift
//  Drag and Drop Example
//
//  Created by Agnieszka Patalas on 10.06.2017.
//  Copyright © 2017 Agnieszka Patalas. All rights reserved.
//

import Foundation

extension Array {
  func shuffled() -> [Element] {
    if count < 2 { return self }
    var list = self
    for i in 0..<(list.count - 1) {
      let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
      list.swapAt(i, j)
    }
    return list
  }
}
