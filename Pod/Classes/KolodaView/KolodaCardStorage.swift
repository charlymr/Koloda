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
        
        UIView.animateWithDuration(0.3, animations: {
            self.transform = CGAffineTransformMakeTranslation(0, self.bounds.size.height)
            
            }, completion: { (_) in
                completion?(true)
                
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: .CurveEaseInOut, animations: {
                    self.transform = CGAffineTransformIdentity
                    }, completion: nil)
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
        } else {
            addSubview(cardView)
            sendSubviewToBack(cardView)
        }
        cardView.configure(content, overlayView: nil)
        
        cardView.transform = CGAffineTransformMakeTranslation(0, cardView.bounds.size.height*2)
        
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.8, options: .CurveEaseInOut, animations: {
            cardView.transform = CGAffineTransformIdentity
            }, completion: { (finished) in
                completion?(finished)
                UIView.animateWithDuration(0.3, animations: {
                    cardView.alpha = 0
                    }, completion: { (_) in
                        cardView.removeFromSuperview()
                        self.addCardAnimating = false
                })
        })
        
        
        
    }
    
}