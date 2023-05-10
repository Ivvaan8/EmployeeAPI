

import Foundation

enum Link {
     case employeeURl
     case networkErrorImage

     var url: URL {
         switch self {
         case .employeeURl:
             return URL(string: "https://dummy.restapiexample.com/api/v1/employees")!
         case .networkErrorImage:
             return URL(string: "https://easy-comp.ru/media/k2/items/cache/e9432fccf28a953514f077b86e5e657a_XL.jpg")!
         }
     }
 }

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}




final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    func fetchEmployee(from url: URL, completion: @escaping (Result<Employee,NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "NO error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let employee = try decoder.decode(Employee.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(employee))
                }
            } catch {
                completion(.failure(.decodingError))
                
            }
        }.resume()
    }
    
    func fechImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
