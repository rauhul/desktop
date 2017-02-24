//
//  WeatherWidget.swift
//  desktop
//
//  Created by Rauhul Varma on 12/18/16.
//  Copyright © 2016 rvarma. All rights reserved.
//

import Cocoa

class WeatherWidget: WidgetController {
    
    @IBOutlet weak var noLocationLabel: NSTextField!
    @IBOutlet weak var mainStackView: NSStackView!

    @IBOutlet weak var icon: NSImageView!
    @IBOutlet weak var windChimeIcon: NSImageView!
    
    @IBOutlet weak var minTempLabel: NSTextField!
    @IBOutlet weak var curTempLabel: NSTextField!
    @IBOutlet weak var maxTempLabel: NSTextField!
    
    @IBOutlet weak var summaryLabel: NSTextField!

    @IBOutlet weak var sunriseLabel:    NSTextField!
    @IBOutlet weak var sunsetLabel:     NSTextField!
    @IBOutlet weak var humidityLabel:   NSTextField!
    @IBOutlet weak var windSpeedLabel:  NSTextField!

    override var REFRESH_INTERVAL: TimeInterval { return 2.5 * 60.0 }
    
    let formatter = DateFormatter()

    let API_KEY = "7a8bd689cbf941bd742c1502db6fee36"
    var LOCATION: String? {
        return LocationManager.shared.locationAsCSV
    }
    let DEFAULT_ICON = NSImage(named: "refresh")!
    let COMPASS_N  = NSImage(named: "compass-n")!
    let COMPASS_NE = NSImage(named: "compass-ne")!
    let COMPASS_E  = NSImage(named: "compass-e")!
    let COMPASS_SE = NSImage(named: "compass-se")!
    let COMPASS_S  = NSImage(named: "compass-s")!
    let COMPASS_SW = NSImage(named: "compass-sw")!
    let COMPASS_W  = NSImage(named: "compass-w")!
    let COMPASS_NW = NSImage(named: "compass-nw")!
    let WIND_SYMBOL = NSImage(named: "wind-symbol")!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        formatter.timeStyle = .short
    }
    
    override func willRefreshWidget() {
        super.willRefreshWidget()
    }
    
    override func refreshWidget() {
        willRefreshWidget()
        
        guard let LOCATION = LOCATION else {
            mainStackView.isHidden = true
            noLocationLabel.isHidden = false
            self.didRefreshWidget()
            return
        }
        noLocationLabel.isHidden = true
        mainStackView.isHidden = false

        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        let url = URL(string: "https://api.forecast.io/forecast/\(API_KEY)/\(LOCATION)?units=auto&exclude=minutely,hourly,alerts,flags")
        
        dataTask = defaultSession.dataTask(with: url!) { data, response, error in
            var failure: String? = "Generic Failure"
            
            defer {
                self.didRefreshWidget()
                if let failure = failure {
                    print(failure)
                    DispatchQueue.main.async {
                        self.view.layer?.backgroundColor = NSColor.red.cgColor
                        self.summaryLabel.stringValue = failure
                    }
                }
            }
            
            if let error = error {
                print(error.localizedDescription)
                failure = error.localizedDescription
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, let data = data, httpResponse.statusCode == 200 else {
                failure = "Could not decode response or status code != 200"
                return
            }
    
            let jsonObject = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            
            guard let json = jsonObject as? [String: Any] else {
                failure = "Could not transform response to dictionary"
                return
            }
            
            guard let currently = json["currently"] as? [String: Any],
                  let temp      = currently["apparentTemperature"] as? Double,
                  let icon      = currently["icon"] as? String,
                  let humidity  = currently["humidity"] as? Double,
                  let windSpeed = currently["windSpeed"] as? Double,
                  let cSummary  = currently["summary"] as? String,
                  let windBearing = currently["windBearing"] as? Double,
                  let daily     = json["daily"] as? [String: Any],
                  let days      = daily["data"] as? [[String: Any]],
                  let today     = days.first,
                  let summary   = today["summary"] as? String,
                  let min       = today["apparentTemperatureMin"] as? Double,
                  let max       = today["apparentTemperatureMax"] as? Double,
                  let sunrise   = today["sunriseTime"] as? TimeInterval,
                  let sunset    = today["sunsetTime"] as? TimeInterval
            else {
                failure = "Could not extract all the required information"
                return
            }
            
            guard let image = NSImage(named: icon) else {
                failure = "Could not find image named: \(icon)"
                return
            }
            
            failure = nil

            let sunriseDate = Date(timeIntervalSince1970: sunrise)
            let sunsetDate = Date(timeIntervalSince1970: sunset)

            let windImage: NSImage
            switch windBearing {
            case 0..<22.5:
                windImage = self.COMPASS_N
            case 22.5..<67.5:
                windImage = self.COMPASS_NE
            case 67.5..<112.5:
                windImage = self.COMPASS_E
            case 112.5..<157.5:
                windImage = self.COMPASS_SE
            case 157.5..<202.5:
                windImage = self.COMPASS_S
            case 202.5..<247.5:
                windImage = self.COMPASS_SW
            case 247.5..<292.5:
                windImage = self.COMPASS_W
            case 292.5..<337.5:
                windImage = self.COMPASS_NW
            case 337.5...360:
                windImage = self.COMPASS_N
            default:
                windImage = self.WIND_SYMBOL
            }
            
            DispatchQueue.main.async {
                self.icon.image = image
                self.windChimeIcon.image = windImage
                self.minTempLabel.stringValue = String(format: "%.01f°", min)
                self.curTempLabel.stringValue = String(format: "%.01f°", temp)
                self.maxTempLabel.stringValue = String(format: "%.01f°", max)
                self.summaryLabel.stringValue = "Currently: " + cSummary + "\nToday: " + summary
                self.sunriseLabel.stringValue = self.formatter.string(from: sunriseDate)
                self.sunsetLabel.stringValue = self.formatter.string(from: sunsetDate)
                self.humidityLabel.stringValue = String(format: "%.f%%", humidity*100)
                self.windSpeedLabel.stringValue = String(format: "%.01f mph", windSpeed)
            }
        }
        dataTask?.resume()
    }
    
    
    override func didRefreshWidget() {
        super.didRefreshWidget()
    }
}
