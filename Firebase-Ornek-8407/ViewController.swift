//
//  ViewController.swift
//  Firebase-Ornek-8407
//
//  Created by Opendart Yazılım ve Bilişim Hizmetleri on 18.03.2023.
//

import UIKit
import Firebase

// backend tarafında bir programlama dili bilmiyorsak (fullstack değilsek) bu uygulama içerisindeki verileri lokal database e kaydederiz ama bi güncelleme yaptığımızda o değişikliklerin herkeste yansıması için bütün kullanıcıların aynı database e erişebiliyo olması gerekir. lokal database de tutulursa değişikliklerden haberdar olamazlar. o yüzden firebase herkesin erişebileceği bir web adresi gibi bir url de dataları tutar. bunu tutarken de json formatında verileri tutar. kayıtları eklerken güncellerken ve silerken çalışan bir yapısı olan ve kendi syntax ıyla beraber, json formatı üzerinde çalışan bir programlama dili geliştirmişler. dolayısıyla java csharp vs gibi diller bilmemize gerek kalmadan sanki backend kodları olan bir uygulamaymış gibi uygulamamızı çalıştırabiliyoruz. firebase hem data saklar hem de her yerden erişilebilirdir. 1gb ye kadar ücretsiz. sol tarafta eklediğimiz (hoca başta yanlış şekilde ekliyo sonradan düzeltiyo) GoogleService-Info dosyası sayesinde firebase ile uygulamamız bu dosya üzerinden haberleşebilir. bize verdiği bi id numarası vardır GoogleService-Info nun. source code u açtığımızda kodlar içinde görürüz. firebase de realtime database oluşturduğumuzda her yerden erişilebilir olur. authentication ile kullanıcıların database e hangi account ile bağlanacağı belirlenir. yani uygulamaya kullanıcıların nasıl erişeceği. uygulamayı kullanacak kişilerin kaydı tutulur (facebook gmail apple vs bunların desteğini verir firebase. bunları kullanarak kullanıcılar account oluşturabilir). firebase deki özelliklerden biri de kullanıcılara mail gönderebilmektir. cloud messaging i seçerek yapılır.

class ViewController: UIViewController {

    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func btnKayitOlAction(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { // createUser ile kullanıcı bilgileri kaydedilir
        authData,error in
            if error != nil {
                print("kayıt eklenirken bir hata oluştu")
            }
           else
            {
               print("kayıt başarılı")
               let navStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
               let tutorialViewController = navStoryBoard.instantiateViewController(withIdentifier: "TutorialViewControllerID") as! YeniTutorialViewController
               self.navigationController?.pushViewController(tutorialViewController, animated:true)
           }
        }
        
    }
    
    @IBAction func btnGirisYapAction(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) {
        authData,error in
            if error != nil {
                print("giriş yapılırken bir hata oluştu : " + (error?.localizedDescription ?? "")) // error?.localizedDescription hatayı yazdırır
            }
           else
            {
               let navStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
               let tutorialViewController = navStoryBoard.instantiateViewController(withIdentifier: "TutorialViewControllerID") as! YeniTutorialViewController
               self.navigationController?.pushViewController(tutorialViewController, animated:true)
           }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

