//
//  MapViewController+Extension.swift
//  HomeWork24_RomanGushchik
//
//  Created by admin on 1.07.22.
//

import Foundation
import UIKit
import GoogleMaps
import RealmSwift

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        apiProvider.getWeatherByCityCoordinate(latitude: coordinate.latitude, longitude: coordinate.longitude) { [weak self] result in
            guard let self = self else {return}
            switch result {
                case .success(let value):
                guard let weather = value.current.weather.first?.weatherDescription else {return}
                DispatchQueue.main.async {
                self.weatherView.backgroundColor = .blue
                self.conteinerForMapView.addSubview(self.weatherView)
                self.temperature.text = "\(value.current.temperature)"
                self.feelsLike.text = "FeelLike: \(value.current.feelsLike)"
                self.weatherDiscription.text = weather
                self.realmDateBase.getDataBase(value: value)
                guard let imageWeatherIcon = value.current.weather.first?.icon else {return}
                self.weatherImageIcon.getWeatherImage(id: imageWeatherIcon)
                }
            case .failure(let error):
                print(error)
                }
            }
        }
    }

