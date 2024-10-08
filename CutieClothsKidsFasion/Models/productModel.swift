 
import Foundation
import SwiftUI

 
struct Product: Identifiable, Equatable {
    var id = UUID()
    var imageName: String
    var name: String
    var price: String
    var description: String
    var productname: String
    
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}




var days: [String] = ["Wednesday", "Tuesday", "Monday"]

extension Double
{
    static func remap(from: Double, fromMin: Double, fromMax: Double, toMin: Double, toMax: Double) -> Double
    {
        let fromAbs: Double  =  from - fromMin
        let fromMaxAbs: Double = fromMax - fromMin
        let normal: Double = fromAbs / fromMaxAbs
        let toMaxAbs = toMax - toMin
        let toAbs: Double = toMaxAbs * normal
        var to: Double = toAbs + toMin
        
        to = abs(to)
        
        // Clamps it
        if to < toMin { return toMin }
        if to > toMax { return toMax }
       
        return to
    }
}


