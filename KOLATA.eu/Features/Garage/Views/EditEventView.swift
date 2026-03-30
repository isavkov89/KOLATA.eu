import SwiftUI

struct EditEventView: View {
    let car: Car
    let event: EventEntry?
    @Environment(\.dismiss) private var dismiss

    @State private var title: String
    @State private var type: String
    @State private var date: Date
    @State private var entryDescription: String
    @State private var notes: String

    private let eventTypes = ["General", "Accident", "Inspection", "Service", "Wash", "Parking", "Toll", "Other"]
    private var isEditing: Bool { event != nil }

    init(car: Car, event: EventEntry?) {
        self.car = car
        self.event = event
        _title = State(initialValue: event?.title ?? "")
        _type = State(initialValue: event?.type ?? "General")
        _date = State(initialValue: event?.date ?? Date())
        _entryDescription = State(initialValue: event?.entryDescription ?? "")
        _notes = State(initialValue: event?.notes ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Title", text: $title)
                    Picker("Type", selection: $type) {
                        ForEach(eventTypes, id: \.self) { Text($0) }
                    }
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    TextField("Description", text: $entryDescription, axis: .vertical)
                        .lineLimit(2...4)
                }

                Section("Notes") {
                    TextField("Notes", text: $notes, axis: .vertical)
                        .lineLimit(2...4)
                }
            }
            .navigationTitle(isEditing ? "Edit Event" : "Add Event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .disabled(title.isEmpty)
                }
            }
        }
    }

    private func save() {
        if let event {
            event.title = title
            event.type = type
            event.date = date
            event.entryDescription = entryDescription
            event.notes = notes
        } else {
            let newEvent = EventEntry(
                title: title,
                type: type,
                date: date,
                entryDescription: entryDescription,
                notes: notes
            )
            car.events.append(newEvent)
        }
        dismiss()
    }
}
