import Foundation


class DateUtils {
    static func getDateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        return formatter.string(from: date)
    }
    
    static func getDateLastMonth() -> String {
        let nowDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: nowDate)
        
        return formatter.string(from: lastMonth ?? nowDate)
    }
    
    static func getDateForrequest() -> String {
        let nowDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.string(from: nowDate)
    }
    
    static func getDateLastView() -> String {
        let nowDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        return formatter.string(from: nowDate)
    }
}
