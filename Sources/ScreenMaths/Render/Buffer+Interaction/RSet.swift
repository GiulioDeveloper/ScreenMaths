//
//  RSet.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 19/07/2020.
//

import Foundation
import SwiftUI

public class RSet: Identifiable, Hashable {

    public var id = UUID()
    
    var keys: [RKey] {
        didSet {
            if keys.count == 1 {
                keys[0].isAlone = true
            } else {
                keys[0].isAlone = false
            }
        }
    }
    
    var group: GroupReference? = nil
    
    /// Add a key to the set
    /// - Parameters:
    ///   - type: The type of key to be added
    ///   - moment: The position of the key in the set
    /// - Returns: The same edited set
    @discardableResult
    public func add(key type: MathKey, at moment: Int) -> RSet {
        let key = RKey(key: type)
        add(key, at: moment)
        return self
    }
    
    /// Add a key to the set
    /// - Parameters:
    ///   - key: The type of key to be added
    ///   - moment: The position of the key in the set
    /// - Returns: The same edited set
    @discardableResult
    public func add(_ key: RKey, at moment: Int) -> RSet {
        keys.insert(key, at: moment + 1)
        key.set = self
        return self
    }
    
//    @discardableResult
    
    /// Allows to add a group to the RSet
    /// - Parameters:
    ///   - group: The type of group to be added
    ///   - members: The sets nested in the group
    ///   - moment: The position of the group in the original set
    /// - Returns: The same edited set
    @discardableResult
    public func add(group: GroupKey, with members: [RSet], at moment: Int) -> RSet {
        let mathKey = MathKey.group(group)
        let rKey = RKey(key: mathKey)
        for index in 0 ..< members.count {
            let newSet = members[index].copy
            newSet.group = GroupReference(group: group.group, position: index)
            group.group.members.append(newSet)
        }
        group.group.sender = rKey
        self.add(rKey, at: moment)
        
        return self
    }
    
    
    
    public var count: Int {
        keys.count
    }
    
    var lastIndex: Int {
        keys.count - 1
    }
    
    public var copy: RSet {
        RSet(keys: self.keys)
    }
    
    public subscript(index: Int) -> RKey {
        get {
            keys[index]
        }
        set(newValue) {
            keys[index] = newValue
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(keys)
    }
    
    public static func == (lhs: RSet, rhs: RSet) -> Bool {
        lhs.id == rhs.id && lhs.keys == rhs.keys
    }
    
    public static func + (_ lhs: RSet, _ rhs: RSet) -> RSet {
        RSet(keys: lhs.keys + rhs.keys)
    }
    public static func += (_ lhs: inout RSet, _ rhs: RSet) {
        lhs = lhs + rhs
    }
    
    internal init(id: UUID = UUID(), keys: [RKey], group: GroupReference? = nil) {
        self.id = id
        self.group = group
        self.keys = []
        let newKeys = keys.map { $0.changeSet(to: self) }
        self.keys = newKeys
    }
    
    public convenience init() {
        self.init(keys: [])
    }
    
    internal convenience init(id: UUID = UUID(), key: RKey, group: GroupReference? = nil) {
        self.init(id: id, keys: [key], group: group)
    }
    
    internal convenience init(id: UUID = UUID(), key: MathKey, group: GroupReference? = nil) {
        let rKey = RKey(key: key)
        self.init(id: id, keys: [rKey], group: group)
    }
    
}
