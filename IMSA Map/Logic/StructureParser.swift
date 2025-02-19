//
//  StructureParser.swift
//  Conant Map
//
//  Created by Johnny Waity on 6/26/18.
//  Copyright © 2018 Johnny Waity. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

class StructureParser {
    static func parseStructures(_ file:String, structureNodes:[[SCNNode]]) -> [Structure]{
        //Prepare Array For Structures
        var structures:[Structure] = []
        //Prepare Array For Lines
        var lines:[String] = []
        if file == "fallback"{
            do{
                //Get File Path
                let path = Bundle.main.path(forResource: "colors", ofType: "dat")
                //String from File
                let rawString = try String(contentsOfFile: path!)
                //Seperate lines fron String
                lines = rawString.components(separatedBy: .newlines)
            }catch{
                print(error)
            }
        }else{
            lines = file.components(separatedBy: .newlines)
        }
        
        var currentStructure:Structure? = nil
        //Iterate Through Each Line Of File
        for line in lines {
            //If there is no information on current line
            if Array(line).count <= 0 {
                continue
            }
            //Header determines what property of the node is currently being read
            let header = Array(line)[0]
            /*
             Header Types
             % name of the Structure
             @ color of structure
             */
            
            //Phrase is the property being read
            let phrase = String(line.suffix(line.count-1))
            switch header {
            case "%":
                if let s = currentStructure {
                    structures.append(s)
                }
                let nameArr = phrase.components(separatedBy: ",")
                currentStructure = Structure(nameArr)
                var currentFloor = 0
                var foundS = false
                for floor in structureNodes {
                    currentFloor += 1
                    for s in floor{
                        for n in (s.name?.components(separatedBy: ","))!{
                            if nameArr.contains(n){
                                currentStructure?.node = s
                                currentStructure?.floor = currentFloor
                                foundS = true
                            }
                        }
                    }
                }
                if !foundS{
                    print("No building For \(nameArr)")
                }
                
                break;
            case "@":
                switch phrase {
                case "Red":
                    currentStructure?.color = UIColor.red
                    break
                case "Blue":
                    currentStructure?.color = UIColor.blue
                    break
                case "White":
                    currentStructure?.color = UIColor.white
                    break
                case "Black":
                    currentStructure?.color = UIColor.black
                    break
                default:
                    break
                }
            default:
                break
            }
        }
        structures.append(currentStructure!)
        
        return structures
    }
}
