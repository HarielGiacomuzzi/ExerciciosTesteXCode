//
//  ViewControllerPokemon.swift
//  ExerciciosTeste
//
//  Created by Hariel Giacomuzzi on 3/1/16.
//  Copyright © 2016 Giacomuzzi. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class ViewControllerPokemon: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLevel: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelSPAttack: UILabel!
    @IBOutlet weak var labelSpeed: UILabel!
    @IBOutlet weak var labelHealth: UILabel!
    @IBOutlet weak var labelAttack: UILabel!
    @IBOutlet weak var labelDefense: UILabel!
    @IBOutlet weak var labelSPDefense: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var pokeData : NSDictionary = [:]
    var numberOfCells = 0
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConnectionManager.Connection.getPokemonData({ (data) -> Void in
            self.pokeData = data[self.index] as! NSDictionary
            self.populateData()
        })
    }
    
    func populateData(){
        self.pokemonImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.pokeData["image"] as! String)!)!)
        self.labelName.text = self.pokeData["name"] as? String
        self.labelLevel.text = "Level: \((self.pokeData["Int"] as? Int)?.description)"
        self.labelType.text = self.pokeData["type1"] as? String
        self.labelSPAttack.text = "SPAttack: \((self.pokeData["status"]!["spAttack"] as? Int)!.description)"
        self.labelSpeed.text = "Speed: \((self.pokeData["status"]!["speed"] as? Int)!.description)"
        self.labelHealth.text = "Health: \((self.pokeData["status"]!["health"] as? Int)!.description)"
        self.labelAttack.text = "Attack: \((self.pokeData["status"]!["attack"] as? Int)!.description)"
        self.labelDefense.text = "Defense: \((self.pokeData["status"]!["defense"] as? Int)!.description)"
        self.labelSPDefense.text = "SPDefense: \((self.pokeData["status"]!["spDefense"] as? Int)!.description)"
        self.numberOfCells = (self.pokeData["skills"] as! NSArray).count
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellSkill") as! CellSkill
        if numberOfCells != 0 {
            let aux = pokeData["skills"] as! NSArray
            cell.skillAcurracy.text = (aux[indexPath.row]["accuracy"] as? Int)?.description
            cell.skillCategory.text = aux[indexPath.row]["damageCategory"] as? String
            cell.skillName.text = aux[indexPath.row]["name"] as? String
            cell.skillPower.text = (aux[indexPath.row]["power"] as? Int)?.description
            cell.skillPowerPoint.text = (aux[indexPath.row]["powerPoint"] as? Int)?.description
            cell.skillType.text = aux[indexPath.row]["type"] as? String
        
        }
        return cell
    }
}