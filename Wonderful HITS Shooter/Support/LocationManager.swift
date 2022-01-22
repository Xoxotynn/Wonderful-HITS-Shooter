import CoreLocation

final class LocationManager: NSObject {
    // MARK: - Properties
    var country: String?
    var didUpdateCountry: (() -> Void)?
    private let locationManager = CLLocationManager()
    
    // MARK: - Public Methods
    func getLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "ru_RU")) { [weak self] placemarks, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                guard let country = placemarks?.first?.country else { return }
                
                self?.country = country
                self?.didUpdateCountry?()
            }
        }
    }
}
