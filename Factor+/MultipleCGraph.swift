//
//  MultipleCGraph.swift
//  Factor+
//
//  Created by Jia Long Ma on 2015-11-23.
//  Copyright © 2015 LYM. All rights reserved.
//

import Foundation
import UIKit

class MultipleCGraph{
    
    //var checkAnyAns: Int
    
    var tempAns = String()
    var rightAnsIndex = Int()
    var finalAns: String
    
    var finalChoice = [String]()
    var choice = [String]()
    
    var GraphOfPointsMC = GraphingPoints()
    
    var tempForFinalAns = multipleCGraphComp()
    
    init(){
        finalAns = ""
        
        for i in 0 ... 3 {
            choice.insert("", atIndex: i)
        }
        
        var aS = String(GraphOfPointsMC.getaVal())
        var hS = String(GraphOfPointsMC.gethVal())
        var kS = String(GraphOfPointsMC.getkVal())
     
        //  finalAns = aS+"(x"+hS+")²"+kS
        
        finalAns = tempForFinalAns.getaAns(Int(aS)!)+"(x"+tempForFinalAns.gethAns(Int(hS)!)+")²"+tempForFinalAns.getkAns(Int(kS)!)
        
        var aAns = multipleCGraphComp()
        var hAns = multipleCGraphComp()
        var kAns = multipleCGraphComp()
        
        for ( var i: Int = 1; i <= 3; i++)
        {
        
            /*aAns.a = Int(arc4random_uniform(5) + 1) - Int(arc4random_uniform(10) + 1)
            hAns.h = Int(arc4random_uniform(5) + 1) - Int(arc4random_uniform(10) + 1)
            kAns.k = Int(arc4random_uniform(5) + 1) - Int(arc4random_uniform(10) + 1)
        
            */
            
            var randomTypeOfAns:Int = Int(arc4random_uniform(3) + 1)
            
            if(randomTypeOfAns == 1) {
            
            aAns.a = Int(arc4random_uniform(9) + 1) - 5
            hAns.h = Int(arc4random_uniform(7) + 1) - 4
            kAns.k = Int(kS)!
            
            } else if(randomTypeOfAns == 2) {
            
            aAns.a = Int(arc4random_uniform(9) + 1) - 5
            hAns.h = Int(hS)!
            kAns.k = Int(arc4random_uniform(19) + 1) - 10
            
            } else if(randomTypeOfAns == 3) {
            
            aAns.a = Int(aS)!
            hAns.h = Int(arc4random_uniform(7) + 1) - 4
            kAns.k = Int(kS)!
            
            } else {
            
            aAns.a = Int(aS)!
            hAns.h = Int(hS)!
            kAns.k = Int(arc4random_uniform(19) + 1) - 10
            
            }

            //kAns.k = Int(kS)!
         /*   var checkAns = [String]()
            var checkIndex:Int
            if(i==0)
            {
                checkIndex = 0
            }
            else
            {
                checkIndex = i-1
            }

            
                checkAns[i] = aAns.getaAns(aAns.a)+","+hAns.gethAns(hAns.h)+","+kAns.getkAns(kAns.k)
                for j in 0...checkIndex{
                    if(checkAns[i] == checkAns[j])
                    {
                        i--
                    }
*/
            if (choice[i] == "")
            {
                choice.insert(aAns.getaAns(aAns.a)+"(x"+hAns.gethAns(hAns.h)+")²"+kAns.getkAns(kAns.k), atIndex: i)
                tempAns = choice[i]
                
                if (i == 1) {
                    
                    if(choice[i] == finalAns)
                    {
                        choice.removeAtIndex(i)
                        choice.insert("", atIndex: i)
                        tempAns = ""
                        i--
                    }
                }
                else if (i == 2) {
                    
                    if(choice[i] == finalAns || choice[i] == choice[1])
                    {
                        choice.removeAtIndex(i)
                        choice.insert("", atIndex: i)
                        tempAns = ""
                        i--
                    }
                }
                else if (i == 3) {
                    
                    if(choice[i] == finalAns || choice[i] == choice[1] || choice[i] == choice[2])
                    {
                        choice.removeAtIndex(i)
                        choice.insert("", atIndex: i)
                        tempAns = ""
                        i--
                    }
                }
            }
            
            
            for ( var checkAnyAns: Int = 0; checkAnyAns < i; checkAnyAns++){
            
                if (tempAns == choice[checkAnyAns]){
                    
                    choice.removeAtIndex(i)
                    choice.insert("", atIndex: i)
                    i--
                    
                }
            }
        }
        
        choice.removeAtIndex(0)
        rightAnsIndex = 4 - Int(arc4random_uniform (4) + 1)
        
        choice.insert(finalAns, atIndex: rightAnsIndex)
    }
    
    func getRightIndex() -> Int{
        return rightAnsIndex
    }
    
    func getChoice() -> [String] {
        return choice
    }
    
    func getGraphOfPointsMC() -> GraphingPoints {
        return GraphOfPointsMC
    }
    
    func getAValue() -> Int{
        return GraphOfPointsMC.getaVal()
    }
    
    func getHValue() -> Int{
        return GraphOfPointsMC.gethVal()
    }
    
    func getKValue() -> Int{
        return GraphOfPointsMC.getkVal()
    }
    
}
