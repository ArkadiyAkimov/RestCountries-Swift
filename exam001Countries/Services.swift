//
//  Services.swift
//  exam001Countries
//
//  Created by Arkadiy Akimov on 16/08/2022.
//

import Foundation
import Alamofire

struct Service {
    static var countryRepo = CountryRepository()
}

class CountryRepository {
    var subscribers = [countryDataDelegate]()
    var dataSourceURL = "https://restcountries.com/v2/all"
    
     var myCountries = [Country]()
     var countriesByArea = [Country]()
     var countriesByAreaDecending = true
     var countriesByName = [Country]()
     var countriesByNameDecending = true
    
    func fetchCountries() {
        AF.request(dataSourceURL)
            .validate()
            .responseDecodable(of: [Country].self) { response in
                switch response.result {
                case .success(let value):
                    print("success fetching country data")
                    Service.countryRepo.countriesByName = value
                    Service.countryRepo.myCountries = Service.countryRepo.countriesByName
                    self.arrangeCountriesByArea()
                    self.updateCountryData()
                    break
                case .failure:
                    print("failure fetching country data, attempting again in 5 seconds...")
                    self.updateCountryDataFailed()
                    self.repeatFetchAttempt()
                    break
                }
           }
    }
    
    func repeatFetchAttempt (){
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.fetchCountries()
        }
    }
    
        func subscribe(_ sender: countryDataDelegate){
            subscribers.append(sender)
        }
        
        func updateCountryData(){
            for subscriber in subscribers{
                subscriber.onCountryDataUpdate()
            }
        }
    
    func updateCountryDataFailed(){
        for subscriber in subscribers{
            subscriber.onCountryDataUpdateFailed()
        }
    }
    
     func arrangeCountriesByArea(){
        Service.countryRepo.countriesByArea = Service.countryRepo.myCountries.sorted(by: {$0.area ?? 0 < $1.area ?? 0 })
    }
}

protocol countryDataDelegate {
    func onCountryDataUpdate()
    func onCountryDataUpdateFailed()
}
