////
////  Test.swift
////  SwiftEquation
////
////  Created by Giulio Ferraro on 20/07/2020.
////
//
import SwiftUI

@available(OSX 11.0, *)
public struct TypingDemo: View {

    @StateObject var interactionManager = InteractionManager(set: RSet(key: RKey(key: .placeHolder)))

    public var body: some View {

        VStack {
            MathView(set: interactionManager.startSet)
                .environmentObject(interactionManager)

            TestKeyboard()
                .environmentObject(interactionManager)
            
            Button(action: {
                interactionManager.isEditing.toggle()
                let converter = Converter(input: interactionManager.startSet)
                print(converter.getText())
            }) {
                Text("Stampa")
            }
        }
        .frame(width: 400, height: 400, alignment: .center)
    }
    
    public init() {}
    
}

@available(OSX 11.0, *)
struct Test_Previews: PreviewProvider {
    static var previews: some View {
        TypingDemo()
    }
}
