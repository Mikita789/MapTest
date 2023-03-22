//
//  ViewController.swift
//  MapTest
//
//  Created by Никита Попов on 21.03.23.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var map:MKMapView!
    var locManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Location"
        
        
        mapSettings()
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        addButtonNavBar()
        UpLoadAllPoints()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UpLoadAllPoints()
    }
    
    //MARK: - map Settings
    private func mapSettings(){
        map = MKMapView()
        view.addSubview(map)
        map.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            map.leftAnchor.constraint(equalTo: view.leftAnchor),
            map.rightAnchor.constraint(equalTo: view.rightAnchor),
            map.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //MARK: - added button in navigationBar
    private func addButtonNavBar(){
        let buttonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonLocationAction))
        buttonItem.tintColor = .black
        navigationItem.rightBarButtonItem = buttonItem
    }
    
    //MARK: - navBar button action
    @objc private func buttonLocationAction(){
        guard let currentCoord = locManager.location?.coordinate else {
            crateAlertController(titleText: "Ooops", messageText: "Locate not ident", actionText: "OK")
            return }
        createAlertSaveCoordinate(titleText: "Save coordinates", messageText: "Enter a description of the place", actionText: "Save", long: String(currentCoord.longitude), latit: String(currentCoord.latitude))
    }
    
    //MARK: - func create Alert Controller
    private func crateAlertController(titleText: String, messageText:String, actionText:String){
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        let action = UIAlertAction(title: actionText, style: .cancel)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    //MARK: - func create alertConrtoller to save location
    private func createAlertSaveCoordinate(titleText: String, messageText:String, actionText:String, long:String, latit:String){
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        
        alertController.addTextField()
        alertController.textFields?.first?.placeholder = "description"
        alertController.textFields?.first?.textAlignment = .center
        
        let action = UIAlertAction(title: actionText, style: .default,handler: {_ in
            guard let textDescription = alertController.textFields?.first?.text else { return }
            let location = UsersLocation(long: long, latit: latit, description: textDescription)
            DataOperations.shared.saveCoordinate(item: location)
            self.saveMapPoint(model: location)
        })
        let action2 = UIAlertAction(title: "Don't Save", style: .destructive)
        
        alertController.addAction(action)
        alertController.addAction(action2)
        
        present(alertController, animated: true)
    }
    
    //MARK: - Adding a point on the map
    private func saveMapPoint(model:UsersLocation){
        let anotation = MKPointAnnotation()
        anotation.coordinate.longitude = Double(model.longitude)!
        anotation.coordinate.latitude = Double(model.latitude)!
        anotation.title = model.description
        
        map.addAnnotation(anotation)
    }
    
    //MARK: - Upload a point on the map
    private func UpLoadAllPoints(){
        let data = DataOperations.shared.upLoadData()
        if map.annotations != nil{
            for annotation in map.annotations{
                map.removeAnnotation(annotation)
            }
        }
        
        for object in data{
            let userLoc = UsersLocation(long: object.longitude!,
                                        latit: object.latitude!,
                                        description: object.descript!)
            self.saveMapPoint(model: userLoc)
        }
    }

}

//MARK: - Location Manager Delegate
extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        map.showsUserLocation = true
    }
    
}

