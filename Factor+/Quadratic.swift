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
    
    var a: Int //the coefficient of x²
    var b: Int
    var c: Int
    var k: Int
    var j: Int
    var factorOne: Int
    var factorTwo: Int
    var signOne: String
    var signTwo: String
    var expression: String
    var tempB: Int
    var tempC: Int
    var randNum: Int
    
    init (fromUI: Bool) {
        
        k = Int(arc4random_uniform(5) + 1)
        j = Int(arc4random_uniform(5) + 1)
        factorOne = Int(arc4random_uniform(19) + 1) - 10   //random Integer from -9 ~ 9
        factorTwo = Int(arc4random_uniform(19) + 1) - 10   //random Integer from -9 ~ 9
        
        if (fromUI == true) {
            randNum = 1
        }
        else {
            randNum = Int(arc4random_uniform(2) + 1)
        }
        
        //if random number = 1, use basic factoring
        if (randNum == 1) {
            
            //this code assigns a value to b and c using mathematical procedures
            a = 1
            b = (factorOne * -1) + (factorTwo * -1) //represents the coefficient of x
            c = (factorOne * -1) * (factorTwo * -1) //represents the constant value
            
            signOne = ""    //stores whether x is negative or positive
            signTwo = ""    //stores whether the constant is negative or positive
            expression = "" //this represents the quadratic expression
            tempB = 0  //the variables used to actually display the b or c values
            tempC = 0  //will be manipulated
            
            //this code assigns a value to b and c using mathematical procedures
            
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
                expression = String(format: "x² %@ %i", signTwo, tempC)
            }
                //if b and c are both 0
            else if (b == 0 && c == 0)
            {
                expression = String(format: "x²")
            }
                //if there is no constant
            else if (c == 0)
            {
                //and if the coefficient of x (aka b) is 1, get rid of the 1 and display just x
                if (tempB == 1)
                {
                    expression = String(format: "x² %@ x", signOne)
                }
                    //else just display normally
                else
                {
                    expression = String(format: "x² %@ %ix", signOne, tempB)
                }
            }
                //if b and c are both above 0
            else
            {
                //and if the coefficient of x (aka b) is 1, get rid of the 1 and display just x
                if (tempB == 1)
                {
                    expression = String(format: "x² %@ x %@ %i", signOne, signTwo, tempC)
                }
                    //else just display normally
                else
                {
                    expression = String(format: "x² %@ %ix %@ %i", signOne, tempB, signTwo, tempC)
                    
                }
                
            }

        }
        else {
            
            a = Int()
            b = Int()
            c = Int()
            signOne = ""    //stores whether x is negative or positive
            signTwo = ""    //stores whether the constant is negative or positive
            expression = "" //this represents the quadratic expression
            tempB = 0       //the variables used to actually display the b or c values
            tempC = 0       //will be manipulated

            for(var l: Int = 1; l < 9; l++) {
                
                for(var i: Int = 1; i < 9; i++) {
                    
                    if(k % i == 0 && factorOne % i == 0) {
                        
                        k /= i
                        factorOne /= i
                        
                    }
                    
                    if(j % i == 0 && factorTwo % i == 0) {
                        
                        j /= i
                        factorTwo /= i
                        
                    }
                    
                }
                
            }
            
            a = k * j
            b = (k * factorTwo) + (j * factorOne)
            c = (factorOne * factorTwo)
            
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
                if (a != 1) {
                    expression = String(format: "%ix² %@ %i", a, signTwo, tempC)
                }
                else {
                    expression = String(format: "x² %@ %i", signTwo, tempC)

                }
            }
                //if b and c are both 0
            else if (b == 0 && c == 0)
            {
                if (a != 1) {
                    expression = String(format: "%ix²", a)
                }
                else {
                    expression = String(format: "x²")
                }
            }
                //if there is no constant
            else if (c == 0)
            {
                //and if the coefficient of x (aka b) is 1, get rid of the 1 and display just x
                if (tempB == 1)
                {
                    if (a != 1) {
                        expression = String(format: "%ix² %@ x", a, signOne)
                    }
                    else {
                        expression = String(format: "x² %@ x", signOne)
                    }
                }
                    //else just display normally
                else
                {
                    if (a != 1) {
                        expression = String(format: "%ix² %@ %ix", a, signOne, tempB)
                    }
                    else {
                        expression = String(format: "x² %@ %ix", signOne, tempB)
                    }

                }
            }
                //if b and c are both above 0
            else
            {
                //and if the coefficient of x (aka b) is 1, get rid of the 1 and display just x
                if (tempB == 1)
                {
                    if (a != 1) {
                        expression = String(format: "%ix² %@ x %@ %i", a, signOne, signTwo, tempC)
                    }
                    else {
                         expression = String(format: "x² %@ x %@ %i", signOne, signTwo, tempC)
                    }

                }
                    //else just display normally
                else
                {
                    if (a != 1) {
                        expression = String(format: "%ix² %@ %ix %@ %i", a, signOne, tempB, signTwo, tempC)
                    }
                    else {
                        expression = String(format: "x² %@ %ix %@ %i", signOne, tempB, signTwo, tempC)
                    }
                    
                }
                
            }
            
            
        }
        

    }
    
    func getK() -> Int {
        
        return k
    }
    
    func getJ() -> Int {
        
        return j
    }
    
    func getMValue() -> Int {
        return factorOne
    }
    
    func getNValue() -> Int {
        return factorTwo
    }
    
    func getExpression() -> String {
        return expression
    }
    
    func isBasicQuadratic() -> Bool {
        if (randNum == 1) {
            return true
        }
        else {
            return false
        }
    }
/*
    
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

*/
    
}