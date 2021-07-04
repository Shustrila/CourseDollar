import Foundation
import UIKit
import SwiftyXMLParser


protocol CourseDollarViewModelProtocol {
    var isFetching: Bool { get }
    var isError: Bool { get }
    
    var courseDollar: [CourseDollar] { get }

    func getCourseDollar() -> Void
    func getCourseDollarCount() -> Int
    func getCourseDollarCell(_: UITableView, indexPath: IndexPath) -> UITableViewCell
}


class CourseDollarViewModel: NSObject {
    // MARK: - Properties
    
    @objc dynamic var isFetching: Bool = false
    @objc dynamic var isError: Bool = false
    
    @objc dynamic var courseDollar: [CourseDollar] = []
    // MARK: - Private Methods
    
    private func parseXML(data: Data) -> [CourseDollarDomain] {
        let xml = XML.parse(data)
        var array: [CourseDollarDomain] = []
                
        for record in xml.ValCurs.Record.reversed() {
            let course = CourseDollarDomain()
            course.id = record.attributes["Id"] ?? ""
            course.course = record.Value.text ?? ""
            course.date = record.attributes["Date"] ?? ""

            array.append(course)
        }
        
        return array
    }
    
    private func prepereCourseDollar(data: Data) {
        let courses = parseXML(data: data)
        let lastDateChange = UserDefaults.standard.string(forKey: UserDefaults.getKey(.lastDateChange))
        let dateLastView = DateUtils.getDateLastView()
        let lastDateChangeKey = UserDefaults.getKey(.lastDateChange)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        DataBaseManager.shared.deleteAllCourseDollar()
        DataBaseManager.shared.addCourseDollar(courses)
        courseDollar = DataBaseManager.shared.getAllCourseDollar()
        
        guard let nowDate: Date = formatter.date(from: dateLastView) else { return }
        guard let dateChange: Date = formatter.date(from: lastDateChange ?? "") else { return }
        
        createNotification(courses: courses)
        
        if nowDate.timeIntervalSince1970 > dateChange.timeIntervalSince1970 {
            createNotification(courses: courses)
        } else {
            UserDefaults.standard.set(dateLastView, forKey: lastDateChangeKey)
        }
    }
    
    private func createNotification(courses: [CourseDollarDomain]) {
        DataBaseManager.shared.createNotification(
            newCourse: courses[0].course,
            oldCourse: courseDollar[0].course!
        )
        
        NotificationCenter.default.post(name: .didCreateNotification, object: nil)
    }
}


extension CourseDollarViewModel: CourseDollarViewModelProtocol {
    func getCourseDollar() {
        isFetching = true
        isError = false
        
        NetworkManager.shared.fetchCourseDollar(complition: { [weak self] result in
            switch result {
            case .success(let data):
                self?.prepereCourseDollar(data: data)
            case .failure(_):
                self?.isError = true
            }
          
            self?.isFetching = false
        })
    }
    
    func getCourseDollarCount() -> Int {
        return courseDollar.count
    }
    
    func getCourseDollarCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoureseDollarCell", for: indexPath) as! CoureseDollarCell
        cell.item = courseDollar[indexPath.row]
        return cell
    }
}
