//
//  GradientView.swift
//  MemoryGame
//
//  Created by user196210 on 5/1/21.
//

import UIKit
@IBDesignable
class GradientView: UIView {

    @IBInspectable var FirstColor: UIColor = UIColor.clear {
        didSet {
            updateView();
        }
    }
    @IBInspectable var SecoundColor: UIColor = UIColor.clear {
        didSet {
            updateView();
        }
    }
    
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [FirstColor.cgColor, SecoundColor.cgColor]
    }
}
