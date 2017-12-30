//
//  ViewController.swift
//  PayNPark
//
//  Created by Srikanth Srinivas on 12/28/17.
//  Copyright © 2017 Srikanth Srinivas. All rights reserved.
//

import UIKit
import Pastel
import Lottie
import Material
import PopupDialog
import Firebase

class PayNPark: UIViewController {

    @IBOutlet weak var checkAnimation: UIView!
    @IBOutlet weak var GoButton: RaisedButton!
    @IBOutlet weak var ParkingCode: TextField!
    @IBOutlet weak var LogoAnimation: UIView!
    @IBOutlet weak var GradientView: PastelView!
    let QRCodeLogo = LOTAnimationView(name: "cloud")
    var parkingCodeFromFirebase: String!
    let CheckLogo = LOTAnimationView(name: "simple_tick")
    let serviceCalls = ServiceCalls()
    
    
    override func viewDidLoad() {
        
        prepareGoButton()
        prepareTitleTextField()
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        GradientView.setColors([#colorLiteral(red: 0.05296700448, green: 0.1554270983, blue: 0.3375893831, alpha: 1),#colorLiteral(red: 0.2513618469, green: 0.5344406962, blue: 1, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)])
        GradientView.animationDuration = 3.0
        LogoAnimation.handledAnimation(Animation: QRCodeLogo)
        QRCodeLogo.play()
        QRCodeLogo.loopAnimation = true
        checkAnimation.handledAnimation(Animation: CheckLogo)
        checkAnimation.isHidden = true
        self.hideKeyboardWhenTappedAround()
        serviceCalls.getParkingAreaCode { (code) in
            self.parkingCodeFromFirebase = code
            print(self.parkingCodeFromFirebase)
        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        GradientView.startAnimation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        GradientView.startAnimation()
        
    }
    
    @IBAction func goButtonPressed(_ sender: Any) {
        if ParkingCode.isEmpty{
            let codeErrorPopup = preparePopupForWrongCode()
            self.present(codeErrorPopup, animated: true, completion: nil)
            
        }
        
        else if ParkingCode.text == parkingCodeFromFirebase{
            checkAnimation.isHidden = false
            GoButton.isHidden = true
            CheckLogo.play()
        }
        
        else{
            let codeErrorPopup = preparePopupForWrongCode()
            self.present(codeErrorPopup, animated: true, completion: nil)
        }
    }
    
    
    func prepareGoButton(){
        
        self.GoButton.image = Icon.cm.check
    }
    
    func preparePopupForWrongCode() -> PopupDialog{
        
        let popupTitle = "Error"
        let popupMessage = "You have entered an incorrect parking code"
        let wrongCodePopup = PopupDialog(title: popupTitle, message: popupMessage)
        return wrongCodePopup
    }
    
    func prepareTitleTextField(){
        
        self.ParkingCode.dividerNormalColor = Color.white
        self.ParkingCode.dividerActiveColor = Color.white
        self.ParkingCode.placeholderLabel.font = UIFont(name: "Century Gothic", size: 17)
        self.ParkingCode.font = UIFont(name: "Century Gothic", size: 17)
        self.ParkingCode.textColor = Color.white
        self.ParkingCode.placeholder = "Parking Code"
        self.ParkingCode.placeholderActiveColor = Color.white
        self.ParkingCode.placeholderNormalColor = Color.white
        self.ParkingCode.detail = "Enter your parking area code"
        self.ParkingCode.detailColor = Color.white
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

