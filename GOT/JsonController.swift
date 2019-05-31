//
//  JsonController.swift
//  GOT
//
//  Created by dev on 2019-05-20.
//  Copyright © 2019 dev. All rights reserved.
//

import Foundation

protocol charactersDelegateProtocol {
    func charactersProtocolDidFinishWithData(array : NSArray)
    func charactersProtocoleDidFinishWithCharacterDetails(details:NSDictionary) 
}

class jsonController {
    var delegate : charactersDelegateProtocol? = nil
    
    func getJsonArray() -> NSArray {
        var charactersArray = NSArray()
        do{
            let path = Bundle.main.path(forResource: "text", ofType: "json")
            let jsonString = try String(contentsOfFile: path!)
            let dataFromJson = jsonString.data(using: .utf8)
            let jsonObject = try JSONSerialization.jsonObject(with: dataFromJson!, options: []) as! NSDictionary
            
             charactersArray = jsonObject.value(forKey: "characters") as! NSArray
        }catch{
            
        }
        return charactersArray
    }
    
    func readJson()  {
        let charactersArray = getJsonArray()
            if let mydelegate = delegate {
                mydelegate.charactersProtocolDidFinishWithData(array: charactersArray)
            }
    }

    func getSpecificCharacterDetails(characterName : String)  {
        let charactersArray = getJsonArray()
        var result = NSDictionary()
        for item in charactersArray {
            let name = (item as! NSDictionary).value(forKey: "characterName") as! String
            if name == characterName {
                result = item as! NSDictionary
                if let myDelegate = self.delegate {
                    myDelegate.charactersProtocoleDidFinishWithCharacterDetails(details: result)
                    break
                }
            }
        }
        
    }
}
