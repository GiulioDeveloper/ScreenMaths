//
//  SwiftUIView.swift
//  
//
//  Created by Giulio Ferraro on 17/11/20.
//

import SwiftUI

public
struct GraphShape: Shape {

    var scaling: (x: Double, y: Double) = (x: 1.0, y: 1.0)
    var traslation: (x: Double, y: Double) = (x: 0.0, y: 0.0)
    var pass: (min: Double, base: Double, max: Double) = (0.05, 0.1, 10.0)
    var precision = 1.0
    var function: Expression
    
    public init(scaling: (x: Double, y: Double) = (x: 1.0, y: 1.0), traslation: (x: Double, y: Double) = (x: 0.0, y: 0.0), pass: (min: Double, base: Double, max: Double) = (0.005, 0.1, 10.0), recalculateRelativeLimit: Double = 0.3, precision: Double = 1.0, function: Expression) {
        self.scaling = scaling
        self.traslation = traslation
        self.pass = pass
        self.precision = precision
        self.function = function
    }

    
    public func path(in rect: CGRect) -> Path {
        
        func findPoint(_ x: Double) -> (x: Double, y: Double)? {
            let actualX = process(x: x)
            let evaluation = function.evaluate(using: actualX)
            if evaluation.isFinite {
                return (x: actualX, y: process(y: evaluation))
            } else {
                return nil
            }
        }
        
        func process(x: Double) -> Double {
            (x  - traslation.x - Double(rect.width/2)) * scaling.x
        }
        
        func process(y: Double) -> Double {
            y * scaling.y + traslation.y + Double(rect.height/2)
        }
        
        
        return Path { p in
            var x: Double = 0
            var lastPoint: ((x: Double, y: Double), Bool)? = nil
            var passo = pass.base
            let height = Double(rect.height)
            loop: while x <= Double(rect.width) {
                if let point = findPoint(x) {
                    if let last = lastPoint {
                        if point.y > 0 && point.y < height {
                            if !last.1 {
                                guard passo == pass.min else {
                                    x = x - passo + pass.min
                                    passo = pass.min
                                    continue loop
                                }
                                p.move(to: CGPoint(x: x - passo, y: height - last.0.y))
                            }
                            let dy = abs(point.y - last.0.y)
                            let newPass = precision / dy
                            passo = (newPass < pass.min) ? pass.min : ((newPass > pass.max) ? pass.max : newPass )
                            lastPoint = (point, true)
                            p.addLine(to: CGPoint(x: x, y: height - point.y))
                        } else {
                            if last.1 {
                                p.addLine(to: CGPoint(x: x, y: height - point.y))
                            }
                            passo = pass.base
                            lastPoint = (point, false)
                        }
                    } else {
                        if point.y > 0 && point.y < height {
                            guard passo == pass.min else {
                                x = x - passo + pass.min
                                passo = pass.min
                                continue loop
                            }
                            p.move(to: CGPoint(x: x, y: height - point.y))
                            lastPoint = (point, true)
                        } else {
                            passo = pass.base
                            lastPoint = (point, false)
                        }
                    }
                } else {
                    passo = pass.base
                    lastPoint = nil
                }
                x += passo
            }
        }
    }
    
}

struct GraphShape_Previews: PreviewProvider {
    static var previews: some View {
        
        let input = " 1 / x "
        let parsed = TextParser(input: input).parse()
        var expression: Expression? = nil
        if case .success(let value) = parsed {
            expression = value
        }
        
        return GraphShape(scaling: (x: 0.05, y: 40), traslation: (x: 100, y: 50), function: expression!)
            .stroke(lineWidth: 2.0)
            .frame(width: 600, height: 500, alignment: .center)
    }
}
