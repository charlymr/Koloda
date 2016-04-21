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
        let cardView = generateCard(frame ?? frameForTopCard())
        configureCard(cardView, atIndex: index)
        
        return cardView
    }
    
    func generateCard(frame: CGRect) -> DraggableCardView {
        let cardView = DraggableCardView(frame: frame)
        cardView.delegate = self
        
        return cardView
    }
    
    func configureCard(card: DraggableCardView, atIndex index: UInt) {
        let contentView = dataSource!.koloda(self, viewForCardAtIndex: index)
        
        card.configure(contentView, overlayView: dataSource?.koloda(self, viewForCardOverlayAtIndex: index))
    }
    
}

extension KolodaView {
    
    //MARK: Drop Card

    public func dropTopCard(completion: ((Bool) -> Void)?) {
        
        let cardView = generateCard(frameForTopCard())
        animator.applyDropRemovalAnimation([cardView], completion: { (success) in
            completion?(success)
        })

    }
    
    //MARK: Add Card
    
    public func animateEntryCard(content: KolodaView, background: Bool, completion: ((Bool) -> Void)?) {
        
        if addCardAnimating == true {
            completion?(false)
        }
        addCardAnimating = true
        
        let cardView = generateCard(frameForTopCard())

        if let superview = superview where background == false {
            cardView.frame = self.frame
            superview.addSubview(cardView)
            
        } else if let superview = superview {
            superview.addSubview(cardView)
            sendSubviewToBack(cardView)
        }
        cardView.configure(content, overlayView: nil)
        
        
        animator.applyJumpInsertionAnimation([cardView], completion: { (success) in
            self.addCardAnimating = false
        })
        
    }
    
}