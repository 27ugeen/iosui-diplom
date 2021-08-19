//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by GiN Eugene on 19.08.2021.
//

import UIKit

class HabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(rgb: 0xF2F2F7)

        let buttonAdd = UIBarButtonItem(image: UIImage(systemName: "plus"), style: UIBarButtonItem.Style.done, target: self, action: nil)
        buttonAdd.tintColor = UIColor(rgb: 0xA116CC)
        
        self.navigationItem.setRightBarButtonItems([buttonAdd], animated: true)
    }
    

}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
