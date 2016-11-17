//
//  HistoryViewController.swift
//  DiApptic
//
//  Created by Faheem Hussain on 11/14/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit
import Charts

class HistoryViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var pieChartView: PieChartView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        // Do any additional setup after loading the view.
        //lineChartView.description = " "
        //pieChartView.description = " "
        lineChartView.delegate = self
        lineChartView.chartDescription?.text = "Line Chart"
        pieChartView.chartDescription?.text = "Pie Chart"
        let readingTypes = ["Highs", "Lows", "Normals"]
        let pieReadings = [200.0,100.0, 300.0]
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        setChart(dataPoints: months, values: unitsSold)
        setPieChart(dataPoints: readingTypes, values: pieReadings)
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
            dataEntries.append(dataEntry)
        }

        //let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Readings")
        //let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        //let pieChartData = PieChartData(dataSet: pieChartDataSet)
        //pieChartView.data = pieChartData
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Readings")
        //let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
    }
    func setPieChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        for entry in values {
            let dataEntry = ChartDataEntry(x: entry, y: entry)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Readings")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        /*
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }*/
        // light green
        let normalColor = UIColor(red: 132.0/255.0, green: 209.0/255.0, blue: 148.0/255.0, alpha: 1)
        // light yellow
        let lowColor = UIColor(red: 235.0/255.0, green: 216.0/255.0, blue: 124.0/255.0, alpha: 1)
        // light red
        let highColor = UIColor(red: 250.0/255.0, green: 137.0/255.0, blue: 137.0/255.0, alpha: 1)

        pieChartDataSet.colors = [normalColor, lowColor, highColor]
        
    }
    
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        print("chart translated")
    }
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        print("chart scaled")
    }
}
