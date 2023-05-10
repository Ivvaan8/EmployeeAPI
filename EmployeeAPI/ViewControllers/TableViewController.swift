//
//  TableViewController.swift
//  EmployeeAPI
//
//  Created by Иван Майоров on 10.05.2023.
//

import UIKit



final class TableViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    private var employee: Employee?
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = editButtonItem
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let detailVC = segue.destination as? DetailViewController else { return }
        guard let employee else { return }
        let person = employee.data[indexPath.row]
        detailVC.employee = person
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employee?.data.count ?? 10

    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let detailInfoPerson = employee?.data[indexPath.row]
        content.text = detailInfoPerson?.employeeName
        content.secondaryText = "Salary: \(detailInfoPerson?.employeeSalary ?? 0)"
        content.image = UIImage(systemName: "person")
        cell.contentConfiguration = content
        return cell
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let removePerson = employee?.data.remove(at: sourceIndexPath.row)
        employee?.data.insert(removePerson!, at: destinationIndexPath.row)
    }
    
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.performSegue(withIdentifier: "error", sender: nil)
        }
        alert.addAction(okAction)
        DispatchQueue.main.async {  [unowned self] in
            present(alert, animated: true)
        }
    }
    
    // MARK: - UITableView Delegate
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }

}




// MARK: - Fetch employees
extension TableViewController {
    func fetchEmployees() {
        networkManager.fetchEmployee(from: Link.employeeURl.url) { [weak self] result in
            switch result {
                
            case .success(let employee):
                self?.employee = employee
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
                self?.showAlert(withStatus: .failed)
                
            }
        }
    }

}
