//
//  DetailViewController.swift
//  EmployeeAPI
//
//  Created by Иван Майоров on 10.05.2023.
//

import UIKit

final class DetailViewController: UIViewController {

    @IBOutlet var salaryLabel: UILabel!
    @IBOutlet var personImageVIew: UIImageView!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    var employee: EmployeeDescription?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()

        
    }
    private func setupElements() {
        guard let employee else {
            print("data acquisition error")
            return
        }
        nameLabel.text = "Name: \(employee.employeeName)"
        idLabel.text = "ID: \(employee.id)"
        ageLabel.text = "Age: \(employee.employeeAge)"
        salaryLabel.text = "Salary: \(employee.employeeSalary)"
    }
    



}
