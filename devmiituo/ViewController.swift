//
//  ViewController.swift
//  devmiituo
//
//  Created by vera_john on 21/03/17.
//  Copyright © 2017 VERA. All rights reserved.
//

import UIKit
import CoreData
import Toaster

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!
    @IBOutlet var telefono: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendPhone(_ sender: Any) {
        let tel = telefono.text! as String
        
        if tel != ""{
            print(tel)
            
            //get data from WS
            self.getJson(telefon: tel);

            //launch second view with data - show table and polizas
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "polizas") as! PolizasViewController
            self.present(vc, animated: true, completion: nil)

        }else{
            //print("Introduzca número celular")
            showmessage(message: "Introduzca número celular");
        }
        
        //call class to get json
        //let task = Task()
    }
    
    //function to shoe toast
    func showmessage(message: String){
        
        Toast(text: message).show()
        
    }
    
    //Get out of the textfield
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Termina edicion
        self.view.endEditing(true)
    }
    
    //Cuando das clic en return dek teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    //Function to get data with the celphone
    func getJson(telefon:String){
        
        let url = URL(string: "http://192.168.1.109:1000/api/InfoClientMobil/Celphone/5534959778")!
        
        let session = URLSession.shared;
        
        let loadTask = session.dataTask(with: url){(data,response,error) in
            if error != nil{
                print(error!)
            } else{
                if let urlContent = data{
                    
                    do{
                        let json = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        //let json = try? JSONSerialization.jsonObject(with: urlContent, options: [])
                        //print(json)
                        
                        //print(json)
                        /*let json2 = String(describing: json)
                         let newString = json2.replacingOccurrences(of: "(", with: "", options: .literal, range: nil)
                         let newString2 = newString.replacingOccurrences(of: ")", with: "", options: .literal, range: nil)
                         print(newString2)*/
                        
                        //let json2:String = "{\"id\": 24, \"name\": \"Bob Jefferson\", \"friends\": [{\"id\": 29, \"name\": \"Jen Jackson\"}]}"
                        
                        //let current = json.value(forKey: "Client") as! [String:Any]
                        //print(current)
                        
                        //let location = ((json["("] as? NSArray)?[0] as? NSDictionary)?["Client"] as? String
                        
                        //let arreglo = json.values(forAttributes: ["Policies"])
                        //necesito los parametros del array de polizas
                        /*let jokes = json.dictionaryWithValues(forKeys: ["Client"])
                         print(jokes)
                         
                         let cosita = jokes["Client"] as! NSArray
                         print(cosita)
                         
                         let co = cosita.count
                         print(co)
                         
                         let mini = cosita[0]
                         print(mini)*/
                        
                        
                        /*for object in datos {
                         // access all objects in array
                         print(object)
                         print("----")
                         }
                         
                         let id = polizas.value(forKey: "Coverage")
                         print(id)*/
                        
                        //print(location)
                        /*if let dictionary = json as? [String: Any] {
                         print(dictionary)
                         for (key, value) in dictionary {
                         // access all key / value pairs in dictionary
                         print(key)
                         print("-----------")
                         print(value)
                         print("***********")
                         }
                         }*/
                        
                        //if let descripton = ((json["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String{
                        //print(descripton)
                        /*DispatchQueue.main.sync(execute:{
                         self.result.text = descripton
                         })*/
                        //}
                        
                        //store do core data
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        let context = appDelegate.persistentContainer.viewContext
                        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
                        let requestpolizas = NSFetchRequest<NSFetchRequestResult>(entityName: "Polizas")

                        //Delete items from CoreData and get again!!!
                        let fetch = NSBatchDeleteRequest(fetchRequest: request)
                        let result = try context.execute(fetch)
                        let fetchpol = NSBatchDeleteRequest(fetchRequest: requestpolizas)
                        let resultpol = try context.execute(fetchpol)
                        print(result)
                        print(resultpol)
                        
                        //get client y save data
                        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
                        //get data from client....
                        let cliente = json.value(forKey: "Client") as! NSArray
                        print(cliente)
                        let cli = cliente[0] as! NSDictionary
                        print(cli)
                        print(cli.count)
                        
                        let idcliente = cli.value(forKey: "Id")
                        
                        //managedObject Core Data
                        for (key,value) in cli{
                         print("key: \(key) => value: \(value)")
                         let llave = String(describing: key).lowercased()
                         
                         if value == nil {
                            newUser.setValue("", forKey: llave)
                         }else if(llave == "id"){
                            newUser.setValue(value, forKey: llave)
                         }else{
                            //get string to save data
                            var valor = String(describing:value)
                            newUser.setValue(valor, forKey: llave)
                         }
                        }
                         
                         do {
                         
                         try context.save()
                         
                         print("Saved")
                         
                         } catch {
                         
                         print("There was an error")
                         
                         }
                        
                        //now the turn os for polizas
                        let newPoli = NSEntityDescription.insertNewObject(forEntityName: "Polizas", into: context)
                        //get data from client....
                        let polizas = json.value(forKey: "Policies") as! NSArray
                        print(polizas)
                        let poli = polizas[0] as! NSDictionary
                        print(poli)
                        print(poli.count)
                        
                        newPoli.setValue(idcliente, forKey: "idcliente")
                        //managedObject Core Data
                        let insu = poli["InsuranceCarrier"] as! NSDictionary
                        newPoli.setValue(insu["Name"], forKey: "insurance")
                        let stringodo = String(describing: poli["LastOdometer"])
                        newPoli.setValue(stringodo, forKey: "lastodometer")
                        newPoli.setValue(poli["NoPolicy"], forKey: "nopoliza")
                        let plizasid = poli["NoPolicy"]
                        let odometerbool = String(describing: (poli["HasOdometerPicture"]))
                        newPoli.setValue(odometerbool, forKey: "odometerpie")
                        let vehiclepool = String(describing: (poli["HasVehiclePictures"]))
                        newPoli.setValue(vehiclepool, forKey: "vehiclepie")
                        let rattt = String(describing: (poli["Rate"]))
                        newPoli.setValue(rattt, forKey: "rate")
                        
                        //with this let we cna get dat from the vehicle
                        let vehiculo = poli["Vehicle"] as! NSDictionary
                        do {
                            
                            try context.save()
                            
                            print("Saved")
                            
                        } catch {
                            
                            print("There was an error")
                            
                        }
                        

                        //now the turn os for polizas
                        let newCar = NSEntityDescription.insertNewObject(forEntityName: "Vehiculos", into: context)
                        //get data from client....
                        //let polizas = json.value(forKey: "Policies") as! NSArray
                        print(vehiculo)
                        let vei = vehiculo//[0] as! NSDictionary
                        print(vei)
                        print(vei.count)
                        
                        newCar.setValue(plizasid, forKey: "idpolizas")
                        //managedObject Core Data
                        let brand = vei["Brand"] as! NSDictionary
                        newCar.setValue(brand["Description"], forKey: "brand")
                        let capac = String(describing:vei["Capacity"])
                        newCar.setValue(capac, forKey: "capacidad")
                        newCar.setValue(vei["Color"], forKey: "color")
                        let descrii = vei["Description"] as! NSDictionary
                        newCar.setValue(descrii["Description"], forKey: "descripcion")
                        let modell = vei["Model"] as! NSDictionary
                        let modelito = String(describing:modell["Model"])
                        newCar.setValue(modelito, forKey: "model")
                        newCar.setValue(vei["Plates"], forKey: "plates")
                        let subtyoe = vei["Subtype"] as! NSDictionary
                        newCar.setValue(subtyoe["Description"], forKey: "subtype")
                        let tyype = vei["Type"] as! NSDictionary
                        newCar.setValue(tyype["Description"], forKey: "type")
                        let idc = String(describing:vei["Id"])
                        newCar.setValue(idc, forKey: "idcarro")
                        
                        //with this let we cna get dat from the vehicle
                        //let vehiculo = poli["Vehicle"] as! NSArray
                        do {
                            
                            try context.save()
                            
                            print("Saved")
                            
                        } catch {
                            
                            print("There was an error")
                            
                        }

                        
                    } catch{
                        print("Json process fail")
                    }
                }
            }
        }
        
        loadTask.resume()
    }

}

