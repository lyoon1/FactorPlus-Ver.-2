//
//  Quadratic.swift
//  Factor+
//
//  Created by Leo Yoon on 2015-11-06.
//  Copyright © 2015 LYM. All rights reserved.
//

import Foundation
import UIKit

class quadratic {
    
    init ()
    {
        
    }
    
    //the entire algorithm is one method
    func generateExpression() -> String {
        
        var b: Int  //represents the coefficient of x
        var c: Int  //represents the constant value
        var factorOne: Int = Int(arc4random_uniform(19) + 1)    //random Integer from 1 ~ 19
        var factorTwo: Int = Int(arc4random_uniform(19) + 1)    //random Integer from 1 ~ 19
        var signOne: String = ""    //stores whether x is negative or positive
        var signTwo: String = ""    //stores whether the constant is negative or positive
        var expression: String = "" //this represents the quadratic expression
        var tempB: Int = 0  //the variables used to actually display the b or c values
        var tempC: Int = 0  //will be manipulated
        
        //some of these should be negative now
        //this code is necessary because arc4random_uniform cannot generate negative integers
        factorOne -= 10
        factorTwo -= 10
        
        /* test codes
        print(factorOne)
        print(factorTwo)
        */
        
        //this code assigns a value to b and c using mathematical procedures
        b = (factorOne * -1) + (factorTwo * -1)
        c = (factorOne * -1) * (factorTwo * -1)
        
        //if b is negative, display -
        //and set tempB to a positive value so that the negative sign doesn't conflict with
        //the variable signOne
        if (b < 0)
        {
            signOne = "-"
            tempB = b * -1
        }
            //if b is positive, display +
            //and set tempB to b
        else if (b > 0)
        {
            signOne = "+"
            tempB = b
        }
        
        //same here, for c and tempC
        if (c < 0)
        {
            signTwo = "-"
            tempC = c * -1
        }
        else if (c > 0)
        {
            signTwo = "+"
            tempC = c
        }
        
        //if b doesn't exist (difference of square)
        if (b == 0)
        {
            return String(format: "%ix² %@ %ie%i", factorOne, signTwo, tempC, factorTwo)
        }
            //if b and c are both 0
        else if (b == 0 && c == 0)
        {
            return String(format: "%ix²e%i", factorOne, factorTwo)
        }
            //if there is no constant
        else if (c == 0)
        {
            //and if the coefficient of x (aka b) is 1, get rid of the 1 and display just x
            if (tempB == 1)
            {
                return String(format: "%ix² %@ xe%i", factorOne, signOne, factorTwo)
            }
                //else just display normally
            else
            {
                return String(format: "%ix² %@ %ixe%i", factorOne, signOne, tempB, factorTwo)
            }
        }
            //if b and c are both above 0
        else 
        {
            //and if the coefficient of x (aka b) is 1, get rid of the 1 and display just x
            if (tempB == 1)
            {
                return String(format: "%ix² %@ x %@ %ie%i", factorOne, signOne, signTwo, tempC, factorTwo)
            }
                //else just display normally
            else
            {
                return String(format: "%ix² %@ %ix %@ %ie%i", factorOne, signOne, tempB, signTwo, tempC, factorTwo)
                
            }
        }
        
    }
    
}