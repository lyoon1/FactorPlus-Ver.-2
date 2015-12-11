//
//  MultipleCGraph.swift
//  Factor+
//
//  Created by Jia Long Ma on 2015-11-23.
//  Copyright © 2015 LYM. All rights reserved.
//  
//  The following code is an algorithm that accepts a, h, and k values from a graphing class
//  The a, h and k values are used to create an equation which is then termed the "right answer"
//  Afterwards, 3 randomly generated multiple choice equations, some similar, some completely different are all placed in an
//  array with 4 elements
//  The "right answer" is then inserted randomly into the array at an index which is recorded as "right index"
//  This forms the base of the graphing multiple choice game mode, where the MCG view controller takes the "multiple choice" 
//  answer array and the index of the array which holds the correct answer to determine whether the user has pressed the
//  correct button
//
//  CODE ANAYLSIS (Read after understanding the way it functions)
//
//  This algorithm has proven to be quite efficient in terms of run time as there is barely any delay between the questions in the
//  graphing multiple choice gamemode
//  It is a relatively simplified algorithm that takes 5 big steps (highlighted above) with a maximum of 3 increments in the longest for
//  loop
//  
//  Areas of inefficiency include: 
//
//  The Checking portion: Could be removed because the multiple choice answers can probably be generated in a way that won't produce
//  repeating answers
//  
//  The randomTypeOfAns portion: Doesn't generate consistent multiple choice answers. Most of the time, the answers are reasonably
//  difficult, but sometimes, the right answer may be too obvious.
//
//  The random number generators that create values for a, h and k for the multiple choice answers: Sometimes they may generate the
//  correct a, h and k values that are present in finalAns. This will be an issue when implementing an adaptive difficulty setting
//
//  CREDITS
//
//  John - Responsible for algorithm MultipleCGraph and the following code
//  Taehyun - Responsible for helping pass values into the class
//  Leo - Responsible for linking the algorithm with multiple choice buttons 

import Foundation
import UIKit

class MultipleCGraph{//Start of Class
    
    //var checkAnyAns: Int
    
    var tempAns = String()//Variable tempAns is declared, tempAns will play a major role in testing for repeated answers
    var rightAnsIndex = Int()//variable rightAnsIndex is declared, rightAnsIndex will hold the value of index which has the
                             //right multiple choice answer in the multiple choice array
                             
    var finalAns: String//Variable finalAns is declared, finalAns will contain the value of the correct multiple choice answer
    
    //var finalChoice = [String]()
    var choice = [String]()// Array choice is declared, this array will hold all possible multiple choice selections as elements
                           // in a String array
    
    var GraphOfPointsMC = GraphingPoints()//declares a GraphingPoints() object, this will help pass through values for a, h and k
    
    var tempForFinalAns = multipleCGraphComp()//declares a multipleCGraphComp() object, the multipleCGraphComp class changes 
                                              //a, h and k values into Strings depending on whether they are negative or positive
    
