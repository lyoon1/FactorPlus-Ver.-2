//
//  Trigonometry.swift
//  Factor+
//
//  Created by Leo Yoon on 2015-11-06.
//  Copyright © 2015 LYM. All rights reserved.
//
// will delete eventually

import Foundation
import UIKit

class triangle
{
    let angleA: Double //the 90° right angle
    var angleB: Double //the angle to be solved for; always going to be the missing angle
    var angleC: Double
    var sideA: Double //opposite to the right angle (hypotenuse)
    var sideB: Double
    var sideC: Double
    var angleOrSide: Int //random number generated: 1 is Angle and 0 is Side
    var doWeSolveForAngle: Bool //determines whether the question should solve for missing angle or missing side
    var answer: Double //the variable that stores the answer
    var missing: String //a reference variable for the programmer - this represents what side the question is solving for
    
    init ()
    {
        //declare all initial values
        //angleA is a constant 90 degrees, since it's a right angle triangle
        self.angleA = 90.00
        self.angleB = 0.00
        self.angleC = 0.00
        self.sideA = 0.00
        self.sideB = 0.00
        self.sideC = 0.00
        self.angleOrSide = Int(arc4random_uniform(2)) //generate a random Integer, 0 or 1
        self.answer = 0.00
        self.missing = ""
        
        //if the random number generated is 1, solve for angle
        if (angleOrSide == 1)
        {
            self.doWeSolveForAngle = true
        }
            //else solve for side
        else
        {
            self.doWeSolveForAngle = false
        }
    }
    
    //generate a random value for an Angle to be given
    func randomAngle() -> Int
    {
        return Int(arc4random_uniform(89) + 1)
    }
    
    //generate a random value for a Side to be given
    func randomSide(max: Int) -> Int
    {
        return Int(arc4random_uniform(UInt32(max)) + 1)
    }
    
    func radiansToDegrees(radian: Double) -> Double
    {
        //this is the mathematical way of converting radian to degree
        return ((radian) * (180 / M_PI))
    }
    
    //basic sine func using the sin method, which is part of Swift 2
    func sine(angle: Double) -> Double
    {
        return sin(angle * M_PI / 180)
    }
    
    //basic cosine func using the cos method, which is part of Swift 2
    func cosine(angle: Double) -> Double
    {
        return cos(angle * M_PI / 180)
    }
    
    //basic tangent func using the tan method, which is part of Swift 2
    func tangent(angle: Double) -> Double
    {
        return tan(angle * M_PI / 180)
    }
    
    //basic inverseSine func using the asin method, which is part of Swift 2
    func inverseSine(opposite: Double, hypotenuse: Double) -> Double
    {
        return radiansToDegrees(asin(opposite / hypotenuse))
    }
    
    //basic inverseCosine func using the acos method, which is part of Swift 2
    func inverseCosine(adjacent: Double, hypotenuse: Double) -> Double
    {
        return radiansToDegrees(acos(adjacent / hypotenuse))
    }
    
    //basic inverseTangent func using the atan method, which is part of Swift 2
    func inverseTangent(opposite: Double, adjacent: Double) -> Double
    {
        return radiansToDegrees(atan(opposite / adjacent))
    }
    
    //this func will be called if solving for angle
    func solveForAngle()
    {
        let type: Int = Int(arc4random_uniform(3)) + 1  //there are three types of functions to use (Sine, Cosine, Tangent)
        
        //use sine to solve for angleB
        if (type == 1)
        {
            sideA = Double(randomSide(9)) + 1
            sideB = Double(randomSide(Int(sideA) - 1))  //the length of this side cannot be larger than sideA since sideA is hypotenuse
            
            answer = inverseSine(Double(sideB), hypotenuse: Double(sideA))
        }
            //use cosine to solve for angleB
        else if (type == 2)
        {
            sideA = Double(randomSide(9)) + 1
            sideC = Double(randomSide(Int(sideA) - 1))
            
            answer = inverseCosine(Double(sideC), hypotenuse: Double(sideA))
        }
            //use tangent to solve for angleB
        else if (type == 3)
        {
            sideB = Double(randomSide(9))
            sideC = Double(randomSide(9))
            
            answer = inverseTangent(Double(sideB), adjacent: Double(sideC))
        }
    }
    
