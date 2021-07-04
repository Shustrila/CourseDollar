import Foundation


class NetworkManager {
    // MARK: - Singleton

    static let shared: NetworkManager = NetworkManager()
    // MARK: - Properties

    private let domain: String = "https://cbr.ru/"
    private let networkManagerQueue = DispatchQueue(label: "network-manager")
    
    enum UrlTypes: String {
        case dynamic = "scripts/XML_dynamic.asp/"
    }
    
    func fetchCourseDollar(complition: @escaping ((Result<Data, NetworkError>) -> Void) ) {
        networkManagerQueue.async {
            var components = URLComponents(string: self.domain + UrlTypes.dynamic.rawValue)

            components?.queryItems = [
                URLQueryItem(name: "date_req1", value: DateUtils.getDateLastMonth()),
                URLQueryItem(name: "date_req2", value: DateUtils.getDateForrequest()),
                URLQueryItem(name: "VAL_NM_RQ", value: "R01235")
            ]
        
            let request = URLRequest(url: (components?.url!)!)
        
            let task = URLSession.shared.dataTask(with: request) {
                data, response, error in
        
                if error == nil {
                    complition(.success(data!))
                } else {
                    complition(.failure(.error))
                }
            }
            
            task.resume()
        }
    }
}
