//
//  DeleteButton.swift
//  Canva
//
//  Created by Samaneh Fathieh on 2/6/18.
//  Copyright © 2018 Thien Nguyen. All rights reserved.
//

import UIKit

class DeleteButton: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        let button2 = UIButton(frame: CGRect(x: 100, y:  100, width: 100, height: 50))
        button2.backgroundColor = .green
        button2.setTitle("Delete 2", for: .normal)
        //        button2.tag = 23
        //        button2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.addSubview(button2)
        //        self.addSubview(button2)
        //        delegate?.selectedSticker(id: self.id)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("man injam")
        
    }
    
}
