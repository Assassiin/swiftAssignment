//
//  ViewController.swift
//  Assignment1
//
//  Created by Anshika Bhardwaj on 11/10/21.
//

import UIKit

// The following Theme code is part of one of the extra credit tasks.

typealias Emojis = [String]

/// Enum representing all the possible card themes.
enum Theme: Int {
  
  case Flags, Faces, Sports, Animals, Food, Appliances
  
  /// The color of the back of the card
  var cardColor: UIColor {
    switch self {
    case .Flags:
             return UIColor.black
      
    case .Faces:
      return UIColor.black
    case .Sports:
      return UIColor.black
      
    case .Animals:
      return UIColor.black
      
    case .Food:
      return UIColor.black
      
    case .Appliances:
      return UIColor.black
    }
  }
  
  /// The color of the background view
  var backgroundColor: UIColor {
    switch self {
    case .Flags:
      return UIColor.gray
      
    case .Faces:
      return UIColor.systemYellow
      
    case .Sports:
      return UIColor.lightGray
      
    case .Animals:
      return UIColor.systemGreen
      
    case .Food:
      return UIColor.systemPink
      
    case .Appliances:
             return UIColor.systemTeal
    }
  }
  
  /// The emojis used by this theme
  var emojis: Emojis {
    switch self {
    case .Flags:
      return ["🇧🇷", "🇧🇪", "🇯🇵", "🇨🇦", "🇺🇸", "🇵🇪", "🇮🇪", "🇦🇷"]
      
    case .Faces:
      return ["😀", "🙄", "😡", "🤢", "🤡", "😱", "😍", "🤠"]
      
    case .Sports:
      return ["🏀", "🏏", "⛹🏻‍♂️", "🏹", "🥊", "🏊", "🏸", "⛳️"]
      
    case .Animals:
      return ["🦊", "🐼", "🦁", "🐘", "🐓", "🦀", "🐷", "🦉"]
      
    case .Food:
      return ["🌮", "🧇", "🍟", "🍕", "🍔", "🥪", "🍜", "🍱"]
      
    case .Appliances:
      return ["💻", "🖥", "⌚️", "☎️", "🖨", "🖱", "📱", "⌨️"]
    }
  }
  
  /// The count of possible themes.
  static var count: Int {
    return Theme.Appliances.rawValue + 1
  }
  
  static func getRandom() -> Theme {
           return Theme(rawValue: Theme.count.arc4random)!
  }
  
}

class ViewController: UIViewController {
  
  /// The cards presented in the UI.
  @IBOutlet var cardButtons: [UIButton]!
  
  /// The UI label indicating the amount of flips.
  @IBOutlet weak var flipCountLabel: UILabel!
  
  /// The UI label indicating the player's score.
  
  @IBOutlet weak var scoreLabel: UILabel!
         
  /// The model encapsulating the concentration game's logic.
  private lazy var concentration = Connection(numberOfPairs: (cardButtons.count / 2))
  
  /// The randomly picked theme.
  /// The theme is chosen every time a new game starts.
  private var pickedTheme: Theme!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    chooseRandomTheme()
  }
  
  /// Action fired when a card button is tapped.
  /// It flips a card checks if there's a match or not.
  @IBAction func touchCard(_ sender: UIButton) {
           guard let index = cardButtons.firstIndex(of: sender) else { return }
    
      concentration.chooseCard(at: index)
    
    displayCards()
    displayLabels()
  }
  
  /// Action fired when the new game button is tapped.
  /// It resets the current game and refreshes the UI.
  @IBAction func didTapNewGame(_ sender: UIButton) {
    chooseRandomTheme()
    concentration.resetGame()
    displayCards()
    displayLabels()
  }
  
  /// The map between a card and the emoji used with it.
  /// This is the dictionary responsible for mapping
  /// which emoji is going to be displayed by which card.
  private var cardsAndEmojisMap = [Card : String]()
  
  /// Method used to randomly choose the game's theme.
  private func chooseRandomTheme() {
    pickedTheme = Theme.getRandom()
    view.backgroundColor = pickedTheme.backgroundColor
    
    cardsAndEmojisMap = [:]
    var emojis = pickedTheme.emojis
    
    for card in concentration.cards {
      if cardsAndEmojisMap[card] == nil {
               cardsAndEmojisMap[card] = emojis.remove(at: emojis.count.arc4random)
      }
    }
    
    displayCards()
  }
  
  /// Method used to refresh the scores and flips UI labels.
  private func displayLabels() {
    flipCountLabel.text = "Flips: \(concentration.flipsCount)"
    scoreLabel.text = "Score: \(concentration.score)"
  }
  
  /// Method in charge of displaying each card's state
  /// with the assciated card button.
  private func displayCards() {
    for (index, cardButton) in cardButtons.enumerated() {
      guard concentration.cards.indices.contains(index) else { continue }
      
      let card = concentration.cards[index]
      
      if card.isFaceUp {
        cardButton.setTitle(cardsAndEmojisMap[card], for: .normal)
               cardButton.backgroundColor = UIColor.white
      } else {
        cardButton.setTitle("", for: .normal)
               cardButton.backgroundColor = card.isMatched ? UIColor.darkGray : pickedTheme.cardColor
      }
    }
  }
  
}
