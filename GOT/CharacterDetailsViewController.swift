//
//  CharacterDetailsViewController.swift
//  GOT
//
//  Created by dev on 2019-05-20.
//  Copyright © 2019 dev. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: UIViewController,charactersDelegateProtocol {
    
    
    

    
    
    @IBOutlet weak var detailsText: UITextView!
    @IBOutlet weak var image: UIImageView!
    
    var selectedCharacter = Character()
    let Myjson_Controller = jsonController()

    func charactersProtocolDidFinishWithData(array: NSArray) {
        
    }
    
    func charactersProtocoleDidFinishWithCharacterDetails(details: NSDictionary) {
        var allDetails = ""
        for item in details {
            allDetails.append(item.key as! String)
            allDetails.append(":       ")
            if  item.value is String{
                allDetails.append(item.value as! String)
            }else if item.value is NSArray {
                for i in item.value as! NSArray {
                    allDetails.append(i as! String)
                    allDetails.append(",")
                }
            }
            allDetails.append("\n")
            print(allDetails)
            
        }
        detailsText.text = allDetails
        if let url = selectedCharacter.character_image{
            let image_url = URL(string: url)
            do{
                if let url = image_url{
                    let data = try Data(contentsOf: url)
                    image.image = UIImage(data: data)
                }else {
                    image.image = UIImage(named: "place-holder")
                }
            }catch{
                print(error)
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Myjson_Controller.delegate = self
        Myjson_Controller.getSpecificCharacterDetails(characterName: selectedCharacter.character_name!)
        
    }
    

    
}
