//
//  DetallePolizaViewController.swift
//  miituo
//
//  Created by vera_john on 14/03/17.
//  Copyright © 2017 VERA. All rights reserved.
//

import UIKit

class DetallePolizaViewController: UIViewController {

    //var idPoliza:String = "prueba"
    
    @IBOutlet var placas: UILabel!
    @IBOutlet var nombre: UILabel!
    
    @IBOutlet var modelo: UILabel!
    //@IBOutlet var placas: UILabel!
    
    //@IBOutlet var labelInfo: UILabel!
    
    var identificador:Int = 0
    var cadenas:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nombre.text = arreglo[Int(valueToPass)!]["name"]
        placas.text = arreglocarro[Int(valueToPass)!]["plates"]
        modelo.text = arreglocarro[Int(valueToPass)!]["model"]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
