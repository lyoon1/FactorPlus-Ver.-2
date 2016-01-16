//
//  MultipleC.swift
//  Factor+
//
//  Created by Jia Long Ma on 2015-11-06.
//  Copyright © 2015 LYM. All rights reserved.
//
//  This class is designated for factoring multiple choice
//  It takes randomly generated integers and returns them in an appropriate string so they can be used to create factors
//  in the form of (kx + m)(jx + n) in the MCF and MCFT Viewcontrollers

import Foundation
import UIKit

class multipleChoice { //Start of multipleChoice class
    
    var r = Int() //will represent the "m" values in (kx + m)(jx + n)
    var s = Int() //will represent the "n" values in (kx + m)(jx + n)

    func getRAns(rI: Int) -> String { //An integer "rI" is randomly generated and sent from MCFViewController class
        
        if(rI > 0) { //If rI is greater than 0, then the integer will be casted as a string and returned as "+ rI"
            
            return "+" + String(rI)
            
        }
        else if(rI < 0) { //If rI is less than 0, then the integer will be casted as a string and returned as "- rI"
            
            return String(rI)
            
        }
        else { //If rI is 0, then nothing will be returned
            
            return ""
            
        }
        
    }
    
    func getSAns(sI: Int) -> String { //An integer "sI" is randomly generated and sent from MCFViewController class
        
        if(sI > 0) { //If sI is greater than 0, then the integer will be casted as a string and returned as "+ sI"
            
            return "+"+String(sI)
            
        }
        else if(sI < 0) { //If sI is less than 0, then the integer will be casted as a string and returned as "- sI"
            
            return String(sI)
            
        }
        else { //If sI is 0, then nothing will be returned
            
            return ""
            
        }
    }
    
    //In the next two methods, kI and jI integers sent will always be positive
    
    func getKAns(kI: Int) -> String { //An integer "kI" is randomly generated and sent from MCFViewController class
        
        if(kI == 1) { //If kI is equal to 1, return nothing
            
            return ""
        }
        else { //Otherwise, return the kI in the form of a string
        
            return String(kI)
            
        }
        
    }
    
    func getJAns(jI: Int) -> String { //An integer "jI" is randomly generated and sent from MCFViewController class
        
        if(jI == 1) { //If jI is equal to 1, return nothing
            
            return ""
        }
        else { //Otherwise, return the jI in the form of a string
            
            return String(jI)
            
        }
        
    }
    
}
