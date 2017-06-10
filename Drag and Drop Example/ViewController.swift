//
//  ViewController.swift
//  Drag and Drop Example
//
//  Created by Agnieszka Patalas on 10.06.2017.
//  Copyright © 2017 Agnieszka Patalas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let animals = ["🐯", "🐵", "🦉", "🐨"]
  let veggies = ["🍅", "🥕", "🥒", "🥔"]
  
  var labels = [UILabel]()
  
  @IBOutlet weak var bottomStack: UIStackView!
  @IBOutlet weak var topStack: UIStackView!
  
  @IBOutlet weak var animalsStack: UIStackView!
  @IBOutlet weak var veggiesStack: UIStackView!
  
  @IBOutlet weak var feedback: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addInteraction(UIDropInteraction(delegate: self))
    refresh()
    
  }
  
  func shuffle() -> [String] {
    let all = animals + veggies
    return all.shuffled()
  }
  
  func cleanViews() {
    labels.removeAll()
    topStack.clean()
    bottomStack.clean()
    animalsStack.clean()
    veggiesStack.clean()
    feedback.text = nil
  }

  @IBAction func refresh() {
    cleanViews()
    
    let shuffled = shuffle()
    for item in shuffled {
      let lbl = emojiLabel(item)
      lbl.isUserInteractionEnabled = true
      let dragInteraction = UIDragInteraction(delegate: self)
      lbl.addInteraction(dragInteraction)
      labels.append(lbl)
      
      let stack = shuffled.index(of: item)! % 2 == 0 ? topStack : bottomStack
      stack!.addArrangedSubview(lbl)
    }
  }
  
  func validate() {
    let animalAnswers = animalsStack.arrangedSubviews.map { ($0 as! UILabel).text }
    for answer in animalAnswers {
      if let answer = answer, !animals.contains(answer) {
        feedback.text = "Something is wrong! ❌"
        return
      }
    }
    
    let veggieAnswers = veggiesStack.arrangedSubviews.map { ($0 as! UILabel).text }
    for answer in veggieAnswers {
      if let answer = answer, !veggies.contains(answer) {
        feedback.text = "Something is wrong! ❌"
        return
      }
    }
    
    feedback.text = "Good job! ✅"
  }
  
}

func emojiLabel(_ emoji: String) -> UILabel {
  let label = UILabel()
  label.font = label.font.withSize(35)
  label.text = emoji
  label.textAlignment = .center
  return label
}

extension UIView {
  func clean() {
    for view in subviews {
      view.removeFromSuperview()
    }
  }
}
