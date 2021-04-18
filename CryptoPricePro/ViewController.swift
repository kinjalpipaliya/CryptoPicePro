//
//  ViewController.swift
//  CryptoPricePro
//
//  Created by Kinjal Pipaliya on 11/01/21.
//  Copyright © 2021 Kinjal Pipaliya. All rights reserved.
//

import UIKit
//import JGProgressHUD
import SwiftSVG
import GoogleMobileAds

class ViewController: UIViewController, GADFullScreenContentDelegate {
    
    @IBOutlet var coinListTableView : UITableView!{
        didSet{
            coinListTableView.register(UINib(nibName: "CoinTableViewCell", bundle: nil), forCellReuseIdentifier: "CoinTableViewCell")
        }
    }
    @IBOutlet var searchCoin : UITextField!
    
    var coinDataArray = [Coin](){
        didSet{
            DispatchQueue.main.async {
                self.coinListTableView.reloadData()
            }
        }
    }
    
    var filteredArray = [Coin](){
        didSet{
            DispatchQueue.main.async {
                self.coinListTableView.reloadData()
            }
        }
    }
    
    var signArray : Base?
    var dollar : String?
    var isSearching = false
    var coinPrice : String?
    private var interstitial: GADInterstitialAdBeta?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiCall()
//        let hud = JGProgressHUD()
//        hud.textLabel.text = "Loading"
//        hud.show(in: self.view)
//        hud.dismiss(afterDelay: 4.0)
    }
    
    func apiCall(){
        let session = URLSession.shared
        let url = URL(string: "https://api.coinranking.com/v1/public/coins")
        let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let data = data,
               let json = try? JSONDecoder().decode(Welcome.self, from: data) {
                self.coinDataArray = (json.data?.coins)!
                self.signArray = json.data?.base
                self.dollar = self.signArray?.sign
                
                print("dollar sign:\(self.dollar)")
                
            }else{
                print("error:\(error?.localizedDescription)")
            }
        })
        task.resume()
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isSearching && searchCoin.text == ""{
            return coinDataArray.count
        }else{
            return filteredArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinTableViewCell", for: indexPath) as! CoinTableViewCell
        
        if isSearching{
            
            cell.coinObject = filteredArray[indexPath.row]
            cell.signObject = signArray
            
            cell.coinName.text = filteredArray[indexPath.row].name
            
            cell.coinSymbol.text = filteredArray[indexPath.row].symbol
            
            cell.coinIcon.subviews.forEach({ $0.removeFromSuperview() })
            
            let svgURL = URL(string: filteredArray[indexPath.row].iconURL ?? "" )!
            let hammock = UIView(SVGURL: svgURL) { (svgLayer) in
                svgLayer.resizeToFit(cell.coinIcon.bounds)
            }
            cell.coinIcon.addSubview(hammock)
        }else{
            
            cell.coinObject = coinDataArray[indexPath.row]
            cell.signObject = signArray
            
            cell.coinName.text = coinDataArray[indexPath.row].name
            
            cell.coinSymbol.text = coinDataArray[indexPath.row].symbol
            
            cell.coinIcon.subviews.forEach({ $0.removeFromSuperview() })
            let svgURL = URL(string: coinDataArray[indexPath.row].iconURL ?? "")!
            let hammock = UIView(SVGURL: svgURL) { (svgLayer) in
                svgLayer.resizeToFit(cell.coinIcon.bounds)
            }
            cell.coinIcon.addSubview(hammock)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        navigationController?.pushViewController(detailVC, animated: true)
        detailVC.coinNameVar = coinDataArray[indexPath.row].name ?? ""
        detailVC.coinImageIcon = coinDataArray[indexPath.row].iconURL ?? ""
        detailVC.marketCap = coinDataArray[indexPath.row].history ?? []
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
}