    init(){
    
        finalAns = ""//finalAns is initialized
        
        /*The for loop inserts 3 blank strings into the choice array
        * In swift, arrays can have any number of elements
        * The point of adding blank strings is to prevent syntax errors
        */
        for i in 0 ... 3 {
            choice.insert("", atIndex: i)
        }
        
        /*The following variables will store integers based on the a, h and k values passed into the current class from the
        * graphingPoints class
        */
        
        var aS = GraphOfPointsMC.getaVal()//Correct a value
        var hS = GraphOfPointsMC.gethVal()//Correct h value
        var kS = GraphOfPointsMC.getkVal()//Correct k value
     
        //  finalAns = aS+"(x"+hS+")²"+kS
        
        /* The finalAns String is created, this is the correct multiple choice answer in the format: a(x +/- h) +/- k
         * The tempForFinalAns varriable calls upon the function getaAns, gethAns, or getkAns in the multipleCGraphComp class to convert 
         * the values within the parameters (aS, hS, or kS) and returns them in the form of a string: ("aS"), ("+hS" or "-hS"),
         * ("+kS" or "-kS")
         */
        finalAns = tempForFinalAns.getaAns(aS)+"(x"+tempForFinalAns.gethAns(hS)+")²"+tempForFinalAns.getkAns(kS)
        
        //Variables that will represent objects are declared
        var aAns = multipleCGraphComp()
        var hAns = multipleCGraphComp()
        var kAns = multipleCGraphComp()
        
        /* This is where the main portion of the algorithm begins
         * 
         * The following for loop increments the value of i starting with i being equal to one until it is greater or equal to 3
         * (This will cause the first element in the multiple choice array to be an empty string)
         * A random integer then chooses a multiple choice answer format
         * A multiple choice answer is then created and stored in the choice Array
         * The next generated multiple choice answers are checked with all the other elements in the array so see if there are
         * any repeating answers
         * If there are no repeating answers, then the array can be expanded
         */
        
        for ( var i: Int = 1; i <= 3; i++)
        {
        
            /*aAns.a = Int(arc4random_uniform(5) + 1) - Int(arc4random_uniform(10) + 1)
            hAns.h = Int(arc4random_uniform(5) + 1) - Int(arc4random_uniform(10) + 1)
            kAns.k = Int(arc4random_uniform(5) + 1) - Int(arc4random_uniform(10) + 1)
        
            */
            
            
            // Everytime theres a loop, variable randomTypeOfAns is set equal to a random value from 1 to 3
            var randomTypeOfAns:Int = Int(arc4random_uniform(4) + 1)
            
            /* Depending on the value of randomTypeOfAns, the following if/else statements will activate
            *
            * If randomTypeOfAns = 1, the multiple choice answer generated will definitely have the correct k value
            * If randomTypeOfAns = 2, the multiple choice answer generated will definitely have the correct h value
            * If randomTypeOfAns = 3, the multiple choice answer generated will definitely have the correct a and k value
            * Otherwise, the multiple choice answer generated will definitely have the correct a and h value
            */
            
            if(randomTypeOfAns == 1) {
            
            aAns.a = Int(arc4random_uniform(9) + 1) - 5
            hAns.h = Int(arc4random_uniform(7) + 1) - 4
            kAns.k = kS
            
            } else if(randomTypeOfAns == 2) {
            
            aAns.a = Int(arc4random_uniform(9) + 1) - 5
            hAns.h = hS
            kAns.k = Int(arc4random_uniform(19) + 1) - 10
            
            } else if(randomTypeOfAns == 3) {
            
            aAns.a = aS
            hAns.h = Int(arc4random_uniform(7) + 1) - 4
            kAns.k = kS
            
            } else {
            
            aAns.a = aS
            hAns.h = hS
            kAns.k = Int(arc4random_uniform(19) + 1) - 10
            
            }
            
            /* This code may be improved in coordination with the MCG view controller to make the program adaptable to the user's level
             * of skill and improve difficulty accoringly
             *
             * e.g if the user answers a certain number of questions right, the multiple choice answers can be restricted so that
             * out of three a, h and k values: 
             * Easy -> none of them are the same
             * Medium -> one of them is constant
             * Hard -> two of them are constant 
             */

            //kAns.k = Int(kS)!

            /* This is where the generated multiple choice answers are checked and inserted into the choice array
             * There are two criteria that must be met before the multiple choice answers can be inserted:
             *
             * 1 -> The multiple choice answer cannot be the same as finalAns
             * 2 -> The multiple choice answer cannot be the same as any other answer already in the array
             *
             */
             
            //The first if statement checks if the element at index i of the array is vacant
            
            if (choice[i] == "")
            {
                
                //If the element is vacant, then a multiple choice answer is created using the aAns.a, hAns.h and kAns.k
                //from the randomTypeOfAns if/else statement
                
                //The multiple choice answer is inserted into the array at index i first
                choice.insert(aAns.getaAns(aAns.a)+"(x"+hAns.gethAns(hAns.h)+")²"+kAns.getkAns(kAns.k), atIndex: i)
                
                tempAns = choice[i]//The multiple choice answer is then placed in the temporary variable tempAns
                                   //This variable will be compared to prevent repeated answers from occurring
                    
                    //First, the current multiple choice answer is compared to the correct multiple choice answer (finalAns) to see if
                    //they are equal
                    if(choice[i] == finalAns)
                    {
                        
                        //If they are equal, the multiple choice answer is erased completely and the i value decrements to repeat
                        //the for loop again without wasting a turn
                        choice.removeAtIndex(i)
                        choice.insert("", atIndex: i)
                        tempAns = ""
                        i--
                   }

            }
            
            /* If the multiple choice answer is completely different from the correct answer, it is compared to the rest of the
             * multiple choice answers in the choice array
             * This is done through the following for loop
             * If a single element in the choice array matches tempAns, the multiple choice answer will be erased and the i counter
             * will decrement to prevent the wasting of a turn
             *
             * Otherwise, the multiple choice answer will be added to the choice array
             */
             
            for ( var checkAnyAns: Int = 0; checkAnyAns < i; checkAnyAns++){
            
                if (tempAns == choice[checkAnyAns]){
                    
                    choice.removeAtIndex(i)
                    choice.insert("", atIndex: i)
                    i--
                    
                }
            }
        }
        
        //The empty string at the beginning of the array is removed
        choice.removeAtIndex(0)
        
        //A random index is chosen and stored in rightAnsIndex
        rightAnsIndex = 4 - Int(arc4random_uniform (4) + 1)
        
        //The correct multiple choice answer is inserted into the rightAnsIndex
        choice.insert(finalAns, atIndex: rightAnsIndex)
    }
    
    //The methods below can be called upon to return specific values from the MultipleCGraph class
    
    //Method returns the index in the choice array that holds the correct multiple choice answer
    func getRightIndex() -> Int{
        return rightAnsIndex
    }
    
    //Method returns the choice array containing allthe multiple choice answers generated
    func getChoice() -> [String] {
        return choice
    }
    
    
    func getGraphOfPointsMC() -> GraphingPoints {
        return GraphOfPointsMC
    }
    
    //These methods return a, h and k values
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
