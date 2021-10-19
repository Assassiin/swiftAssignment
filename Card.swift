//
//  Card.swift
//  Assignment1
//
//  Created by Anshika Bhardwaj on 13/10/21.
//

import Foundation

struct Card {
  
  /// The card's identifier.
  /// Used to check for a match.
  private let identifier: Int
  
  /// Determines if the card has already been matched.
  var isMatched = false
  
  /// Indicates whether the card is faced up or not.
  var isFaceUp = false
  
  /// Indicates if the card has already been flipped.
  /// Might be used in a score system.
  var hasBeenFlipped = false
  
  /// Prepares a card with a brand new identifier.
  init() {
    identifier = Card.makeIdentifier()
  }
  
  /// Toggles the flipped state of the card.
  /// If it's face up, set it face down, and vice versa.
  mutating func flipCard() {
    isFaceUp = !isFaceUp
  }
  
  /// Flips a card to the face down state.
  mutating func setFaceDown() {
    if isFaceUp {
      isFaceUp = false
    }
  }
  
  /// The identifier count, used to retrieve an
  /// identifier for each initialized card.
  private static var identifiersCount = -1
  
  /// Resets the current identifier count.
  static func resetIdentifiersCount() {
    identifiersCount = -1
  }
  
  /// Returns a new identifier for model usage.
  static func makeIdentifier() -> Int {
    identifiersCount += 1
    return identifiersCount
  }

}

extension Card: Hashable {
  
  var hashValue: Int {
    return identifier
  }
  
  static func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.identifier == rhs.identifier
  }
}
