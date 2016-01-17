//
//  GraphingPoints.swift
//  Factor+
//
//  Created by Jia Long Ma on 2015-11-17.
//  Copyright © 2015 LYM. All rights reserved.
//
//  This class generates a, h and k values for a graphing equation that will be significant in properties of parabola
//  game modes
//  
//  This class works with a graphing function that requires a string array to hold x values and a double array to hold
//  y values
//

import Foundation
import UIKit

class GraphingPoints{ //Start of class GraphingPoints
    
    var pointX = [String](); //Declare string array that will hold x values
    var pointYY = [Double](); //Declare Double array that will hold y values (termed YY since pointY is an invalid name)
    var pointYString = [String](); 
    
    var a = Int() //Declare a value
    var h = Int() //Declare h value
    var k = Int() //Declare k value
    
    init() {
        
        //The three values are randomly generated
        //The a value calls upon the produceA() method to prevent the occurence of straight lines
        
        a = produceA() 
        h = Int(arc4random_uniform(7) + 1) - 4 
        k = Int(arc4random_uniform(19) + 1) - 10
        
        var x: Int = 0 //x is declared and initiated
        var y: Int = 0 //y is declared and initiated
        
        var placeholderMax = 0 //placeholderMax is declared and initiated this will play a role in the scale of the graph
        
        for (x = -5; x<5; x++) { //This for loop fills the pointX, pointY and pointYString arrays
            
            y = a*(x-h)*(x-h)+k //This is the basic formula for creating a quadratic
            
            pointX.insert(String(x), atIndex: x+5) //x values (loop number) is stored in the pointX array
            pointYY.insert(Double(y), atIndex: x+5) //y values (from equation above) are stored in the pointY array
            pointYString.insert(String(y), atIndex: x+5) 
            
            if(y>placeholderMax) //If y is greater than placeholderMax, then placeholderMax is set equal to y temporarily
                                 //This makes sure that placeholderMax is equal to the greatest y values generated
            {
                placeholderMax = y
            }
            
            //var quadraticResult = quadraticFunction(x, a: a, h: h, k: k)
            
        }
        
        //Places 2 points at the front and back of pointX array.
        //The two points will ensure that the graph is fully visible at all times
        pointX.insert("-6", atIndex: 0)
        pointX.insert("6", atIndex: 11)
        
        //The max/min of the parabola (represented by placeholderMax) is multiplied by 1.2 and inserted in the array at index 0
        //It is inserted again at index 11
        pointYY.insert(abs(Double(placeholderMax)*1.2)+Double(abs(a*10)), atIndex: 0)
        pointYY.insert(Double(placeholderMax+(a*5)), atIndex: 11)
    }
    
    func produceA() -> Int { //This method generates a random value for a
    
        var tempA = Int(arc4random_uniform(9) + 1) - 5
        
        while (tempA == 0) { //A while loop ensures that a will never equal 0
        
            tempA = Int(arc4random_uniform(9) + 1) - 5
        }
        
        return tempA
    }
    
    //The following methods return values from this class so they can be used in other classes
    
    func getaVal() -> Int { //Returns value of a
        
        return a
    }
    
    func gethVal() -> Int { //Returns value of h
        
        return h
    }
    
    func getkVal() -> Int { //Returns value of k
        
        return k
    }
    
    //These two arrays will play a role in creating the graph
    func getXVal() -> [String] { //Returns pointX array
        
        return pointX
    }
    
    func getYVal() -> [Double] { //Returns pointY array
        
        return pointYY
    }
}
