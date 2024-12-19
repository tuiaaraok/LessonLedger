import SwiftUI

@available(iOS 16.0, *)
struct HomeworkScreen: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @State private var lessons: [Lesson] = []
    
    private let storage = Storage.shared
    
    var body: some View {
        VStack(spacing: 0) {
            ScreenTitle(text: "Tasks and homework")
            
            List {
                ForEach($lessons) { $lesson in
                    HomeworkView(lesson: $lesson)
                        .listRowBackground(Color.background)
                        .listRowInsets(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                }
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .padding(EdgeInsets(top: 39, leading: 0, bottom: 1, trailing: 0))
            
            ActionButtons(cancelButtonAction: cancel, saveButtonAction: save)
                .padding(.bottom, 45)
            
        }
        .onAppear {
            lessons = storage.getLessonsGroupedByDate()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.ignoresSafeArea())
    }
    private func save() {
        storage.saveLessons(lessons)
    }
    
    private func cancel() {
        lessons = storage.getLessonsGroupedByDate()
    }
}

@available(iOS 16.0, *)
private struct HomeworkView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Binding var lesson: Lesson
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            Text("\(formattedDate(lesson.date, format: "EEEE, dd MMMM")), \(formattedDate(lesson.startTime, format: "HH:mm"))-\(formattedDate(lesson.endTime, format: "HH:mm"))".uppercased())
                .foregroundStyle(Color.addText)
                .customFont(.mainText)
            
            Text(lesson.name)
                .foregroundStyle(Color.mainAdd)
                .customFont(.mainText)
                .padding(.top, 8)
            Text(lesson.audience)
                .foregroundStyle(Color.addText)
                .customFont(.addText)
            Text("Homework")
                .foregroundStyle(Color.mainText)
                .customFont(.mainText)
                .padding(.top, 47)
            Button(action: {
                let newHomeworkItem = HomeworkItem(name: "", isCompleted: false)
                lesson.homeworkItems.append(newHomeworkItem)
            }) {
                Text("+Add homework")
                    .customFont(.mainText)
                    .foregroundStyle(Color.mainAdd)
            }
            .padding(.top, 8)
            
            List {
                ForEach($lesson.homeworkItems) { $homeworkItem in
                    HomeworkItemView(homeworkItem: $homeworkItem)
                        .listRowBackground(Color.background)
                        .listRowInsets(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                }
                .onDelete { indexSet in
                    lesson.homeworkItems.remove(atOffsets: indexSet)
                }
                
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .padding(EdgeInsets(top: 19, leading: 0, bottom: 1, trailing: 0))
            
            
        }
        .frame(maxWidth: .infinity, minHeight: 300)
        .padding(.leading, 27)
    }
}

@available(iOS 16.0, *)
private struct HomeworkItemView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Binding var homeworkItem: HomeworkItem
    
    var body: some View {
        HStack(spacing: 6) {
            Button(action: {
                homeworkItem.isCompleted.toggle()
            }) {
                Image(systemName: homeworkItem.isCompleted ? "checkmark.square.fill" : "square")
                    .foregroundColor(homeworkItem.isCompleted ? Color.mainAdd : Color.addText)
                    .font(.title2)
            }
            TextField(text: $homeworkItem.name) {
                Text("Enter homework")
                    .customFont(.mainText)
                    .foregroundStyle(Color.mainText.opacity(0.5))
            }
            .foregroundStyle(Color.mainText)
            .customFont(.mainText)
        }
        .frame(maxHeight:
                24)

        
    }
}
