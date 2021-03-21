//
//  ViewController.swift
//  Module14v2
//
//  Created by Сергей Гринько on 19.03.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var minTemperatureLabel: UILabel!
    
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    var currentWeather: Weather!
    var weathersArr:[Weather]!
    var cashedWeathers:[WeatherObj] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    

       // PersistanceRealm.shared.clearWeathers()
        cashedWeathers = PersistanceRealm.shared.getAllWeathers()
        loaded()
        let loader = WeatherLoader()
        loader.delegate = self
        loader.loadWeather()
       
    }


}



extension ViewController:UITableViewDataSource{
   
    // Return the number of rows for the table.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

//     Provide a cell object for each row.
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//       // Fetch a cell of the appropriate type.
//       let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastTableViewCell
//
//
//
//       return cell
//    }
    

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           // Fetch a cell of the appropriate type.
           let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastTableViewCell
            print("cell")
            if cashedWeathers.count > 0 {
                cell.dateLabel.text = self.cashedWeathers[indexPath.row+1].date
                cell.descrLabel.text = self.cashedWeathers[indexPath.row+1].weatherDescription
                cell.maxTempLabel.text = "+" + String(self.cashedWeathers[indexPath.row+1].maxTemp) + "º"
                cell.minTempLabel.text = "+" + String(self.cashedWeathers[indexPath.row+1].minTemp) + "º"
            }
            
//            tableView.reloadData()
            return cell
            
        }
    
        func reloadCells(){
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               // Fetch a cell of the appropriate type.
               let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastTableViewCell
                print("cell")
                if cashedWeathers.count > 0 {
                    cell.dateLabel.text = self.cashedWeathers[indexPath.row+1].date
                    cell.descrLabel.text = self.cashedWeathers[indexPath.row+1].weatherDescription
                    cell.maxTempLabel.text = "+" + String(self.cashedWeathers[indexPath.row+1].maxTemp) + "º"
                    cell.minTempLabel.text = "+" + String(self.cashedWeathers[indexPath.row+1].minTemp) + "º"
                }

    //            tableView.reloadData()
                return cell

            }
        }
    
}

extension ViewController: WeatherLoaderDelegate{
    func loaded(){
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return 6
//        }

        cashedWeathers = PersistanceRealm.shared.getAllWeathers()
       
        print(cashedWeathers.count)
        if cashedWeathers.count > 0 {
            self.loadView()
            tempLabel.text = "+" + String(cashedWeathers[0].temp) + "º"
            pressureLabel.text = String(cashedWeathers[0].pressure)
            humidityLabel.text = String(cashedWeathers[0].humidity)
            minTemperatureLabel.text = "+" + String(cashedWeathers[0].minTemp) + "º"
            maxTemperatureLabel.text = "+" + String(cashedWeathers[0].maxTemp) + "º"
            descriptionLabel.text = cashedWeathers[0].weatherDescription
            
            
        
            
        }
    }
}

