

import UIKit

/// A special UIView displayed as a ring of color
public class SKCircleView: UIView {
    
    public var borderWidth: CGFloat = 1.0
    public var arcOffset: CGFloat = 1.0
    
    public var objCircle : [SKCircle] = [SKCircle]()
    public var centerTitle : String = ""
    public var centerTitleFont: UIFont = UIFont.systemFont(ofSize: 14.0)
    public var centerTitleColor: UIColor = .white
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    // Remove layer
    public func removeCircle() {
        self.objCircle.removeAll()
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }
    
    public func drawCircle() {
        self.drawRingFittingInsideView()
        self.addTitle()
    }
    
    private func drawRingFittingInsideView() -> () {
        let halfSize:CGFloat = min( self.bounds.size.width/2, self.bounds.size.height/2)
      
        
        var startAngle : CGFloat = 0.0
        for obj in objCircle {
            
            let endDegree = (obj.percentage / 100 ) * 360
            let minimumValue = (endDegree - arcOffset) <= 0 ? endDegree : (endDegree - arcOffset)
            let endAngle =  startAngle + (objCircle.count > 1 ? minimumValue : endDegree)
            
            let circlePath = UIBezierPath(
                arcCenter: CGPoint(x:halfSize,y:halfSize),
                radius: CGFloat( halfSize - (borderWidth/2) ),
                startAngle: CGFloat(startAngle * (CGFloat(Double.pi) / 180)),
                endAngle:CGFloat(endAngle * (CGFloat(Double.pi) / 180)),
                clockwise: true)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = obj.color.cgColor
            shapeLayer.lineWidth = borderWidth
            
            layer.addSublayer(shapeLayer)
            
            startAngle = startAngle + endDegree
        }
    
    }
    
    private func addTitle() {
        let halfSize:CGFloat = min( self.bounds.size.width/2, self.bounds.size.height/2)
        let textlayer = CXETextLayer()
        
        textlayer.anchorPoint = self.layer.anchorPoint
        textlayer.frame.size = CGSize(width: halfSize * 2, height: halfSize * 2)
        textlayer.alignmentMode = .center
        textlayer.isWrapped = true
        textlayer.truncationMode = .end
        
        textlayer.backgroundColor = UIColor.clear.cgColor
        textlayer.foregroundColor = self.centerTitleColor.cgColor
        textlayer.font = self.centerTitleFont
        textlayer.string = self.centerTitle
        
        layer.addSublayer(textlayer)
    }
}






