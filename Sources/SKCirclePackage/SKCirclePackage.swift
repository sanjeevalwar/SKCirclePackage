

import UIKit

public struct SKCircle {
 
    public var percentage: CGFloat
    public var color: UIColor
    public var barTitle: String
    
    
    public init(percentage: CGFloat, color: UIColor, barTitle: String) {
        self.percentage = percentage
        self.color = color
        self.barTitle = barTitle
    }
}

/// A special UIView displayed as a ring of color
public class Ring: UIView {
    
    public var objCircle: [SKCircle] = [SKCircle](){
        didSet {
            self.drawRingFittingInsideView()
        }
    }
    public var title: String = "" {
        didSet{
            self.addTitle()
        }
    }
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    internal func drawRingFittingInsideView() -> () {
        let halfSize:CGFloat = min( self.bounds.size.width/2, self.bounds.size.height/2)
        let desiredLineWidth:CGFloat = 1 // your desired value
        
        var startAngle : CGFloat = 0.0
        for obj in objCircle {
            
            let endAngle = startAngle + (obj.percentage / 100 ) * 360
            
            let circlePath = UIBezierPath(
                    arcCenter: CGPoint(x:halfSize,y:halfSize),
                    radius: CGFloat( halfSize - (desiredLineWidth/2) ),
                    startAngle: CGFloat(startAngle * (CGFloat(Double.pi) / 180)),
                endAngle:CGFloat(endAngle * (CGFloat(Double.pi) / 180)),
                    clockwise: true)
        
             let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
                
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = obj.color.cgColor
             shapeLayer.lineWidth = desiredLineWidth
        
             layer.addSublayer(shapeLayer)
            
            startAngle = endAngle
        }
        
      //  self.layer.addSublayer(label.layer)
     }
    
    func addTitle() {
        let halfSize:CGFloat = min( self.bounds.size.width/2, self.bounds.size.height/2)
        let textlayer = CXETextLayer()

        textlayer.anchorPoint = self.layer.anchorPoint
        textlayer.frame.size = CGSize(width: halfSize * 2, height: halfSize * 2)
       // textlayer.frame = CGRect(x: 0, y: 0, width: halfSize, height: halfSize)
        textlayer.fontSize = 24
        textlayer.alignmentMode = .center
        textlayer.string = self.title
        textlayer.isWrapped = true
        textlayer.truncationMode = .end
        textlayer.backgroundColor = UIColor.clear.cgColor
        textlayer.foregroundColor = UIColor.black.cgColor

        layer.addSublayer(textlayer)
    }
    
    
    
}

class VerticallyCenteredTextLayer: CATextLayer {
    var invertedYAxis: Bool = true

    override func draw(in ctx: CGContext) {
        guard let text = string as? NSString, let font = self.font as? UIFont else {
            super.draw(in: ctx)
            return
        }

        let attributes = [NSAttributedString.Key.font: font]
        let textSize = text.size(withAttributes: attributes)
        var yDiff = (bounds.height - textSize.height) / 2
        if !invertedYAxis {
            yDiff = -yDiff
        }
        ctx.saveGState()
        ctx.translateBy(x: 0.0, y: yDiff)
        super.draw(in: ctx)
        ctx.restoreGState()
    }
}


class CXETextLayer : CATextLayer {

override init() {
    super.init()
}

override init(layer: Any) {
    super.init(layer: layer)
}

required init(coder aDecoder: NSCoder) {
    super.init(layer: aDecoder)
}

override func draw(in ctx: CGContext) {
    let height = self.bounds.size.height
    let fontSize = self.fontSize
    let yDiff = (height-fontSize)/2 - fontSize/10

    ctx.saveGState()
    ctx.translateBy(x: 0.0, y: yDiff)
    super.draw(in: ctx)
    ctx.restoreGState()
}
}

