//
//  ViewController.swift
//  exam001Countries
//
//  Created by Arkadiy Akimov on 16/08/2022.
//

import UIKit

class InitialViewController: UIViewController {
    
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    private let tableView: UITableView = {
       let table = UITableView()
       return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Service.countryRepo.subscribe(self)
        configureDisplayArrangementMenu()
        configureTableView()
        configureActivityIndicator()
    }
    
    func configureDisplayArrangementMenu(){
        let displayArrangementMenu = UIStackView(frame: CGRect(x: 0, y: 40, width: view.bounds.width , height: 60))
        displayArrangementMenu.distribution = .fillEqually
        view.addSubview(displayArrangementMenu)
        
        let leftButton = UIButton()
        leftButton.setTitle("Arrage by Name", for: .normal)
        leftButton.titleLabel?.adjustsFontSizeToFitWidth = true
        leftButton.backgroundColor = .blue
        leftButton.layer.cornerRadius = 5
        leftButton.addTarget(self, action: #selector(switchToArrangementByName), for: .touchUpInside)
        leftButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        leftButton.tintColor = .white
        
        let rightButton = UIButton()
        rightButton.setTitle("Arrange by Area", for: .normal)
        rightButton.titleLabel?.adjustsFontSizeToFitWidth = true
        rightButton.backgroundColor = .gray
        rightButton.layer.cornerRadius = 5
        rightButton.addTarget(self, action: #selector(switchToArrangementByArea), for: .touchUpInside)
        rightButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        rightButton.tintColor = .white
        
        displayArrangementMenu.addArrangedSubview(leftButton)
        displayArrangementMenu.addArrangedSubview(rightButton)
    }
    
    func configureTableView (){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: view.bounds.height - 100)
        view.addSubview(tableView)
    }
    
    func configureActivityIndicator(){
        activityIndicator.frame = CGRect(x: 0 , y: view.bounds.height/2 - 200, width: view.bounds.width, height: 200)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        tableView.addSubview(activityIndicator)
    }
    
    @objc func switchToArrangementByArea(_ sender: UIButton) {
        Service.countryRepo.myCountries = Service.countryRepo.countriesByArea
        if Service.countryRepo.countriesByAreaDecending {
        Service.countryRepo.myCountries.sort(by: { $0.area ?? 0 > $1.area ?? 0 })
            sender.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        } else {
        Service.countryRepo.myCountries.sort(by: { $0.area ?? 0 < $1.area ?? 0 })
            sender.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
        Service.countryRepo.countriesByAreaDecending = !Service.countryRepo.countriesByAreaDecending
        tableView.reloadData()
    }
    
    @objc func switchToArrangementByName(_ sender: UIButton) {
        Service.countryRepo.myCountries = Service.countryRepo.countriesByName
        if Service.countryRepo.countriesByNameDecending {
        Service.countryRepo.myCountries.sort(by: { $0.name ?? "" > $1.name ?? "" })
            sender.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        } else {
        Service.countryRepo.myCountries.sort(by: { $0.name ?? "" < $1.name ?? "" })
            sender.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
        Service.countryRepo.countriesByNameDecending = !Service.countryRepo.countriesByNameDecending
        tableView.reloadData()
    }
}

extension InitialViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Service.countryRepo.myCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CountryTableViewCell()
        cell.nativeName = Service.countryRepo.myCountries[indexPath.row].nativeName ?? "none"
        cell.englishName = Service.countryRepo.myCountries[indexPath.row].name ?? "none"
        cell.backgroundColor = UIColor(hue: CGFloat.random(in: 0...1), saturation: 0.5, brightness: 1, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryView = CountryViewController()
        countryView.country = Service.countryRepo.myCountries[indexPath.row]
        present(countryView, animated: true)
    }
}

extension InitialViewController : countryDataDelegate {
    func onCountryDataUpdate() {
        activityIndicator.stopAnimating()
        tableView.reloadData()
    }
    
    func onCountryDataUpdateFailed() {
        activityIndicator.startAnimating()
    }
}
