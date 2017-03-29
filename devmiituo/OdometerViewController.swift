//
//  OdometerViewController.swift
//  devmiituo
//
//  Created by vera_john on 27/03/17.
//  Copyright © 2017 VERA. All rights reserved.
//

import UIKit

var picker2 = UIImagePickerController()

class OdometerViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate  {

    @IBOutlet var imageodometer: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        imageodometer.isUserInteractionEnabled = true
        imageodometer.addGestureRecognizer(tapGestureRecognizer)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //let picker = UIImagePickerController()
            picker2.delegate = self
            picker2.sourceType = UIImagePickerControllerSourceType.camera
            picker2.allowsEditing = true
            self.present(picker2, animated: true)
        } else {
            print("can't find camera")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker2.dismiss(animated: true, completion: nil)
        imageodometer.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        let imagennn = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        /*let comrimidad = compressImage(image: imagennn!)
        
        // to base64 => yhis is going to be in the thread to send photos
        //let imageData:NSData = UIImagePNGRepresentation(comrimidad)! as NSData
        
        let strBase64 = comrimidad.base64EncodedString(options: [])
        
        //print(strBase64)
        
        /// ----------- send iamge ------------ ///
        //let todosEndpoint: String = "http://192.168.1.109:1000/api/ImageProcessing/ConfirmOdometer"
        //let todosEndpoint: String = "http://192.168.1.109:1000/api/ImageProcessing/"
        let todosEndpoint: String = "http://192.168.1.109:1000/api/ClientUser/"
        
        guard let todosURL = URL(string: todosEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        var todosUrlRequest = URLRequest(url: todosURL)
        todosUrlRequest.httpMethod = "PUT"
        
        let newTodo: [String: Any] = ["Id": "70", "Name": "Edrei", "LastName":"bastar" ,"MotherName":"bastar","Celphone":"5534959778","Token":"aaaaaaaaaaa"]
        //let newTodo: [String: Any] = ["Type": "1", "Data": strBase64, "PolicyId":"59" ,"PolicyFolio":"8812345SJDH2"]
        //let newTodo: [String: Any] = ["Type": "1", "PolicyId":"59" ,"PolicyFolio":"884489275","Odometer":"1233333"]
        let jsonTodo: Data
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: newTodo, options: [])
            todosUrlRequest.httpBody = jsonTodo
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: todosUrlRequest) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on /todos/1")
                print(error)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                guard let receivedTodo = try JSONSerialization.jsonObject(with: responseData,
                                                                          options: []) as? [String: Any] else {
                                                                            print("Could not get JSON from responseData as dictionary")
                                                                            return
                }
                print("The todo is: " + receivedTodo.description)
                
                guard let todoID = receivedTodo["id"] as? Int else {
                    print("Could not get todoID as int from JSON")
                    return
                }
                print("The ID is: \(todoID)")
            } catch  {
                print("error parsing response from POST on /todos")
                return
            }
        }
        task.resume()*/
    }
    
    @IBAction func sendOdometer(_ sender: Any) {
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
