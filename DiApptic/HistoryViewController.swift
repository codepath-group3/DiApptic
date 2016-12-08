//
//  HistoryViewController.swift
//  DiApptic
//
//  Created by Faheem Hussain on 11/14/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit
import Charts

class XAxisDateFormatter:NSObject, IAxisValueFormatter {
    var dates: [Date] = []
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: dates[Int(value)])
        let day = calendar.component(.day, from: dates[Int(value)])
        return "\(month)/\(day)"
    }
}
class PieChartValueFormatter: NSObject, IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return "\(Int(value))"
    }
}
class HistoryViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var highestValueLabel: UILabel!
    @IBOutlet weak var lowestValueLabel: UILabel!
    @IBOutlet weak var filtersViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lineChartViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    
    var filterMenu: HorizontalButtonsList!
    let medicationFilters: [Medication] = [Medication.insulin, Medication.pill]
    let statusFilters: [Status] = [Status.fasting, Status.beforeMeal, Status.afterMeal]
    
    var isMenuOpen: Bool! {
        didSet {
            if isMenuOpen! {
                
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: [.curveEaseInOut], animations: {
                    self.filtersViewHeightConstraint.constant = 50.0
                    self.lineChartViewBottomConstraint.constant = -50
                    self.menuView.addSubview(self.filterMenu)
                    self.view.layoutIfNeeded()
                }, completion: {
                    (value: Bool) in

                })
            }else {
                filterMenu.removeFromSuperview()
                UIView.animate(withDuration: 0.2, animations: {
                    self.filtersViewHeightConstraint.constant = 0
                    self.lineChartViewBottomConstraint.constant = 0
                    self.filterMenu.isShowing = false;
                    self.view.layoutIfNeeded()
                })
            }
        }
    }

    let xAxisDateFormatter: XAxisDateFormatter = XAxisDateFormatter()
    var dataByDate: [[Reading]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        let filtersButton = UIBarButtonItem(image: UIImage(named:"kebab24x24"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(HistoryViewController.showFilters))
        self.navigationItem.rightBarButtonItem = filtersButton
        filterMenu = HorizontalButtonsList(inView: view)
        filterMenu.didSelectFilter = {button in
            self.isMenuOpen = false
            var filtered: [Reading]!
            if button.tag < 3 {
                print(button.tag)
                filtered = Reading.filter(medication: nil, status: self.statusFilters[button.tag])
            }else {
                filtered = Reading.filter(medication: self.medicationFilters[button.tag - 3], status: nil)
            }
            self.setChartReadings(readings: filtered)
        }
        isMenuOpen = false
        // Do any additional setup after loading the view.
        //lineChartView.description = " "
        //pieChartView.description = " "
        lineChartView.delegate = self
        lineChartView.chartDescription?.text = " "
        lineChartView.drawGridBackgroundEnabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.legend.enabled = false
        let x = lineChartView.xAxis
        x.drawGridLinesEnabled = false
        x.labelPosition = .bottom
        x.valueFormatter = xAxisDateFormatter
        
        let lowLine: ChartLimitLine = ChartLimitLine(limit: 70.0, label: "")
        lowLine.lineColor = UIColor.yellow
        lineChartView.leftAxis.addLimitLine(lowLine)
        let highLine: ChartLimitLine = ChartLimitLine(limit: 200.0, label: "")
        highLine.lineColor = UIColor.red
        lineChartView.leftAxis.addLimitLine(highLine)
        
        
        pieChartView.chartDescription?.text = " "
        let attrString = NSMutableAttributedString(string: "999")
        attrString.setAttributes([
            NSForegroundColorAttributeName: NSUIColor.black,
            NSFontAttributeName: NSUIFont.systemFont(ofSize: 30.0),
            NSParagraphStyleAttributeName: NSParagraphStyle.default.mutableCopy()
            ], range: NSMakeRange(0, attrString.length))
        pieChartView.centerAttributedText = attrString
        //pieChartView.entryLabelFont = NSUIFont.systemFont(ofSize: 30.0)
        //pieChartView.centerText = "185"
        let l: Legend = pieChartView.legend;
        l.form = .circle
        l.formSize = 20.0
        //l.orientation = .vertical
        l.horizontalAlignment = .center
        l.verticalAlignment = .top
        l.xEntrySpace = 50.0
        l.yEntrySpace = 50.0
        l.yOffset = 10.0
        pieChartView.legend.enabled = false
        
        let pieChartAverageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 25))
        pieChartAverageLabel.text = "Average"
        pieChartAverageLabel.textAlignment = .center
        pieChartAverageLabel.textColor = Styles.darkGray
        pieChartAverageLabel.font = UIFont(name: pieChartAverageLabel.font.fontName, size: 12.0)
        let pieChartMgdlLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 25))
        pieChartMgdlLabel.text = "mg/dL"
        pieChartMgdlLabel.textAlignment = .center
        pieChartMgdlLabel.textColor = Styles.darkGray
        pieChartMgdlLabel.font = UIFont(name: pieChartMgdlLabel.font.fontName, size: 12.0)
        
        pieChartView.addSubview(pieChartAverageLabel)
        pieChartAverageLabel.center = CGPoint(x: pieChartView.center.x , y: pieChartView.center.y - 22)
        pieChartView.addSubview(pieChartMgdlLabel)
        pieChartMgdlLabel.center = pieChartView.center
        pieChartMgdlLabel.center = CGPoint(x: pieChartView.center.x , y: pieChartView.center.y + 20)
        
        //l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
        //l.verticalAlignment = ChartLegendVerticalAlignmentTop;
        //l.orientation = ChartLegendOrientationVertical;
        //l.drawInside = NO;
        //l.xEntrySpace = 7.0;
        //l.yEntrySpace = 0.0;
        //l.yOffset = 0.0;

        //setChart(months, values: unitsSold)
        //setScatterChart()
        setChartReadings(readings: getReadings(maxPerDay: 3))
        /*
        let sChartData = toScatterChartData(readings: getReadings(maxPerDay: 3))
        //lineChartView.maxVisibleCount = 10
        //lineChartView.setVisibleXRange(minXRange: Double(xAxisDateFormatter.dates.count) - 10, maxXRange: Double(xAxisDateFormatter.dates.count))
        //x.axisMaximum = Double(xAxisDateFormatter.dates.count)
        //x.axisMinimum = Double(xAxisDateFormatter.dates.count) - 10
        
        //lineChartView.setScaleMinima(10, scaleY: 1)
        lineChartView.data = sChartData
        lineChartView.setVisibleXRangeMaximum(5)
        lineChartView.moveViewToX(Double(xAxisDateFormatter.dates.count) - 5)
        //lineChartView.centerViewTo(xValue: Double(xAxisDateFormatter.dates.count) - 10, yValue: 1, axis: .left)
        //lineChartView.viewpo
        //setPieChart(dataPoints: readingTypes, values: pieReadings)
        adjustPieChart()
        
        ParseUtils.getReadings(userId: " ", success: { (readings: [Reading]) in
            print("retrieved readings")
        }, failure: {
            
        })*/

    }
    func setChartReadings(readings: [Reading]){
        let sChartData = toScatterChartData(readings: readings)
        lineChartView.data = sChartData
        lineChartView.setVisibleXRangeMaximum(5)
        //lineChartView.moveViewToX(Double(xAxisDateFormatter.dates.count) - 5)
        lineChartView.moveViewToAnimated(xValue: Double(xAxisDateFormatter.dates.count) - 5, yValue: 0, axis: lineChartView.leftAxis.axisDependency, duration: 1.0)
        adjustPieChart()
    }
    func showFilters(){
        isMenuOpen = !isMenuOpen
    }
    func getReadings( maxPerDay: Int) -> [Reading]{
        return Reading.getRandomReadings()
    }
    
    func toScatterChartData(readings: [Reading]) -> ScatterChartData{
        
        var entrySets = [[ChartDataEntry]]()
        var dataSets: [ScatterChartDataSet] = []
        var dayReadings: [Reading] = []
        var previousReading: Reading? = nil
        xAxisDateFormatter.dates = []
        // Group readings by day
        for reading in readings {
            // the assumption is that readings are ordered by date
            if previousReading == nil {
                previousReading = reading
            }
            let order = Calendar.current.compare(reading.timestamp, to: (previousReading?.timestamp)!, toGranularity: .day)
            if order != .orderedSame {
                dataByDate.append(dayReadings)
                dayReadings = []
            }
            dayReadings.append(reading)
            previousReading = reading
        }
        // Create Entry Sets
        for (dateIndex, thisDayReadings) in dataByDate.enumerated() {
            xAxisDateFormatter.dates.append(thisDayReadings[0].timestamp)
            for (index, reading) in thisDayReadings.enumerated() {
                if !entrySets.indices.contains(index) {
                    let entriesSet: [ChartDataEntry] = []
                    entrySets.append(entriesSet)
                }
                entrySets[index].append(ChartDataEntry(x: Double(dateIndex), y: Double(reading.value), data: reading))
            }
        }
        // Put Entry Sets into ChartDataSets
        for entrySet in entrySets {
            let ds = ScatterChartDataSet(values: entrySet)
            ds.setScatterShape(.circle)
            //ds.setScatterShape(.)
            dataSets.append(ds)
        }
        let data = ScatterChartData(dataSets: dataSets)
        return data
    }
    func setPieChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        var index = 0
        for entry in values {
            let pEntry = PieChartDataEntry(value: entry, label: dataPoints[index])
            //let dataEntry = ChartDataEntry(x: entry, y: entry)
            dataEntries.append(pEntry)
            index += 1
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setValueFont(NSUIFont.systemFont(ofSize: 14.0))
        // light green
        let normalColor = UIColor(red: 132.0/255.0, green: 209.0/255.0, blue: 148.0/255.0, alpha: 1)
        // light yellow
        let lowColor = UIColor(red: 235.0/255.0, green: 216.0/255.0, blue: 124.0/255.0, alpha: 1)
        // light red
        let highColor = UIColor(red: 250.0/255.0, green: 137.0/255.0, blue: 137.0/255.0, alpha: 1)
        
        pieChartDataSet.colors = [normalColor, lowColor, highColor]
        
        pieChartView.data = pieChartData
        //pieChartView.animate(xAxisDuration: TimeInterval(100), yAxisDuration: TimeInterval(100))
        //pieChartView.spin(duration: 500, fromAngle: 0, toAngle: 360)
        
    }
    var debounceTimer: Timer?
    func debounce() {
        if let timer = debounceTimer {
            timer.invalidate()
        }
        debounceTimer = Timer(timeInterval: 0.2, target: self, selector: #selector(HistoryViewController.adjustPieChart), userInfo: nil, repeats: false)
        RunLoop.current.add(debounceTimer!, forMode: .defaultRunLoopMode)
    }
    
    func adjustPieChart() {
        let fromIndex = Int(lineChartView.lowestVisibleX)
        let toIndex = Int(lineChartView.highestVisibleX)
        var highest: Double = 0
        var lowest: Double = 9999
        var highs: Double = 0
        var lows: Double = 0
        var normals: Double = 0
        var totalCount: Double = 0
        var total: Double = 0
        for index in fromIndex...toIndex {
            for reading in dataByDate[index] {
                let readingValue = Double(reading.value)
                if reading.isLow() {
                    lows += 1
                }else if reading.isHigh() {
                    highs += 1
                }else {
                    normals += 1
                }
                totalCount += 1
                total += readingValue
                if readingValue > highest {
                    highest = readingValue
                }
                if readingValue < lowest {
                    lowest = readingValue
                }
            }
        }
        let lowEntry = PieChartDataEntry(value: lows, label: "Lows")
        let normalEntry = PieChartDataEntry(value: normals, label: "Normals")
        let highEntry = PieChartDataEntry(value: highs, label: "Highs")
        let pieChartDataSet = PieChartDataSet(values: [lowEntry, normalEntry, highEntry], label: "")
        // light green
        let lowColor = UIColor(red: 132.0/255.0, green: 209.0/255.0, blue: 148.0/255.0, alpha: 1)
        // light yellow
        let  normalColor = UIColor(red: 235.0/255.0, green: 216.0/255.0, blue: 124.0/255.0, alpha: 1)
        // light red
        let highColor = UIColor(red: 250.0/255.0, green: 137.0/255.0, blue: 137.0/255.0, alpha: 1)
        pieChartDataSet.colors = [normalColor, lowColor, highColor]
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setValueFont(NSUIFont.systemFont(ofSize: 14.0))
        pieChartData.setValueFormatter(PieChartValueFormatter())
        let attrString = NSMutableAttributedString(string: "\(Int(total/totalCount))")
        attrString.setAttributes([
            NSForegroundColorAttributeName: NSUIColor.black,
            NSFontAttributeName: NSUIFont.systemFont(ofSize: 30.0),
            NSParagraphStyleAttributeName: NSParagraphStyle.default.mutableCopy()
            ], range: NSMakeRange(0, attrString.length))
        pieChartView.centerAttributedText = attrString
        pieChartView.data = pieChartData
        totalCountLabel.text = "\(Int(totalCount))"
        highestValueLabel.text = "\(Int(highest))"
        lowestValueLabel.text = "\(Int(lowest))"
    }
    func adjustLabels(){
        
    }
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        //debounce()
        adjustPieChart()
        adjustLabels()
    }
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        adjustPieChart()
    }
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let readingDetailsViewController = ReadingDetailsViewController(nibName: "ReadingDetailsViewController", bundle: nil)
        readingDetailsViewController.reading = entry.data as! Reading
        self.navigationController?.pushViewController(readingDetailsViewController, animated: true)
        
    }
}
