//: Playground - noun: a place where people can play

import Foundation
import UIKit

class multipleChoice{
    
    init(){
        
    }
    
   // func multipleChoiceFunction(r: Int, s: Int) 
    
    var r: Int = -3
    var s: Int = 4
    
    //r = -3
    //s = 4
    
    
    func getRAns(rI: Int) -> String{
        
        if(rI > 0){
            
            return "+"+String(rI)
            
        }else if(rI < 0){
            
            return String(rI)
            
        }else{
            
            return ""
            
        }
        
    }
    
    func getSAns(sI: Int) -> String{
        
        if(sI > 0){
            
            return "+"+String(sI)
            
        }else if(sI < 0){
            
            return String(sI)
            
        }else{
            
            return ""
            
        }
    }
    
    func getKAns(kI: Int) -> String {
        
        if(kI == 1) {
            
            return ""
        }
        else {
        
            return String(kI)
            
        }
        
    }
    
    func getJAns(jI: Int) -> String {
        
        if(jI == 1) {
            
            return ""
        }
        else {
            
            return String(jI)
            
        }
        
    }
    
}

/*

var rightAnsIndex: Int = 0
var finalAns: String = ""
var i: Int = 0
var a: Int = 0

var finalChoice = [String]()
var choice = [String]()

for ( a = 0; a <= 3; a++){
    
    choice.insert("", atIndex: a)
    
}

var rAns = multipleChoice()
var sAns = multipleChoice()

//if(r > 0 && s = 0)

var rS: String = rAns.getRAns(9)
var sS: String = sAns.getSAns(6)

choice.removeAtIndex(0)
choice.insert("(x"+rS+")(x"+sS+")", atIndex: 0)

finalAns = choice[0]

for ( i = 1; i <= 3; i++){
    
    rAns.r += Int(arc4random_uniform(9) + 1) - Int(arc4random_uniform(9) + 1)
    sAns.s += Int(arc4random_uniform(9) + 1) - Int(arc4random_uniform(9) + 1)
    
    if(rAns.r >= 10 || rAns.r <= -10 || sAns.s >= 10 || sAns.s <= -10){
        
        i--
        
    }else{
        
        if (choice[i] == ""){
            
            choice[i] = "(x"+rAns.getRAns(rAns.r)+")(x"+sAns.getSAns(sAns.s)+")"
            
            if(choice [i] == choice [0]){
                
                
                choice.removeAtIndex(i)
                choice.insert("", atIndex: i)
                i--
                
                
            }
        }
        
    }
    
}

print(choice)

//Begin selection Sort Here

///////////////////////////////////////////////////////////////////////////////////////

var rightAns: String = choice [0]
choice.removeAtIndex(0)

var rightAnswerIndex = 4 - Int(arc4random_uniform (4) + 1)
choice.insert(rightAns, atIndex: rightAnswerIndex)

print(rightAnswerIndex)

*/