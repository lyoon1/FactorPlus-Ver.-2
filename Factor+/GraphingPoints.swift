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
        
        /*var a = 3
        var h = -2
        var k = 9*/
        
        var x: Int = 0 //x is declared and initiated
        var y: Int = 0 //y is declared and initiated
        
        /*func quadraticFunction(x: Int, a: Int, h: Int, k: Int) -> Int {
        
        return a * (x - h)*(x - h) + k
        
        }*/
        
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
    
        
        
        
        /////////////////////////////////////
        
        //var i = 0
        //var substring = ""
        
        //print(pointX[0], ",", pointY[0])
        
        //User Inputs equation in vertex form
        
        //var aInput: Int = Int("+3")!//Stores user input for a
        //var hInput: Int = Int("-2")!//Stores user input for h
        //var kInput: Int = Int("+9")!//Store user input for k
        
        /*
        var userY: Int = 0//Represents the y value of the equation
        
        var testPointY = [String]()//Stores y - values
        
        var check = 0//
        
        for (x = -20; x<20; x++)
        {
        
        userY = aInput*(x-hInput)*(x-hInput)+kInput
        
        testPointY.insert(String(userY), atIndex: x+20)
        
        if ( testPointY[x+20] == pointYString[x+20])
        {
        
        check += 1;
        
        }
        
        if ( check == 40)
        {
        
        print(check)
        
        
        }
        }
        
        */
        
        /*else if( aInput < 0){
        
        
        
        }else{
        
        
        
        }*/
        
        //var Input = "s" + "4(x-2)²+3" + "e"
        
        /*if var start = Input.rangeOfString("s"), end = Input.rangeOfString("("){
        
        substring = Input[start.endIndex..<end.startIndex]
        
        }
        
        print(substring)
        
        if ( Input.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 11 || Input.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 10 || Input.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 9){
        
        if ( Input.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 8){
        
        if var start = Input.rangeOfString("4"), end = Input.rangeOfString("x"){
        
        substring = Input[start.endIndex..<end.startIndex]
        
        }
        
        print(substring)
        
        /*if ( Int(substring) == nil){
        
        var aInput = 1;
        
        }*/
        }
        
        
        for index in Input.characters.indices {
        
        //FIND A WAY TO RETRIEVE THE CHARACTERS BETWEEN TWO INDEXES BY SEARCHING FOR CERTAIN SUBSTRINGS
        
        //var aInput = Input.substringWithRange(Range<String.Index>(start: Input.startIndex, end: Input.endIndex.advancedBy(2)))
        
        //("\(Input[index])", terminator: "(")
        
        
        }
        }
        
        /*for (i = -20; i<20; i++) {
        
        if (
        
        }*/
        */
    }
    func produceA() ->Int //This method generates a random value for a
    {
        var tempA = Int(arc4random_uniform(9) + 1) - 5
        while (tempA == 0) //A while loop ensures that a will never equal 0
        {
            tempA = Int(arc4random_uniform(9) + 1) - 5
        }
        return tempA
    }
    
    //The following methods return values from this class so they can be used in other classes
    
    func getaVal() -> Int { //Returns a value
        return a
    }
    
    func gethVal() -> Int { //Returns h value
        return h
    }
    
    func getkVal() -> Int { //Returns k value
        return k
    }
    
    //These two arrays will play a role in creating the graph
    
    func getXVal() -> [String]{ //Returns pointX array
        return pointX
    }
    
    func getYVal() -> [Double]{ //Returns pointY array
        return pointYY
    }
}
