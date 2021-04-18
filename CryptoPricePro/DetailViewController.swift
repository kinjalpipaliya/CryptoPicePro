//
//  DetailViewController.swift
//  CryptoPricePro
//
//  Created by Kinjal Pipaliya on 16/01/21.
//  Copyright © 2021 Kinjal Pipaliya. All rights reserved.
//

import UIKit
import SwiftSVG
import Charts

class DetailViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet var coinImage : UIView!
    @IBOutlet var coinName : UILabel!
    @IBOutlet var graphView : LineChartView!
        
    var marketCap = [String]()

    override func viewDidLoad(){
        super.viewDidLoad()
        graphView.delegate = self
    }
    
    var coinNameVar = ""
    var coinImageIcon = ""
    
    override func viewWillAppear(_ animated: Bool) {
        coinName.text = coinNameVar
        
        let svgURL = URL(string: coinImageIcon)!
        let hammock = UIView(SVGURL: svgURL) { (svgLayer) in
            svgLayer.resizeToFit(self.coinImage.bounds)
        }
        coinImage.addSubview(hammock)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var entry = [ChartDataEntry]()
        
        for x in 0..<marketCap.count{
            entry.append(ChartDataEntry(x: Double(x), y: Double(x)))
        }
        let set = LineChartDataSet(entries: entry)
        set.colors = ChartColorTemplates.colorful()
        let data = LineChartData(dataSet: set)
        graphView.data = data
        graphView.tintColor = .red
        graphView.gridBackgroundColor = .green
    }

    @IBAction func backTapped(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
}
