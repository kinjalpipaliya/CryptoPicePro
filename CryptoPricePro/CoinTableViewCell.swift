//
//  CoinTableViewCell.swift
//  CryptoPricePro
//
//  Created by Kinjal Pipaliya on 11/01/21.
//  Copyright © 2021 Kinjal Pipaliya. All rights reserved.
//

import UIKit

class CoinTableViewCell: UITableViewCell {
    @IBOutlet var coinName : UILabel!
    @IBOutlet var coinSymbol : UILabel!
    @IBOutlet var coinPrice : UILabel!
    @IBOutlet var coinIcon : UIView!
    
    var coinObject : Coin?
    
    var signObject : Base?{
        didSet{
            coinPrice.attributedText = getAttributedStringByAppending(sign: signObject?.sign ?? "", price: coinObject?.price ?? "")
        }
    }
    
    func getAttributedStringByAppending(sign:String,price:String) -> NSMutableAttributedString{
        let newAttributedString = NSMutableAttributedString(string: sign, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)])
        let newAttributedString2 = NSMutableAttributedString(string: price, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)])
        newAttributedString.append(newAttributedString2)
        return newAttributedString
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.coinIcon.layer.cornerRadius = coinIcon.frame.height/2
//        self.coinIcon.layer.shadowColor = UIColor.gray.cgColor
//        self.coinIcon.layer.shadowRadius = 5
//        self.coinIcon.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        self.coinIcon.layer.shadowOpacity = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

