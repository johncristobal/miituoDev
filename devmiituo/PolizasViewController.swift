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

var arreglo = [[String:String]]()
var arregloPolizas = [[String:String]]()
var arreglocarro = [[String:String]]()

class PolizasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arreglo = [[String:String]]()
        arregloPolizas = [[String:String]]()
        
        do {            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext

            //request for  tables
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            let requestpoli = NSFetchRequest<NSFetchRequestResult>(entityName: "Polizas")
            let requestcarro = NSFetchRequest<NSFetchRequestResult>(entityName: "Vehiculos")
            //let results = context.fetch(request)
            request.returnsObjectsAsFaults = false
            requestpoli.returnsObjectsAsFaults = false
            requestcarro.returnsObjectsAsFaults = false

            let results = try context.fetch(request)
            let resultpolizas = try context.fetch(requestpoli)
            let resultcarros = try context.fetch(requestcarro)
            
            //get data from users
            var i = 0;
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let username = result.value(forKey: "name") as? String {
                        
                        print(username)
                        var tempdict = [String:String]()
                        tempdict["name"] = username
                        //arreglo.setValue(username, forKey: "name")
                        //print(result.value(forKey: "lastname") as? String)
                        tempdict["lastname"] = result.value(forKey: "lastname") as? String
                        tempdict["mothername"] = result.value(forKey: "lastname") as? String
                        tempdict["token"] = result.value(forKey: "token") as? String
                        tempdict["celphone"] = result.value(forKey: "celphone") as? String
                        tempdict["id"] = result.value(forKey: "id") as? String
                        
                        arreglo.append(tempdict)
                        //print(result.value(forKey: "mothername") as? String)
                        //print(result.value(forKey: "id") as? Int)
                        i += 1
                    }
                }
            } else {
                
                print("No results")
                
            }
            
            //get data fro polizas
            var y = 0
            if resultpolizas.count > 0 {
                
                for result in resultpolizas as! [NSManagedObject] {
                    
                    if let polizanumber = result.value(forKey: "nopoliza") as? String {
                        
                        print(polizanumber)
                        var tempdict2 = [String:String]()
                        tempdict2["nopoliza"] = polizanumber
                        tempdict2["insurance"] = result.value(forKey: "insurance") as? String
                        tempdict2["lastodometer"] = result.value(forKey: "lastodometer") as? String
                        tempdict2["odometerpie"] = result.value(forKey: "odometerpie") as? String
                        tempdict2["rate"] = result.value(forKey: "rate") as? String
                        tempdict2["vehiclepie"] = result.value(forKey: "vehiclepie") as? String
                        
                        arregloPolizas.append(tempdict2)
                        y += 1
                    }
                }
            } else {
                
                print("No results")
                
            }
            
            //arreglos carros-----------
            if resultcarros.count > 0 {
                
                for result in resultcarros as! [NSManagedObject] {
                    
                    if let polizasid = result.value(forKey: "idpolizas") as? String {
                        
                        print(polizasid)
                        var tempdict3 = [String:String]()
                        tempdict3["idpolizas"] = polizasid
                        tempdict3["capacidad"] = result.value(forKey: "capacidad") as? String
                        tempdict3["color"] = result.value(forKey: "color") as? String
                        tempdict3["brand"] = result.value(forKey: "brand") as? String
                        tempdict3["descripcion"] = result.value(forKey: "descripcion") as? String
                        tempdict3["idcarro"] = result.value(forKey: "idcarro") as? String
                        tempdict3["model"] = result.value(forKey: "model") as? String
                        tempdict3["plates"] = result.value(forKey: "plates") as? String
                        tempdict3["subtype"] = result.value(forKey: "subtype") as? String
                        tempdict3["type"] = result.value(forKey: "type") as? String
                        
                        arreglocarro.append(tempdict3)
                        y += 1
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
        print(arregloPolizas.count)
        return arregloPolizas.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        tableView.rowHeight = 75

        //Define el contenido de la celda
        //let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PolizasTableViewCell
        print("Valor fila: \(indexPath.row)")
        //cell.label.text = String(indexPath.row+1)
        cell.label.text = "Polizas: \(arregloPolizas[indexPath.row]["nopoliza"]! as String)"
        
        //using a array to set the data
        //cell.textLabel?.text = self.content[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as! PolizasTableViewCell
        
        //valueToPass = currentCell.label.text!
        valueToPass = String(describing:indexPath.row)
        print(valueToPass)
        //var viewController = segue.destination as! DetallePolizaViewController
        //viewController.identificador = (selectedIndex?.row)!
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "detallePoli") as! DetallePolizaViewController
        //vc.cadenas = valueToPass
        self.present(vc, animated: true, completion: nil)

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
