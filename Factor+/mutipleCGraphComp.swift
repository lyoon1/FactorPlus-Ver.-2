//
//  mutipleCGraphComp.swift
//  Factor+
//
//  Created by Jia Long Ma on 2015-11-23.
//  Copyright © 2015 LYM. All rights reserved.
//
//  This class works similar to multipleC.swift and is designated to graphing multiple choice
//  It recieves input from the graphing

import Foundation
import UIKit

class multipleCGraphComp {

    var a: Int = 0
    var h: Int = 0
    var k: Int = 0
    
    func getaAns(aI: Int) -> String
    {
        
        if(aI < -1)
        {
            return String(aI)
        }
        else if(aI > 1)
        {
            return String(aI)
        }
        else if (aI == 1)
        {
            return ""
        }
        else
        {
            return "-"
        }
    }
    func gethAns(hI: Int) -> String
    {
        if(hI > 0)
        {
            return " - " + String(abs(hI))
        }
        else if(hI < 0)
        {
            return " + " + String(abs(hI))
        }
        else
        {
            return ""
        }
    }
    func getkAns(kI: Int) -> String
    {
        if(kI > 0)
        {
            return " + " + String(kI)
        }
        else if(kI < 0)
        {
            return " - " + String(abs(kI))
        }
        else
        {
            return ""
        }
    }
}
