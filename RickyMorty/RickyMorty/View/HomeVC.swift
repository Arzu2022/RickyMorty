
import UIKit
import SnapKit

public class HomeViewController: UIViewController {
    let vm = HomeViewModel()
    let refreshControl = UIRefreshControl()
    @objc func refresh(_ sender: AnyObject) {
            self.vm.data = []
            self.tbView.reloadData()
            self.refreshControl.endRefreshing()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2 ){
                self.refreshControl.endRefreshing()
                self.getDataFromViewModel()
        }
        
    }
    private lazy var tbView:UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        view.addSubview(refreshControl)
        view.register(CustomHomeTVCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "mainColor")
        getDataFromViewModel()
        
    }
    func getDataFromViewModel(){
        self.vm.getData { m in
            self.vm.data = m.results
            self.vm.nextPageURL = m.info.next!
            self.setup()
            self.tbView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    func setup(){
        self.view.addSubview(tbView)
        let mainName = UILabel()
        self.view.addSubview(mainName)
        mainName.text = "RickyMorty"
        mainName.textColor = .white
        mainName.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        mainName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        tbView.snp.makeConstraints { make in
            make.top.equalTo(mainName.snp.bottom).offset(12)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }

}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomHomeTVCell
        cell.urlToImage.imageFromServerURL(self.vm.data[indexPath.row].image, placeHolder: nil)
        cell.name.text = self.vm.data[indexPath.row].name
        cell.species.text = self.vm.data[indexPath.row].species
        cell.gender.text = self.vm.data[indexPath.row].gender
        cell.status.text = self.vm.data[indexPath.row].status
        return cell
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.getInfoAfterClick(name: self.vm.data[indexPath.row].name, gender: self.vm.data[indexPath.row].gender, origin: self.vm.data[indexPath.row].location, status: self.vm.data[indexPath.row].status, type: self.vm.data[indexPath.row].type, speices: self.vm.data[indexPath.row].species, imageUrl: self.vm.data[indexPath.row].image,vc: self)
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((self.tbView.contentOffset.y + self.tbView.frame.size.height) >= self.tbView.contentSize.height){
            let spinner = UIActivityIndicatorView(style: .large)
                    spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width:self.tbView.bounds.width, height: CGFloat(44))
                    self.tbView.tableFooterView = spinner
                    self.tbView.tableFooterView?.isHidden = false
            DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(3)) {
                self.vm.getNextPage(url: self.vm.nextPageURL) { m in
                    self.self.vm.data += m.results
                    spinner.stopAnimating()
                    self.tbView.tableFooterView?.isHidden = true
                    self.tbView.reloadData()
                }
            }
                }
        
    }
}
