//
//  GraphingPoints.swift
//  Factor+
//
//  Created by Jia Long Ma on 2015-11-17.
//  Copyright © 2015 LYM. All rights reserved.
//

import Foundation
import UIKit

class GraphingPoints{
    
    var pointX = [String]();
    var pointYee = [Double]();
    var pointYString = [String]();
    
    var a = Int()
    var h = Int()
    var k = Int()
    
    init() {
        
        a = produceA()
        h = Int(arc4random_uniform(7) + 1) - 4
        k = Int(arc4random_uniform(19) + 1) - 10
        
        /*var a = 3
        var h = -2
        var k = 9*/
        
        var x: Int = 0
        var y: Int = 0
        
        /*func quadraticFunction(x: Int, a: Int, h: Int, k: Int) -> Int {
        
        return a * (x - h)*(x - h) + k
        
        }*/
        
        var placeholderMax = 0
        for (x = -5; x<5; x++) {
            
            y = a*(x-h)*(x-h)+k
            
            pointX.insert(String(x), atIndex: x+5)
            pointYee.insert(Double(y), atIndex: x+5)
            pointYString.insert(String(y), atIndex: x+5)
            
            if(y>placeholderMax)
            {
                placeholderMax = y
            }
            
            //var quadraticResult = quadraticFunction(x, a: a, h: h, k: k)
            
        }
        
        //places 2 points at the front and back of array.
        pointX.insert("-6", atIndex: 0)
        pointX.insert("6", atIndex: 11)
        pointYee.insert(abs(Double(placeholderMax)*1.2)+Double(abs(a*10)), atIndex: 0)
        pointYee.insert(Double(placeholderMax+(a*5)), atIndex: 11)
    
        
        
        
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
    func produceA() ->Int
    {
        var tempA = Int(arc4random_uniform(9) + 1) - 5
        while (tempA == 0)
        {
            tempA = Int(arc4random_uniform(9) + 1) - 5
        }
        return tempA
    }
    
    func getaVal() -> Int {
        return a
    }
    
    func gethVal() -> Int {
        return h
    }
    
    func getkVal() -> Int {
        return k
    }
    
    func getXVal() -> [String]{
        return pointX
    }
    
    func getYVal() -> [Double]{
        return pointYee
    }
}