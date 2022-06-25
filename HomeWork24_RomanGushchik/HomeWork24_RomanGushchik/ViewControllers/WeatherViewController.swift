    //
    //  ViewController.swift
    //  HomeWork24_RomanGushchik
    //
    //  Created by admin on 20.06.22.
    //

    import UIKit

    class WeatherViewController: UIViewController {
        
        @IBOutlet weak var enterCityName: UILabel!
        @IBOutlet weak var cityNameTextField: UITextField!
        @IBOutlet weak var temperature: UILabel!
        @IBOutlet weak var feelsLike: UILabel!
        @IBOutlet weak var pressure: UILabel!
        @IBOutlet weak var humidity: UILabel!
        @IBOutlet weak var visibility: UILabel!
        @IBOutlet weak var clouds: UILabel!
        @IBOutlet weak var windSpeed: UILabel!
        @IBOutlet weak var sunrise: UILabel!
        @IBOutlet weak var sunset: UILabel!
        @IBOutlet weak var windGust: UILabel!
        private var apiProvider: RestAPIProviderProtocol!

        override func viewDidLoad() {
        super.viewDidLoad()
        apiProvider = AlamofireAPIProvider()
        enterCityName.text = "Enter city name"

        }
        
    @IBAction func getWeatherButton(_ sender: Any) {
        getCoordinateByCityName()
    }
        
    fileprivate func getCoordinateByCityName() {
        guard let cityName = cityNameTextField.text else {return}
            apiProvider.getCoordinateByCityName(cityName: cityName) { result in
            switch result {
                case .success(let value):
                if let city = value.first {
                    self.getWeatherByCoordinate(city: city)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }

    private func getWeatherByCoordinate(city: CityCoordinate) {
        apiProvider.getWeatherByCityCoordinate(latitude: city.latitude, longitude: city.longitude) { [weak self] result in
            guard let self = self else {return}
            switch result {
                case .success(let value):
                DispatchQueue.main.async {
                    self.temperature.text = "Temperature: \(value.current.temperature)"
                    self.feelsLike.text = "FeelLike: \(value.current.feelsLike)"
                    self.pressure.text  = "Pressure: \(value.current.pressure)"
                    self.humidity.text = "Humidity: \(value.current.humidity)"
                    self.visibility.text = "Visibility: \(value.current.visibility)"
                    self.windSpeed.text = "WindSpeed: \(value.current.windSpeed)"
                    self.windGust.text = "WindGust: \(value.current.windGust)"
                    self.sunrise.text = "Sunrise: \(value.current.sunrise)"
                    self.sunset.text = "Sunset: \(value.current.sunset)"
                    self.clouds.text = "Clouds: \(value.current.clouds)"
                         }
                case .failure(let error):
                         print(error)
            }
        }
    }
}



