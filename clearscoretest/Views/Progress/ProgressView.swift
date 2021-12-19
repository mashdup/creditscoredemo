//
//  ProgressView.swift
//  clearscoretest
//
//  Created by Dillon Hoa on 19/12/2021.
//

import UIKit

class ProgressView: UIView {
    
    var progress: CGFloat = 0.48 {
        didSet {
            setProgress(progress)
        }
    }
    
    private var progressColour: CGColor {
        switch progress {
        case -CGFloat.greatestFiniteMagnitude..<0.33: return UIColor.red.cgColor
        case 0.33..<0.66: return UIColor.systemYellow.cgColor
        case 0.66 ..< CGFloat.greatestFiniteMagnitude: return UIColor.green.cgColor
        default: return UIColor.red.cgColor
        }
    }
    
    private var progressLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let circularPath = UIBezierPath(
            arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
            radius: (bounds.height > bounds.width ? bounds.width/2 : bounds.height/2) - progressLayer.lineWidth/2,
            startAngle: -.pi / 2, endAngle: 3 * .pi / 2,
            clockwise: true)
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = progressColour
    }
    
    func setup() {
        progressLayer.lineCap = .round
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 4
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = progressColour
//        progressLayer.shadowColor = UIColor.black.cgColor
        progressLayer.shadowOpacity = 0.2
        progressLayer.shadowRadius = 4
        progressLayer.shadowOffset = CGSize(width: 0, height: 0)
        layer.addSublayer(progressLayer)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalTo: widthAnchor),
            widthAnchor.constraint(greaterThanOrEqualToConstant: 64)
        ])
        setProgress(progress)
    }
    
    func setProgress(_ progress: CGFloat, with duration: TimeInterval = 0.3, animated: Bool = true) {
        
        CATransaction.begin()
        CATransaction.disableActions()
        progressLayer.strokeEnd = progress
        progressLayer.strokeColor = progressColour
        CATransaction.commit()
        if animated {
            
            let anim = CABasicAnimation(keyPath: "strokeEnd")
            anim.duration = duration
            anim.toValue = progress
            anim.fillMode = .forwards
            anim.isRemovedOnCompletion = true
            progressLayer.add(anim, forKey: "progressAnim")
        }
    }
}
