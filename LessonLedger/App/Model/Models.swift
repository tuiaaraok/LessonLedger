import Foundation

struct Lesson: Identifiable, Codable {
    let id: UUID
    
    let name: String
    
    var date: Date
    let startTime: Date
    let endTime: Date
    let audience: String
    var homeworkItems: [HomeworkItem]
    
    
    init(id: UUID = UUID(), name: String, date: Date, startTime: Date, endTime: Date, audience: String, homeworkItems: [HomeworkItem]) {
        self.id = id
        
        self.name = name
        
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.audience = audience
        self.homeworkItems = homeworkItems
    }
}

struct HomeworkItem: Identifiable, Codable, Hashable {
    let id: UUID
    
    var name: String
    var isCompleted: Bool
    
    init(id: UUID = UUID(), name: String, isCompleted: Bool) {
        self.id = id
        
        self.name = name
        self.isCompleted = isCompleted
    }
}

