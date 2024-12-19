import SwiftUI

class Storage {
    
    static let shared = Storage()
    
    private let lessonsKey = "lessons"
    
    private init() {  }
    
    let appId = "6739535615"
    let privacyPolicyUrl = "https://docs.google.com/document/d/17s4q7QPyQU0q622UWkTu9iZ-Gie2toDMympqQQJWEIY/mobilebasic"
    let email = "seymandomal96@icloud.com"

    func getLessonsGroupedByDate() -> [Lesson] {
        let lessons = getLessons()
        return lessons.sorted {
            if $0.date != $1.date {
                return $0.date < $1.date
            } else {
                return $0.startTime < $1.startTime
            }
        }
    }
    
    func getLessonsByDate(_ date: Date) -> [Lesson] {
        var lessons = getLessons()
        let calendar = Calendar.current
        
        return lessons.filter { lesson in
            calendar.isDate(lesson.date, inSameDayAs: date)
        }
    }
    
    func saveLesson(_ lesson: Lesson) {
        var lessons = getLessons()
        lessons.append(lesson)
        saveLessons(lessons)
    }
    
    func saveLessons(_ lessons: [Lesson]) {
        if let data = try? JSONEncoder().encode(lessons) {
            UserDefaults.standard.set(data, forKey: lessonsKey)
        }
    }
    
    func getLessons() -> [Lesson] {
        guard let data = UserDefaults.standard.data(forKey: lessonsKey),
              let lessons = try? JSONDecoder().decode([Lesson].self, from: data) else {
            return []
        }
        return lessons
    }

}

