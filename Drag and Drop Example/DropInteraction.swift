//
//  DropInteraction.swift
//  Drag and Drop Example
//
//  Created by Agnieszka Patalas on 10.06.2017.
//  Copyright © 2017 Agnieszka Patalas. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UIDropInteractionDelegate {
  
  func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
    return session.localDragSession != nil && session.canLoadObjects(ofClass: NSString.self)
  }
  
  func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
    return UIDropProposal(operation: .move)
  }
  
  func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
    session.loadObjects(ofClass: NSString.self) { [weak self] items in
      guard let this = self, let textItems = items as? [NSString], let emoji = textItems.first else { return }
      let emojiString = emoji as String
      
      let dropLocation = session.location(in: interaction.view)
      guard let stackView = this.view.hitTest(dropLocation, with: nil) as? UIStackView else { return }
      stackView.addArrangedSubview(emojiLabel(emojiString))
      
      guard let emojiLabel = this.labels.first(where: { $0.text == emojiString }) else { return }
      emojiLabel.removeFromSuperview()
      if this.topStack.subviews.count == 0 && this.bottomStack.subviews.count == 0 {
        this.validate()
      }
    }
  }
}
