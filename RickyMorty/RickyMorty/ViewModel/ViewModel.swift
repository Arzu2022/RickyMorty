
import Foundation
import UIKit

class HomeViewModel {
    // "https://rickandmortyapi.com/api/character/?name="
    var generalURL:String = "https://rickandmortyapi.com/api/character/?name="
    var nextPageURL:String = ""
    var data:[MainResult] = []
    func getNextPage(url:String,complete: @escaping(MainData)->()){
        HomeNetwork.shared.getNextPageData(url: url) { m in
            complete(m)
        }
    }
    func getData(complete:@escaping (MainData)->()){
        HomeNetwork.shared.getAllData() { data in
            complete(data)
        }
    }
    
}