    //this func will be called if solving for side
    func solveForSide()
    {
        let type: Int = Int(arc4random_uniform(12)) + 1 //how many possible choices are there? 12.
        
        //first four 'if' statements are to solve for sideA
        if (type == 1)
        {
            missing = "A"                   //a reference variable for the programmer to refer to when testing and generating triangle
            
            angleB = Double(randomAngle())  //generate angleB
            sideC = Double(randomSide(9))   //generate sideC
            
            answer = Double(sideC) / cosine(Double(angleB)) //save the answer to a variable
        }
        else if (type == 2)
        {
            missing = "A"
            
            angleB = Double(randomAngle())
            sideB = Double(randomSide(9))
            
            answer = Double(sideB) / sine(Double(angleB))
        }
        else if (type == 3)
        {
            missing = "A"
            
            angleC = Double(randomAngle())
            sideC = Double(randomSide(9))
            
            answer = Double(sideC) / sine(Double(angleC))
        }
        else if (type == 4)
        {
            missing = "A"
            
            angleC = Double(randomAngle())
            sideB = Double(randomSide(9))
            
            answer = Double(sideB) / cosine(Double(angleC))
        }
            //next four 'if' statements are to solve for sideB
        else if (type == 5)
        {
            missing = "B"
            
            angleB = Double(randomAngle())
            sideA = Double(randomSide(9))
            
            answer = Double(sideA) * sine(Double(angleB))
        }
        else if (type == 6)
        {
            missing = "B"
            
            angleB = Double(randomAngle())
            sideC = Double(randomSide(9))
            
            answer = Double(sideC) * tangent(Double(angleB))
        }
        else if (type == 7)
        {
            missing = "B"
            
            angleC = Double(randomAngle())
            sideA = Double(randomSide(9))
            
            answer = Double(sideA) * cosine(Double(angleC))
        }
        else if (type == 8)
        {
            missing = "B"
            
            angleC = Double(randomAngle())
            sideC = Double(randomSide(9))
            
            answer = Double(sideC) / tangent(Double(angleC))
        }
            //last four 'if' statements are to solve for sideC
        else if (type == 9)
        {
            missing = "C"
            
            angleB = Double(randomAngle())
            sideA = Double(randomSide(9))
            
            answer = Double(sideA) * cosine(Double(angleB))
        }
        else if (type == 10)
        {
            missing = "C"
            
            angleB = Double(randomAngle())
            sideB = Double(randomSide(9))
            
            answer = Double(sideB) / tangent(Double(angleB))
        }
        else if (type == 11)
        {
            missing = "C"
            
            angleC = Double(randomAngle())
            sideA = Double(randomSide(9))
            
            answer = Double(sideA) * sine(Double(angleC))
        }
        else if (type == 12)
        {
            missing = "C"
            
            angleC = Double(randomAngle())
            sideB = Double(randomSide(9))
            
            answer = Double(sideB) * tangent(Double(angleC))
        }
    }
    
    //func called outside of the class to refer to the two separate solving methods
    func solve()
    {
        //if solving for angle, or side
        if (doWeSolveForAngle)
        {
            solveForAngle()
        }
        else
        {
            solveForSide()
        }
    }
    
    //take in a Double variable and then round to two decimal places
    func round(num: Double) -> Double
    {
        return NSString(format: "%2.2f", num).doubleValue
    }
}

/*
//test code below
var a = triangle()

a.sine(30)
a.cosine(60)
a.tangent(30)

a.inverseSine(5, hypotenuse: 10)
a.inverseCosine(5, hypotenuse: 10)
a.inverseTangent(1, adjacent: sqrt(3))

a.solve()
print(a.answer)
print(a.round(a.answer))
*/
