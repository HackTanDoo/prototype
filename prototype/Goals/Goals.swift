//
//  Goals.swift
//  prototype
//
//  Created by 김민준 on 2020/09/02.
//  Copyright © 2020 김민준. All rights reserved.
//

import Foundation

class AbstractGoals : Equatable {
    static func == (lhs: AbstractGoals, rhs: AbstractGoals) -> Bool {
        if lhs.content == rhs.content, lhs.title == rhs.title {
            return true
        } else {
            return false
        }
    }
    
    private(set) var content : String = ""
    private(set) var title : String = ""
    
    var clear = false
}

class ObjectiveGoals : Equatable {
    static func == (lhs: ObjectiveGoals, rhs: ObjectiveGoals) -> Bool {
        if lhs.content == rhs.content, lhs.title == rhs.title {
            return true
        } else {
            return false
        }
    }
    
    private(set) var content : String = ""
    private(set) var title : String = ""
    private(set) var tags = [AbstractGoals]()
    
    func appendTag(tag : AbstractGoals){
        if tags.contains(tag) {
            tags.append(tag)
            tags.sort(by: {
                if $0.title > $1.title {
                    return true
                } else{
                    return false
                }
            })
        }
    }
    
    var clear = false
}

class Goals {
    private var content = ""
    private(set) var day = Date()
    private(set) var notice = false
    var tags : [AbstractGoals] {
        var tags = [AbstractGoals]()
        for objective in objectives {
            for tag in objective.tags{
                if tags.contains(tag) {
                    tags.append(tag)
                }
            }
        }
        return tags
    }
    
    private(set) var objectives = [ObjectiveGoals]()
    
    func appendObjective(objective : ObjectiveGoals){
        if !objectives.contains(objective) {
            objectives.append(objective)
            objectives.sort(by: {
                if $0.title > $1.title{
                    return true
                } else {
                    return false
                }
            })
        }
    }
    
    var clear = false
}


