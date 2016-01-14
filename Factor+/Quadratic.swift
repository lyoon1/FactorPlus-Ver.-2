//
//  Quadratic.swift
//  Factor+
//
//  Created by Leo Yoon on 2015-11-06.
//  Copyright © 2015 LYM. All rights reserved.
//
//  This class is responsible for generating a random quadratic relation.
//
//  There are two types of quadratic relations,
//  -> Basic (when a = 1)
//  -> Advanced (when a > 1)
//
//  * Work distribution
//  Taehyun: Suggested the 'get' accessor methods
//  John: Coded the advanced quadratic relation method
//  Leo: Coded the basic quadratic relation method
//

import Foundation
import UIKit

class quadratic {
    
    //ax² + bx + c
    var a: Int
    var b: Int
    var c: Int
    
    //Quadratic relation in factored form: 
    //(kx - m)(jx - n)
    var k: Int
    var j: Int
    var factorOne: Int      //the first factor
    var factorTwo: Int      //the second factor
    var signOne: String     //the sign (+/-) between x² and x
    var signTwo: String     //the sign (+/-) between x and constant
    var expression: String  //the variable that stores the question
    var tempB: Int          //temporary variable to store b for formatting
    var tempC: Int          //temporary variable to store c for formatting
    var factoringType: Int  //is it basic or advanced factoring?
    
    //the question is generated in the init
    init (fromUI: Bool, numCorrect: Int) {
        
        k = Int(arc4random_uniform(5) + 1)  //random integer from 1 ~ 5
        j = Int(arc4random_uniform(5) + 1)  //random integer from 1 ~ 5
        factorOne = Int(arc4random_uniform(19) + 1) - 10   //random Integer from -9 ~ 9
        factorTwo = Int(arc4random_uniform(19) + 1) - 10   //random Integer from -9 ~ 9
  
        //is the game mode User Input?
        if (fromUI == true) {
            
            //the User Input Factoring mode doesn't support the
            //advanced factoring yet
            factoringType = 1
        }
        else if (numCorrect >= 5) {
            
            //all questions will become advanced after 5 correct answers
            factoringType = 2
        }
        else {
            
            //otherwise randomly set the difficulty
            factoringType = Int(arc4random_uniform(2) + 1)
        }
        
        //if random number = 1, use basic factoring
        if (factoringType == 1) {
            
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
            if (b < 0) {
                
                signOne = "-"
                tempB = b * -1
            }
                
            //if b is positive, display +
            //and set tempB to b
            else if (b > 0) {
                
                signOne = "+"
                tempB = b
            }
            
            //same here, for c and tempC
            if (c < 0) {
                
                signTwo = "-"
                tempC = c * -1
            }
            else if (c > 0) {
                
                signTwo = "+"
                tempC = c
            }
            
            //if b and c are both 0
            if (b == 0 && c == 0) {
                
                expression = String(format: "x²")
            }
            //if b doesn't exist (difference of square)
            else if (b == 0) {
                
                expression = String(format: "x² %@ %i", signTwo, tempC)
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
        //all code below is for advanced factoring
        else {
            
            //ax² + bx + c
            a = Int()
            b = Int()
            c = Int()
            
            signOne = ""    //stores whether x is negative or positive
            signTwo = ""    //stores whether the constant is negative or positive
            expression = "" //this represents the quadratic expression
            tempB = 0       //the variables used to actually display the b or c values
            tempC = 0       //will be manipulated

            //this forloop checks if the value of k and j is a multiple of
            //a number between 1 to 5, 5 times and divides the factor by that number.
            //This ensures that the factor is in its simplest form
            for(var l: Int = 1; l <= 9; l++) {
                
                for(var i: Int = 1; i <= 5; i++) {
                    
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
            
            //using mathematical procedures to generate a quadratic relation
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
            
            //if b and c are both 0
            if (b == 0 && c == 0)
            {
                //if a is not 1, the a needs to be displayed: ax²
                //but if a is 1, the proper formatting is just x²
                if (a != 1) {
                    
                    expression = String(format: "%ix²", a)
                }
                else {
                    
                    expression = String(format: "x²")
                }
            }
            //if b doesn't exist (difference of square)
            else if (b == 0)
            {
                //same reasoning here
                if (a != 1) {
                    expression = String(format: "%ix² %@ %i", a, signTwo, tempC)
                }
                else {
                    expression = String(format: "x² %@ %i", signTwo, tempC)

                }
            }
            //if there is no constant
            else if (c == 0)
            {
                //and if the coefficient of x (aka b) is 1, get rid of the 1 and display just x
                if (tempB == 1)
                {
                    //same reasoning here
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
                    //same reasoning here
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
                    //same reasoning here
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
                    //same reasoning here
                    if (a != 1) {
                        expression = String(format: "%ix² %@ %ix %@ %i", a, signOne, tempB, signTwo, tempC)
                    }
                    else {
                        expression = String(format: "x² %@ %ix %@ %i", signOne, tempB, signTwo, tempC)
                    }
                    
                }
                
            } //end of "if b and c are both above 0" else statement
            
            
        } //end of "advanced factoring" else statement

    } //end of init
    
    //all of the accessor methods for each important variables are down here
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
    
    //is the quadratic question basic or advanced?
    func isBasicQuadratic() -> Bool {
        
        if (factoringType == 1) {
            
            return true
        }
        else {
            
            return false
        }
    }
    
}