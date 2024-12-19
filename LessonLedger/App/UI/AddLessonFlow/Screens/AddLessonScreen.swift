import SwiftUI
import AVFoundation

@available(iOS 16.0, *)
struct AddLessonScreen: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @State private var date = Date()
    @State var name: String = ""
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State var audience: String = ""
    
    @State private var showDatePicker = false
    @State private var showStartTimePicker = false
    @State private var showEndTimePicker = false
    
    private let storage = Storage.shared
    
    var body: some View {
        VStack(spacing: 0) {
            ScreenTitle(text: "Add lesson")
            
            VStack(spacing: 22) {
                
                HStack(spacing: 12) {
                    DatePickerButton(date: $date, showDatePicker: $showDatePicker)
                    MainTextField(title: "Item name", text: $name)
                }
                PickerSection(
                    showPicker: $showDatePicker,
                    date: $date,
                    pickerType: .date
                )
                HStack(spacing: 12) {
                    TimePickerButton(text: "Start time", time: $startTime, showTimePicker: $showStartTimePicker)
                    TimePickerButton(text: "End time", time: $endTime, showTimePicker: $showEndTimePicker)
                }
                PickerSection(
                    showPicker: $showStartTimePicker,
                    date: $startTime,
                    pickerType: .hourAndMinute
                )
                
                PickerSection(
                    showPicker: $showEndTimePicker,
                    date: $endTime,
                    pickerType: .hourAndMinute
                )
                
                MainTextField(title: "Audience", text: $audience)
                
                Spacer()
                
                
                ActionButtons(cancelButtonAction: cancel, saveButtonAction: save)
                    .padding(.bottom, 45)
            }.padding(EdgeInsets(top: 47, leading: 22, bottom: 0, trailing: 22))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.ignoresSafeArea())
    }
    private func save() {
        let lesson = Lesson(
            name: name, date: date, startTime: startTime, endTime: endTime, audience: audience, homeworkItems: []
        )
        storage.saveLesson(lesson)
        cleanFields()
    }
    
    private func cancel() {
        cleanFields()
    }
    private func cleanFields() {
        name = ""
        date = Date()
        startTime = Date()
        endTime = Date()
        audience = ""
    }
}

private struct PickerSection: View {
    @Binding var showPicker: Bool
    @Binding var date: Date
    var pickerType: ComponentType
    
    enum ComponentType {
        case date
        case hourAndMinute
    }
    
    var body: some View {
        Group {
            if showPicker {
                if pickerType == .date {
                    // Graphical DatePicker
                    DatePicker("", selection: $date, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .background(Color.mainAdd)
                        .cornerRadius(10)
                        .transition(.opacity)
                        .padding(EdgeInsets(top: 33, leading: 33, bottom: 0, trailing: 33))
                        .onChange(of: date) { _ in
                            withAnimation {
                                showPicker = false
                            }
                        }
                } else {
                    // Wheel DatePicker for time
                    DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .padding()
                        .background(Color.mainAdd)
                        .cornerRadius(10)
                        .transition(.opacity)
                        .padding(EdgeInsets(top: 33, leading: 33, bottom: 0, trailing: 33))
                        .onChange(of: date) { _ in
                            withAnimation {
                                showPicker = false
                            }
                        }
                }
            }
        }
    }
}

@available(iOS 16.0, *)
private struct DatePickerButton: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var date: Date
    @Binding var showDatePicker: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Day of the week")
                .customFont(.mainText)
                .foregroundColor(Color.mainText)
            
            Button(action: {
                withAnimation { showDatePicker.toggle() }
            }) {
                HStack {
                    Text(formattedDate(date, format: "dd/MM/yyyy"))
                        .foregroundStyle(Color.mainText)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .customFont(.mainText)
                .padding(19)
                .cornerRadius(10)
                .background(Color.itemsBackground)
                .frame(maxHeight: 43)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.addLight, lineWidth: 1)
                )
            }
        }
    }
}

@available(iOS 16.0, *)
private struct TimePickerButton: View {
    @EnvironmentObject var themeManager: ThemeManager
    let text: String
    @Binding var time: Date
    @Binding var showTimePicker: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(text)
                .customFont(.mainText)
                .foregroundColor(Color.mainText)
            
            Button(action: {
                withAnimation { showTimePicker.toggle() }
            }) {
                HStack {
                    Text(formattedDate(time, format: "HH:mm"))
                        .foregroundStyle(Color.mainText)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .customFont(.mainText)
                .padding(19)
                .cornerRadius(10)
                .background(Color.itemsBackground)
                .frame(maxHeight: 43)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.addLight, lineWidth: 1)
                )
            }
        }
    }
}

