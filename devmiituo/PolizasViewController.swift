//
//  PolizasViewController.swift
//  miituo
//
//  Created by vera_john on 10/03/17.
//  Copyright © 2017 VERA. All rights reserved.
//

import UIKit
import CoreData

var valueToPass = ""

var arreglo = [String:String]()
var arregloPolizas = [String:String]()

class PolizasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext

            //request for  tables
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            let requestpoli = NSFetchRequest<NSFetchRequestResult>(entityName: "Polizas")
            //let results = context.fetch(request)
            request.returnsObjectsAsFaults = false
            requestpoli.returnsObjectsAsFaults = false

            let results = try context.fetch(request)
            let resultpolizas = try context.fetch(requestpoli)
            
            //get data from users
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let username = result.value(forKey: "name") as? String {
                        
                        print(username)
                        arreglo["name"] = username
                        //arreglo.setValue(username, forKey: "name")
                        //print(result.value(forKey: "lastname") as? String)
                        arreglo["lastname"] = result.value(forKey: "lastname") as? String
                        arreglo["mothername"] = result.value(forKey: "lastname") as? String
                        arreglo["token"] = result.value(forKey: "token") as? String
                        arreglo["celphone"] = result.value(forKey: "celphone") as? String
                        arreglo["id"] = result.value(forKey: "id") as? String
                        //print(result.value(forKey: "mothername") as? String)
                        //print(result.value(forKey: "id") as? Int)
                        
                    }
                }
            } else {
                
                print("No results")
                
            }
            
            //get data fro polizas
            if resultpolizas.count > 0 {
                
                for result in resultpolizas as! [NSManagedObject] {
                    
                    if let polizanumber = result.value(forKey: "nopoliza") as? String {
                        
                        print(polizanumber)
                        arregloPolizas["nopoliza"] = polizanumber
                        arregloPolizas["insurance"] = result.value(forKey: "insurance") as? String
                        arregloPolizas["lastodometer"] = result.value(forKey: "lastodometer") as? String
                        arregloPolizas["odometerpie"] = result.value(forKey: "odometerpie") as? String
                        arregloPolizas["rate"] = result.value(forKey: "rate") as? String
                        arregloPolizas["vehiclepie"] = result.value(forKey: "vehiclepie") as? String
                    }
                }
            } else {
                
                print("No results")
                
            }
            
        } catch {
            
            print("Couldn't fetch results")
            
        }
        
        //if results.count > 0
        tableview.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //Return the number of rows in our table
        //return 15;
        return arregloPolizas.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        tableView.rowHeight = 75

        //Define el contenido de la celda
        //let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PolizasTableViewCell
        
        //cell.label.text = String(indexPath.row+1)
        cell.label.text = "Polizas: \(arregloPolizas["nopoliza"]! as String)"
        
        //using a array to set the data
        //cell.textLabel?.text = self.content[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as! PolizasTableViewCell
        
        valueToPass = currentCell.label.text!
        //valueToPass = indexPath.row
        print(valueToPass)
        //var viewController = segue.destination as! DetallePolizaViewController
        //viewController.identificador = (selectedIndex?.row)!
        
        //let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailID") as! DetallePolizaViewController
        //vc.cadenas = valueToPass
        //self.present(vc, animated: true, completion: nil)

        //performSegue(withIdentifier: "seguewithid", sender: self)
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "seguewithid") {
            var viewController = segue.destination as! DetallePolizaViewController
            // your new view controller should have property that will store passed value
            
            let selectedIndex = tableview.indexPath(for: sender as! PolizasTableViewCell)
            //let currentCell = tableView.cellForRow(at: selectedIndex?.row)! as! PolizasTableViewCell
            
            viewController.identificador = (selectedIndex?.row)!
        }
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
