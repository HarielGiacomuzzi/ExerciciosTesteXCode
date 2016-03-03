//
//  ViewControllerUser.swift
//  ExerciciosTeste
//
//  Created by Hariel Giacomuzzi on 3/1/16.
//  Copyright © 2016 Giacomuzzi. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class ViewControllerUser: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNamelbl: UILabel!
    @IBOutlet weak var userAgelbl: UILabel!
    @IBOutlet weak var userTownlbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var numberOfCells = 0
    var pokeData : NSArray = []
    let connection = ConnectionManager.Connection
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connection.getPokemonData { data in
            self.pokeData = data
            self.numberOfCells = self.pokeData.count
            self.tableView.reloadData()
        }
        
        connection.getUserImage({image in
            self.userImage.image = image
        })
        
        self.userNamelbl.text = connection.userName
        self.userAgelbl.text = connection.userAge
        self.userTownlbl.text = connection.userTown
        
    }
        
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("gotoDetail", sender: indexPath)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellPokemon") as! CellPokemon
        if numberOfCells != 0 {
            let aux = pokeData[indexPath.row] as! NSDictionary
            cell.cellName.text = aux["name"] as? String
            cell.cellLevel.text = aux["level"] as? String
            cell.cellImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: aux["icon"] as! String)!)!)
            cell.cellType.text = aux["type1"] as? String
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gotoDetail"{
            let a = segue.destinationViewController as! ViewControllerPokemon
            a.index = (sender as! NSIndexPath).row
        }
    }
    
}
