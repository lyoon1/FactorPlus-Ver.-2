//
//  mutipleCGraphComp.swift
//  Factor+
//
//  Created by Jia Long Ma on 2015-11-23.
//  Copyright © 2015 LYM. All rights reserved.
//
//  This class works similar to multipleC.swift and is designated to graphing multiple choice
//  It recieves integers from the MultipleCGraph class and formats them into strings that can be used
//  The strings will be combined in the format of a(x-h)+k

import Foundation
import UIKit

class multipleCGraphComp { //Start of class

    //Variables are declared and initiated
    var a: Int = 0
    var h: Int = 0  
    var k: Int = 0  
    
    func getaAns(aI: Int) -> String //Method accepts integer aI from MultipleCGraph class
    {
        
        if(aI < -1) //If aI is less than -1, return string in the form of "-a"
        {
            return String(aI)
        }
        else if(aI > 1) //If aI is greater than 1, return string in the form of "a"
        {
            return String(aI)
        }
        else if (aI == 1) //If aI is equal to 1, return nothing
        {
            return ""
        }
        else //If aI is equal to -1, return "-"
        {
            return "-"
        }
    }
    
    func gethAns(hI: Int) -> String //Method accepts integer hI from MultipleCGraph class
    {
        if(hI > 0) //If hI is greater than 0 , return string in the form of "- h" (Inverted inside brackets)
        {
            return " - " + String(abs(hI))
        }
        else if(hI < 0) //If hI is less than 0 , return string in the form of "+ h" (Inverted inside brackets)
        {
            return " + " + String(abs(hI))
        }
        else //If hI is equal to zero, return nothing
        {
            return ""
        }
    }
    func getkAns(kI: Int) -> String //Method accepts integer kI from MultipleCGraph class
    {
        if(kI > 0) //If kI is greater than 0 , return string in the form of "+ h"
        {
            return " + " + String(kI)
        }
        else if(kI < 0) //If kI is less than 0 , return string in the form of "- h"
        {
            return " - " + String(abs(kI))
        }
        else //If kI is equal to zero, return nothing
        {
            return ""
        }
    }
}
