//
//  TestKeyboard.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 23/07/2020.
//

import SwiftUI

@available(OSX 11.0, *)
struct TestKeyboard: View {
    
    @EnvironmentObject var interactionManager: InteractionManager
    
    var manager : ButtonFunctions {
        ButtonFunctions(interactionManager: interactionManager)
    }
    
    var rows = [
        GridItem(.adaptive(minimum: 20, maximum: 50))
    ]
    
    var body: some View {
        LazyHGrid(rows: rows) {
            Button(action: {
                manager.add(key: .variable(Symbol("a", kind: "")))
            }) {
                Text("a")
            }
            
            Button(action: {
                manager.add(key: .variable(Symbol("b", kind: "")))
            }) {
                Text("b")
            }
            
            Button(action: {
                manager.add(key: .plus)
            }) {
                Text("+")
            }
            
            Button(action: {
                manager.add(key: .minus)
            }) {
                Text("-")
            }
            
            Button(action: {
                let key = GroupKey(mode: .fraction)
                manager.smartAdd(group: key, with: 2)
            }) {
                Text("/")
            }
            
            Group {
                
                Button(action: {
                    manager.add(key: .equalSign)
                }) {
                    Text("=")
                }
                
                Button(action: {
                    let key = GroupKey(mode: .brackets)
                    manager.add(group: key, with: 1)
                }) {
                    Text("()")
                }
                
                Button(action: {
                    let key = GroupKey(mode: .unOperation("cos"))
                    manager.add(group: key, with: 1)
                }) {
                    Text("cos")
                }
                
                Button(action: {
                    let key = GroupKey(mode: .modulus)
                    manager.add(group: key, with: 1)
                }) {
                    Text("abs")
                }
            }
            
            Button(action: {
                let key = GroupKey(mode: .exponent)
                manager.smartAdd(group: key, with: 2)
            }) {
                Text("^")
            }
            
            Button(action: {
                let key = GroupKey(mode: .logarithm)
                manager.add(group: key, with: 2)
            }) {
                Text("log")
            }
            
            Button(action: {
                let key = GroupKey(mode: .root)
                manager.add(group: key, with: 2)
            }) {
                Text("root")
            }
            
            Group {
                Button(action: {
                    manager.rightArrow()
                    print(interactionManager.currentSet.count)
                }) {
                    Text("->")
                }
                
                Button(action: {
                    manager.leftArrow()
                    print(interactionManager.currentSet.count)
                }) {
                    Text("<-")
                }
                
                Button(action: {
                    manager.delete()
                    print(interactionManager.currentSet.count)
                }) {
                    Text("del")
                }
            }
            
        }
        .frame(width: 50, height: 50)
    }
}
