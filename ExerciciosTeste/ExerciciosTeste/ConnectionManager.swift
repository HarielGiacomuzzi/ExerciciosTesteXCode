//
//  ConnectionManager.swift
//  ExerciciosTeste
//
//  Created by Hariel Giacomuzzi on 3/1/16.
//  Copyright © 2016 Giacomuzzi. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class ConnectionManager: NSObject {
    
    static let Connection = ConnectionManager()
    
    var data  : AnyObject? = nil
    var pokeData : NSArray = []
    var userName: String = ""
    var userAge : String = ""
    var userTown : String = ""
    var userImage : UIImage?
    
    func login(UserName : String, Password : String, Completion : (Bool -> Void)){
        Alamofire.request(.GET, "http://server03.local:60080/login/?user=\(UserName)&password=\(Password)").responseJSON(completionHandler: {data in
            let a = (data.result.value as! NSDictionary)["response"] as! String
            if a == "true"{
                self.pokeData = ((data.result.value!["data"]!!["onHandPokemons"]!!) as! NSArray)
                self.userName =  (data.result.value!["data"]!!["name"]! as? String)!
                self.userAge =  (data.result.value!["data"]!!["age"]! as? Int)!.description
                self.userTown =  (data.result.value!["data"]!!["town"]! as? String)!
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
                    let a = UIImage(data: NSData(contentsOfURL: NSURL(string: (data.result.value!["data"]!!["photo"]! as? String)!)!)!)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.userImage = a
                    })
                    
                })
                Completion(true)
                return
            }
            Completion(false)

        })
    }
    
    func getUserImage(Completion : (UIImage -> Void)){
        if self.userImage != nil{
            Completion(self.userImage!)
        }else{
            Alamofire.request(.GET, "http://server03.local:60080/login/?user=ash&password=mistyS2").responseJSON(completionHandler: {data in
                let a = (data.result.value as! NSDictionary)["response"] as! String
                if a == "true"{
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
                        let a = UIImage(data: NSData(contentsOfURL: NSURL(string: (data.result.value!["data"]!!["photo"]! as? String)!)!)!)
                        dispatch_async(dispatch_get_main_queue(), {
                            self.userImage = a
                            Completion(self.userImage!)
                        })
                        
                    })
                }
            })
        }
    
    }
    
    func getPokemonData(Completion : (NSArray -> Void)){
        if self.pokeData.count != 0{
            Completion(self.pokeData)
        }else{
            Alamofire.request(.GET, "http://server03.local:60080/login/?user=ash&password=mistyS2").responseJSON(completionHandler: {data in
                let a = (data.result.value as! NSDictionary)["response"] as! String
                if a == "true"{
                    self.pokeData = ((data.result.value!["data"]!!["onHandPokemons"]!!) as! NSArray)
                    Completion(self.pokeData)
                }
            })
        }
    }
}