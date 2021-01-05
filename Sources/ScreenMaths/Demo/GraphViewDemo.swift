//
//  SwiftUIView.swift
//  
//
//  Created by Giulio Ferraro on 19/11/20.
//

import SwiftUI

public struct GraphViewDemo: View {
    
    @State var input: String = ""
    
    func parse() -> Expression? {
        let parsed = TextParser(input: input).parse()
        if case .success(let value) = parsed {
            return value
        } else {
            return nil
        }
    }
    
    @State var lastOffset = (0.0, 0.0)
    @State var traslation = (0.0, 0.0)
    @State var scaling = (0.1, 10.0)
    @State var spacing = 40.0
    @State var min = 1.0
    @State var max = 1.0
    @State var base = 1.0
    
    public var body: some View {
        ZStack {
            
            Group {
                
                GridShape(horizontalSpacing: Int(spacing), verticalSpacing: Int(spacing),traslation: (Int(traslation.0), Int(traslation.1))).stroke(lineWidth: 2.0).foregroundColor(Color.gray)
                
                if let expression = parse() {
                    GraphShape(scaling: scaling, traslation: traslation, pass: (min: min, base: base, max: max), precision: 1.0, function: expression)
                        .stroke(lineWidth: 3)
                        
                }
            
            }
            
            
            VStack {
                
                TextField("Enter fucntion: y = ", text: $input)
                
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    
                    Slider(value: $min, in: 0.01...1.0) {
                        Text("Min: \(min)")
                    }
                    
                    Slider(value: $max, in: 1.0...10.0) {
                        Text("Max: \(max)")
                    }
                    
                    Slider(value: $base, in: 0.5...2.0) {
                        Text("Base: \(base)")
                    }
                    
                    
                    Stepper("Zoom") {
                        scaling.0 *= 1.5
                        scaling.1 *= 1.5
                        if spacing >= 100 {
                            spacing = 30
                        } else {
                            spacing *= 1.5
                        }
                        
                    } onDecrement: {
                        scaling.0 /= 1.5
                        scaling.1 /= 1.5
                        if spacing <= 10 {
                            spacing = 30
                        } else {
                            spacing /= 1.5
                        }
                    }

                }
                .padding()
            }
        }
        .background(Color.white)
        .gesture(
            DragGesture()
                .onChanged({ (value) in
                    traslation.0 = lastOffset.0 + Double(value.translation.width)
                    traslation.1 = lastOffset.1 - Double(value.translation.height)
                })
                .onEnded({ (value) in
                    lastOffset.0 = lastOffset.0 + Double(value.translation.width)
                    lastOffset.1 = lastOffset.1 - Double(value.translation.height)
                })
        )
    }
}

struct GraphViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        GraphViewDemo()
    }
}
