

import Foundation


 struct EmployeeDescription: Decodable {
     let id: Int
     let employeeName: String
     let employeeSalary: Int
     let employeeAge: Int
     let profileImage: String

 }

 struct Employee: Decodable {
     let status: String
     var data: [EmployeeDescription]
     let message: String
 }

