//
//  ButtonFunctions.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 20/07/2020.
//

import Foundation

/// Contains a set of elementary function that allows
public class ButtonFunctions {

    var manager: InteractionManager
    
    public init(interactionManager: InteractionManager) {
        self.manager = interactionManager
    }
    
    
    public func add( key: MathKey ) {
        manager.currentSet.add(key: key, at: manager.currentMoment)
        manager.currentMoment += 1
    }
    
    public func add( group: GroupKey, with members: Int) {
        assert(members >= 1, "Cannot create with less than one member")
        var sets = [RSet]()
        for _ in 0 ..< members {
            sets.append(RSet(key: MathKey.placeHolder))
        }
        manager.currentSet.add(group: group, with: sets, at: manager.currentMoment)
        manager.currentSet = group.group.members[0]
        manager.currentMoment = 0
    }
    
    public func smartAdd( group: GroupKey, with members: Int) {
        assert(members >= 2, "Cannot create with less than two member")
        switch manager.currentKey.key {
        case .digit(_), .variable(_), .group(_):
            let rKey = RKey(key: .group(group))
            let firstSet = RSet(key: manager.currentKey)
            firstSet.group = GroupReference(group: group.group, position: 0)
            group.group.members.append(firstSet)
            for position in 1...(members - 1) {
                let set = RSet(key: MathKey.placeHolder)
                set.group = GroupReference(group: group.group, position: position)
                group.group.members.append(set)
            }
            group.group.sender = rKey
            manager.currentSet.add(rKey, at: manager.currentMoment)
            manager.currentSet.keys.remove(at: manager.currentMoment)
            manager.currentSet = group.group.members[1]
            manager.currentMoment = 0
        default:
            add(group: group, with: members)
        }
    }
    
    public func rightArrow() {
        if manager.currentMoment < manager.currentSet.keys.count - 1 {
            if case .group(let groupKey) = manager.currentSet.keys[manager.currentMoment + 1].key {
                manager.currentSet = groupKey.group.members[0]
                manager.currentMoment = 0
            } else {
                manager.currentMoment += 1
            }
        } else {
            if let reference = manager.currentSet.group {
                if reference.position == reference.group.members.count - 1 {
                    let sender: RKey = reference.group.sender
                    manager.currentSet = sender.set
                    manager.currentMoment = manager.currentSet.keys.firstIndex(of: sender)!
                } else {
                    manager.currentSet = reference.group.members[reference.position + 1]
                    manager.currentMoment = 0
                }
            } else {
                return
            }
        }
    }
    
    public func leftArrow() {
        if manager.currentMoment == 0 {
            guard manager.currentSet != manager.startSet else {
                print(manager.currentSet.count)
                print(manager.currentMoment)
                return
            }
            if let reference = manager.currentSet.group {
                if reference.position == 0 {
                    let sender: RKey = reference.group.sender
                    manager.currentSet = sender.set
                    manager.currentMoment = manager.currentSet.keys.firstIndex(of: sender)! - 1
                } else {
                    manager.currentSet = reference.group.members[reference.position - 1]
                    manager.currentMoment = manager.currentSet.count - 1
                }
            }
        } else {
            if case .group(let groupKey) = manager.currentKey.key {
                manager.currentSet = groupKey.group.members.last!
                manager.currentMoment = manager.currentSet.count - 1
            } else {
                manager.currentMoment -= 1
            }
        }
        print(manager.currentSet.count)
        print(manager.currentMoment)
    }
    
    public func delete() {
        guard manager.currentMoment != 0 else {
            return 
        }
        manager.currentSet.keys.remove(at: manager.currentMoment)
        manager.currentMoment -= 1
    }
    
}
