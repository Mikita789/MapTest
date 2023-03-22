//
//  SaveDataTableViewCellPrototype.swift
//  MapTest
//
//  Created by Никита Попов on 22.03.23.
//

import UIKit

class SaveDataTableViewCellPrototype: UITableViewCell {
    var descriptionLabel:UILabel!
    var longitudeLabel:UILabel!
    var latitudeLabel:UILabel!
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        descriptionLabelSettings()
        longitudeLabelSettinge()
        latitudeLabelSettings()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - descriptionLabel settings
    private func descriptionLabelSettings(){
        descriptionLabel = UILabel()
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descriptionLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6)
        ])
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = .systemFont(ofSize: 20, weight: .medium)
        descriptionLabel.numberOfLines = 0
    }

    //MARK: - longitudeLabel settings
    private func longitudeLabelSettinge(){
        longitudeLabel = UILabel()
        contentView.addSubview(longitudeLabel)
        longitudeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            longitudeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 2),
            longitudeLabel.leftAnchor.constraint(equalTo: descriptionLabel.leftAnchor),
            longitudeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.49),
            longitudeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2)
        ])
        longitudeLabel.textAlignment = .center
        longitudeLabel.font = .systemFont(ofSize: 15)
    }

    //MARK: - latitudeLabel settings
    private func latitudeLabelSettings(){
        latitudeLabel = UILabel()
        contentView.addSubview(latitudeLabel)
        latitudeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            latitudeLabel.topAnchor.constraint(equalTo: longitudeLabel.topAnchor),
            latitudeLabel.bottomAnchor.constraint(equalTo: longitudeLabel.bottomAnchor),
            latitudeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.49),
            latitudeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5)
        ])
        latitudeLabel.textAlignment = .center
        latitudeLabel.font = .systemFont(ofSize: 15)
    }

    //MARK: - func writing Values to Cells
    func writingValuesToCells(item:LocationsUser){
        self.descriptionLabel.text = item.descript
        self.latitudeLabel.text = "Latitude: \(item.latitude!)"
        self.longitudeLabel.text = "Longiude: \(item.longitude!)"
    }
    
    
   
}
