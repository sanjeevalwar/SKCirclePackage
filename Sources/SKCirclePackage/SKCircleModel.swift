//
//  File.swift
//  
//
//  Created by Sanjeev Kumar on 06/10/21.
//

import Foundation
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
