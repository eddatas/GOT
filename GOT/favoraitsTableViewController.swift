//
//  favoraitsTableViewController.swift
//  GOT
//
//  Created by dev on 2019-05-20.
//  Copyright © 2019 dev. All rights reserved.
//

import UIKit

class favoraitsTableViewController: UITableViewController {
    let CharacterController = Character()
    var CArray = [DBCharacter]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CArray = CharacterController.getFavoraitCharacters()
        
//        CharacterController.deleteDB(dbCharArray: CArray)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell : CharacterTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CharacterTableViewCell
        
        cell.character_Name.text = CArray[indexPath.row].name
        
        if let house = CArray[indexPath.row].house
        {
            cell.character_house.text = house
        }
        
        if let url = CArray[indexPath.row].image{
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
        cell.favorit_button.setTitle("♥️", for: .normal)
        return cell
        

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let index = tableView.indexPathForSelectedRow?.row
        let itemToSend = CArray[index!] 
        let c = Character(name: itemToSend.name, house: itemToSend.house, image: itemToSend.image, Favorate: true)
   
    
        let DVC = segue.destination as! CharacterDetailsViewController
        DVC.selectedCharacter = c
    }
   
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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
