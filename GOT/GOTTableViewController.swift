//
//  GOTTableViewController.swift
//  GOT
//
//  Created by dev on 2019-05-20.
//  Copyright © 2019 dev. All rights reserved.
//

import UIKit

class GOTTableViewController: UITableViewController,charactersDelegateProtocol {
    func charactersProtocoleDidFinishWithCharacterDetails(details: NSDictionary) {
        
    }
    
    
    var charactersArray = [Character]()
    var myModel = jsonController()
    
    
    func charactersProtocolDidFinishWithData(array: NSArray) {
       
        for item in array {
            let c = Character(name: "", house: "", image: "",Favorate : false)
            if let name = (item as! NSDictionary).value(forKey: "characterName"){
                c.character_name = name as? String
//                if c.checkIfInFavorait(name: c.character_name!){
//                    c.isFavorait = true
//                    
//                }
//                
                
            }
            
            if let house = (item as! NSDictionary).value(forKey: "houseName"){
                c.character_house = house as? String
            }
            
            if let image = (item as! NSDictionary).value(forKey: "characterImageThumb"){
                c.character_image = image as? String
                
            }
            
            
            
            
            
            
            charactersArray.append(c)
            
        }
        
    }
    

    @IBAction func favorit_clicked(_ sender: Any) {
      
        guard let cell = (sender as! UIButton).superview?.superview as? CharacterTableViewCell else {
            
            return // or fatalError() or whatever
        }
        
        let indexPath = tableView.indexPath(for: cell)
        
        let alert = UIAlertController.init(title: "Save to Favoraits?", message: "", preferredStyle: .alert)
        
        
        let save_action = UIAlertAction.init(title: "Save", style: .default) { (action) in
            
            let thisCharacter = self.charactersArray[(indexPath?.row)!]
            let myNewCharacter = Character()
            thisCharacter.isFavorait = true
            myNewCharacter.saveToDB(c: thisCharacter)
            let thisCell = self.tableView.cellForRow(at: indexPath!) as! CharacterTableViewCell
            thisCell.favorit_button.setTitle("♥️", for: .normal)
            
        }
        let cancel_action = UIAlertAction.init(title: "Cancel", style: .cancel)
        
        alert.addAction(save_action)
        alert.addAction(cancel_action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myModel.delegate = self
        myModel.readJson()
//
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return charactersArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell : CharacterTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CharacterTableViewCell

        cell.character_Name.text = charactersArray[indexPath.row].character_name
        
        if let house = charactersArray[indexPath.row].character_house
        {
        cell.character_house.text = house
        }
        
        if let url = charactersArray[indexPath.row].character_image{
        let image_url = URL(string: url)
            do{
            if let url = image_url{
                let data = try Data(contentsOf: url)
                cell.character_Image.image = UIImage(data: data)
            }else {
                cell.character_Image.image = UIImage(named: "place-holder")
            }
            }catch{
                print(error)
        }
        }
        if !charactersArray[indexPath.row].isFavorait! {
            cell.favorit_button.setTitle("♡", for: .normal)
        }else {
            cell.favorit_button.setTitle("♥️", for: .normal)
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier!.isEqual("toDetails"){
        let index = tableView.indexPathForSelectedRow?.row
        let characterTosend = charactersArray[index!]
        let DVC = segue.destination as! CharacterDetailsViewController
        DVC.selectedCharacter = characterTosend
        }
    }
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
