
import UIKit


enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "Data received successfully"
        case .failed:
            return "Data acquisition error"
        }
    }
}
    

final class ViewController: UIViewController {
    @IBOutlet var showButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tableVC = segue.destination as? TableViewController else { return }
        tableVC.fetchEmployees()
        
    }
    private func setupButton() {
        showButton.layer.borderColor = UIColor.black.cgColor
        showButton.layer.borderWidth = 2
        showButton.layer.cornerRadius = showButton.frame.width / 10
    }
    
}

