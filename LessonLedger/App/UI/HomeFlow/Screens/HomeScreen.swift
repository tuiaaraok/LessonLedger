import SwiftUI
import AVFoundation

@available(iOS 16.0, *)
struct HomeScreen: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @State private var lessons: [Lesson] = []
    
    @State private var selectedDate: Date = Date()
    
    private let storage = Storage.shared
    
    var body: some View {
        VStack(spacing: 0) {
            
            CalendarMenu(selectedDate: $selectedDate) { selectedDate in
                lessons = storage.getLessonsByDate(selectedDate)
            }
            .padding(.top, 34)
            
            List {
                ForEach(lessons) { lesson in
                    LessonView(lesson: lesson)
                        .listRowBackground(Color.itemsBackground)
                        .listRowInsets(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                }
                .onDelete { indexSet in
                    lessons.remove(atOffsets: indexSet)
                    storage.saveLessons(lessons)
                }
                
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .padding(EdgeInsets(top: 39, leading: 0, bottom: 1, trailing: 0))
        }
        .onAppear { lessons = storage.getLessonsByDate(selectedDate) }
        .background(Color.background.ignoresSafeArea())
    }
}

@available(iOS 16.0, *)
private struct LessonView: View {
    @EnvironmentObject var themeManager: ThemeManager
    let lesson: Lesson
    
    var body: some View {
        
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                Text(formattedDate(lesson.startTime, format: "HH:mm"))
                    .customFont(.mainText)
                    .foregroundStyle(Color.mainText)
                Text(formattedDate(lesson.endTime, format: "HH:mm"))
                    .customFont(.addText)
                    .foregroundStyle(Color.addText)
            }
            .frame(maxWidth: 45)
            .padding(.leading, 19)
            
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(lesson.name)
                        .foregroundStyle(Color.mainAdd)
                    Text(lesson.homeworkItems.first?.name ?? "")
                        .foregroundStyle(Color.mainText)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                .customFont(.mainText)
                
                Text(lesson.audience)
                    .foregroundStyle(Color.addText)
                    .customFont(.addText)
            }
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 0, leading: 42, bottom: 0, trailing: 19))
        }.frame(maxWidth: .infinity)
        
    }
}

@available(iOS 16.0, *)
private struct CalendarMenu: View {
    @Binding var selectedDate: Date
    
    let onDateSelected: (Date) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 5) {
                Text(formattedDate(selectedDate, format: "dd"))
                    .customFont(.calendarDateText)
                    .foregroundStyle(Color.mainText)
                VStack(alignment: .leading) {
                    Text(formattedDate(selectedDate, format: "EEEE"))
                    Text(formattedDate(selectedDate, format: "MMM, yyyy"))
                }
                .customFont(.addText)
                .foregroundStyle(Color.addText)
            }
            .padding(.bottom, 26)
            
            HStack(spacing: 13) {
                ForEach(next7Days(), id: \.self) { date in
                    VStack(spacing: 0) {
                        Text(formattedDate(date, format: "dd"))
                            .customFont(.calendarDateText)
                            .foregroundStyle(color(for: date))
                        
                        Text(formattedDate(date, format: "EEE"))
                            .customFont(.addText)
                            .foregroundStyle(color(for: date))
                    }
                    .background(backgroundColor(for: date))
                    .cornerRadius(8)
                        .onTapGesture {
                            selectedDate = date
                            onDateSelected(date)
                        }
                }
            }
        }
    }
    
    private func next7Days() -> [Date] {
        let calendar = Calendar.current
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: Date()) }
    }
    
    private func color(for date: Date) -> Color {
        if isWeekend(date) {
            return Color.red
        } else {
            return Color.mainText
        }
    }
    
    private func backgroundColor(for date: Date) -> Color {
        if Calendar.current.isDate(date, inSameDayAs: selectedDate) {
            return Color.mainAdd
        } else {
            return Color.clear
        }
    }
    
    private func isWeekend(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        return weekday == 7 || weekday == 1
    }
}


