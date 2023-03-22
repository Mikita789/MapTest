//
//  SaveDataViewController.swift
//  MapTest
//
//  Created by Никита Попов on 22.03.23.
//

import UIKit

class SaveDataViewController: UIViewController {
    var tableView:UITableView!
    let identCell = "cellPrototype"
    var data = [LocationsUser]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        basicTableVewSettings()
        data = DataOperations.shared.upLoadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        data = DataOperations.shared.upLoadData()
        tableView.reloadData()
    }
    
    //MARK: - tableView settings
    private func basicTableVewSettings(){
        tableView = UITableView()
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(SaveDataTableViewCellPrototype.self, forCellReuseIdentifier: identCell)
        tableView.delegate = self
        tableView.dataSource = self
    }

}

//MARK: - tableView delegate and dataSource
extension SaveDataViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identCell, for: indexPath) as? SaveDataTableViewCellPrototype else { return UITableViewCell() }
        let currentItem = indexPath.row
        
        cell.writingValuesToCells(item: data[currentItem])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //style editing cell
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    //func delete row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            DataOperations.shared.deleteSelectedItem(indexPath: indexPath)
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
}
