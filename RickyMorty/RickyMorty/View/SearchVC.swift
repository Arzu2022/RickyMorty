

import UIKit
import SnapKit
import SwiftUI
class SearchVC: UIViewController {
    let vm = HomeViewModel()
    private lazy var tableView:UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(CustomHomeTVCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    private lazy var btnFilter:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle",withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
        btn.addTarget(self, action: #selector(clickFilter), for: .touchUpInside)
        return btn
    }()
    @objc func clickFilter(){
        filterBaseURL()
    }
    private lazy var searchController: UISearchController = {
           let sb = UISearchController()
           sb.searchBar.placeholder = "Search"
           sb.searchBar.searchBarStyle = .minimal
           sb.delegate = self
           sb.searchBar.delegate = self
           return sb
       }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func filterBaseURL(){
        let alert = UIAlertController(title:"Choose filter type", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "name", style: .default, handler: { _ in
            self.vm.generalURL = "https://rickandmortyapi.com/api/character/?name="
        }))
        alert.addAction(UIAlertAction(title: "species", style: .default, handler: { _ in
            self.vm.generalURL = "https://rickandmortyapi.com/api/character/?species="
        }))
        alert.addAction(UIAlertAction(title: "gender", style: .default, handler: { _ in
            self.vm.generalURL = "https://rickandmortyapi.com/api/character/?gender="
        }))
        alert.addAction(UIAlertAction(title: "status", style: .default, handler: { _ in
            self.vm.generalURL = "https://rickandmortyapi.com/api/character/?status="
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func setup(){
        self.view.addSubview(tableView)
        self.view.addSubview(btnFilter)
        self.view.backgroundColor = UIColor(named: "mainColor")
        tableView.tableHeaderView = searchController.searchBar
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(12)
            make.left.right.bottom.equalToSuperview()
        }
        btnFilter.snp.makeConstraints { make in
            make.top.equalTo(self.tableView.snp.top).offset(50)
            make.right.equalToSuperview().offset(-12)
        }
    }
}
extension SearchVC:UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchBarDelegate{
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        dismiss(animated: true)
        searchBar.text = ""
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        print(searchBar.text!)
        if !searchBar.text!.isEmpty{
            let text = searchBar.text
            self.vm.data = []
            self.tableView.reloadData()
            self.vm.getNextPage(url: "\(self.vm.generalURL)\(text!)") { m in
                self.vm.data = m.results
                self.tableView.reloadData()
            }
        }
        return true
    }
    func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
           alert.view.backgroundColor = .black
            alert.view.alpha = 0.5
            alert.view.layer.cornerRadius = 15
            self.present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
                alert.dismiss(animated: true)
            }
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomHomeTVCell
        cell.urlToImage.imageFromServerURL(self.vm.data[indexPath.row].image, placeHolder: nil)
        cell.name.text = self.vm.data[indexPath.row].name
        cell.species.text = self.vm.data[indexPath.row].species
        cell.gender.text = self.vm.data[indexPath.row].gender
        cell.status.text = self.vm.data[indexPath.row].status
    return cell
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.getInfoAfterClick(name: self.vm.data[indexPath.row].name, gender: self.vm.data[indexPath.row].gender, origin: self.vm.data[indexPath.row].location, status: self.vm.data[indexPath.row].status, type: self.vm.data[indexPath.row].type, speices: self.vm.data[indexPath.row].species, imageUrl: self.vm.data[indexPath.row].image,vc: self)
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((self.tableView.contentOffset.y + self.tableView.frame.size.height) >= self.tableView.contentSize.height){
            let spinner = UIActivityIndicatorView(style: .large)
                    spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width:         self.tableView.bounds.width, height: CGFloat(44))
                    self.tableView.tableFooterView = spinner
                    self.tableView.tableFooterView?.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                self.vm.getNextPage(url: self.vm.nextPageURL) { m in
                    self.self.vm.data += m.results
                    self.tableView.tableFooterView?.isHidden = true
                    self.tableView.reloadData()
                }
                spinner.stopAnimating()
            }
                }
        
    }
}
