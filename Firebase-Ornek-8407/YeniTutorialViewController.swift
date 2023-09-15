//
//  YeniTutorialViewController.swift
//  Firebase-Ornek-8407
//
//  Created by Opendart Yazılım ve Bilişim Hizmetleri on 18.03.2023.
//

import UIKit
import FirebaseDatabase

class YeniTutorialViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    @IBOutlet weak var tutorialsTableView : UITableView!
    @IBOutlet weak var txtTutorialTitle: UITextField!
    @IBOutlet weak var txtTutorialDescription: UITextField!
    
    @IBAction func btnTutorialAction(_ sender: Any) {
        
        let title = txtTutorialTitle.text!
        let description = txtTutorialDescription.text!
        //firebase database indeki tutorials tablosundan bir nesne oluşturucak
        let ref = Database.database().reference(withPath: "tutorials") // database e erişiyoruz
        let uuid = UUID().uuidString // kayıt eklerken bir uuid oluştursun
        //{"title":title,"description":description} json
        //insert into tutorials(title,description) values("abc","abc"). tutorials tablosunun title/description kolonlarına values daki değerlerini kaydeder
        ref.child(uuid).setValue((["title": title, "description" : description])) // firebase e kayıt ekleme. eklenen kayıt sanırım herkeste gözüküyor
        print("kayıt eklendi")
    }
    
    var tutorials = [Tutorial]() // Tutorial tipinde veri alan bir array oluşturuyoruz
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tutorialYukle()
    }
    
    func tutorialYukle()
    {
        let ref = Database.database().reference(withPath: "tutorials")
        //select * from tutorials
        ref.observe(.value) {(snapshot) in // firebase deki bütün kayıtları çek. kayıt olduğu sürece bunları al ve Tutorial tipinde veri alan bir array in içine tek tek ekle
            if snapshot.childrenCount > 0 {
                
                //["title":"tutorial1,"description:"tutorial desc1",title:"tutorial2,description:"tutorial desc 2] böyle bir array geliyor
                for tutorial in snapshot.children.allObjects as! [DataSnapshot] { // burdan json data gibi firebase deki datalar gelecek ve bizim bunları ios un kendi objelerine dönüştürmemiz gerekecek
                    if let tutorialObject = tutorial.value as? [String : Any], // gelen verinin içerisinde yeni bir tutorialObject oluştur, string i keyvalue suyla beraber
                       let title = tutorialObject["title"] as? String, // o tutorialObject in title ındaki değer neyse onu title değişkenine ata
                       let description = tutorialObject["description"] as? String { // o tutorialObject in description ındaki değer neyse onu description değişkenine ata
                        let benimObjem = Tutorial(title: title,description: description) // Tutorial struct ımdaki title ve description değişkenlerine o an gelen title ve descriptionları ver. burada yeni bir tutorial objesi oluşturduk
                        self.tutorials.append(benimObjem) // oluşturduğumuz objeyi de içine Tutorial tipinde veri alan arraya ekle
                    }
                }
                self.tutorialsTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutorials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tutorialsTableView.dequeueReusableCell(withIdentifier: "tutorialCell") as! TutorialTableViewCell
        let tutorial = tutorials[indexPath.row]
        cell.txtTitle.text = tutorial.title
        cell.txtDescription.text = tutorial.description
        return cell
    }
    

}
