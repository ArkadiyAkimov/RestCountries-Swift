
import UIKit

class CountryViewController : UIViewController {

    var country: Country!
    var borderNations = [Country]()
    
private let tableView: UITableView = {
   let table = UITableView()
   return table
}()

override func viewDidLoad() {
    super.viewDidLoad()
    findBorderCountries()
    configureNavBar()
    configureTableView()
}
    
func findBorderCountries(){
    if country.borders != nil{
    for i in 0...country.borders!.count-1 {
        for j in 0...Service.countryRepo.myCountries.count-1 {
            if country.borders![i] == Service.countryRepo.myCountries[j].alpha3Code {
                borderNations.append(Service.countryRepo.myCountries[j])
       }
      }
     }
    } else {
        let label = UILabel(frame: CGRect(x: 30 , y: view.bounds.height/2 - 150 , width: view.bounds.width - 60, height: 100))
        label.text = "\(country.name ?? "This country") has no nehibours"
        label.textAlignment = .center
        label.numberOfLines = -1
        tableView.addSubview(label)
  }
}
    

func configureNavBar(){
    let navBar = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width , height: 60))
    navBar.backgroundColor = .yellow
    navBar.text = country.name! + " border nations:"
    navBar.adjustsFontSizeToFitWidth = true
    navBar.textAlignment = .center
    view.addSubview(navBar)
}

func configureTableView (){
    tableView.delegate = self
    tableView.dataSource = self
    tableView.frame = CGRect(x: 0, y: 60, width: view.bounds.width, height: view.bounds.height - 120)
    view.addSubview(tableView)
  }
}

extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return borderNations.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = CountryTableViewCell()
    cell.selectionStyle = .none
    cell.nativeName = borderNations[indexPath.row].nativeName ?? "none"
    cell.englishName = borderNations[indexPath.row].name ?? "none"
    cell.backgroundColor = UIColor(hue: CGFloat.random(in: 0...1), saturation: 0.5, brightness: 1, alpha: 1)
    return cell
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
}
