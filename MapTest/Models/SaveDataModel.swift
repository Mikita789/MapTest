//
//  SaveDataModel.swift
//  MapTest
//
//  Created by Никита Попов on 21.03.23.
//

import Foundation
import UIKit
import CoreData

struct DataOperations{
    static let shared = DataOperations()
    
    func saveCoordinate(item:UsersLocation){
        let application = UIApplication.shared.delegate as! AppDelegate
        let context = application.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "LocationsUser", in: context) else { return }
        let saveObject = LocationsUser(entity: entity, insertInto: context)
        saveObject.longitude = item.longitude
        saveObject.latitude = item.latitude
        saveObject.descript = item.description
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func upLoadData()->[LocationsUser]{
        var data = [LocationsUser]()
        let application = UIApplication.shared.delegate as! AppDelegate
        let context = application.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<LocationsUser> = LocationsUser.fetchRequest()
        
        do{
            data = try context.fetch(fetchRequest)
        }catch{
            print(error.localizedDescription)
        }
        return data
    }
    
    func deleteSelectedItem(indexPath:IndexPath){
        let application = UIApplication.shared.delegate as! AppDelegate
        let context = application.persistentContainer.viewContext
        let request:NSFetchRequest<LocationsUser> = LocationsUser.fetchRequest()
        guard let objects = try? context.fetch(request) else { return }
        context.delete(objects[indexPath.row])
        
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
    }
}


enum CoordName{
    case longitude
    case latitude
    
    var str:String{
        switch self{
        case .latitude: return "Latitude"
        case .longitude: return "Longitude"
        }
    }
    
}
