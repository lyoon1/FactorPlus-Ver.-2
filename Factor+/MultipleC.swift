//
//  MultipleC.swift
//  Factor+
//
//  Created by Jia Long Ma on 2015-11-06.
//  Copyright © 2015 LYM. All rights reserved.
//

import Foundation
import UIKit

class multipleChoice {
    
    var r = Int()
    var s = Int()

    func getRAns(rI: Int) -> String {
        
        if(rI > 0) {
            
            return "+" + String(rI)
            
        }
        else if(rI < 0) {
            
            return String(rI)
            
        }
        else {
            
            return ""
            
        }
        
    }
    
    func getSAns(sI: Int) -> String {
        
        if(sI > 0) {
            
            return "+"+String(sI)
            
        }
        else if(sI < 0) {
            
            return String(sI)
            
        }
        else {
            
            return ""
            
        }
    }
    
    func getKAns(kI: Int) -> String {
        
        if(kI == 1) {
            
            return ""
        }
        else {
        
            return String(kI)
            
        }
        
    }
    
    func getJAns(jI: Int) -> String {
        
        if(jI == 1) {
            
            return ""
        }
        else {
            
            return String(jI)
            
        }
        
    }
    
}