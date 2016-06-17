//
//  KolodaCardStorage.swift
//  Pods
//
//  Created by Eugene Andreyev on 3/30/16.
//
//

import Foundation
import UIKit

extension KolodaView {
    
    func createCardAtIndex(index: UInt, frame: CGRect? = nil) -> DraggableCardView {
        let cardView = generateCard(frame: frame ?? frameForTopCard())
        configureCard(card: cardView, atIndex: index)
        
        return cardView
    }
    
    func generateCard(frame: CGRect) -> DraggableCardView {
        let cardView = DraggableCardView(frame: frame)
        cardView.delegate = self
        
        return cardView
    }
    
    func configureCard(card: DraggableCardView, atIndex index: UInt) {
        let contentView = dataSource!.koloda(koloda: self, viewForCardAtIndex: index)
        card.configure(view: contentView, overlayView: dataSource?.koloda(koloda: self, viewForCardOverlayAtIndex: index))
    }
    
}
