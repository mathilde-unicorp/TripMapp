//
//  HomeView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 24/04/2023.
//

import SwiftUI
import CoreData

struct ExampleView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: TripProjectEntity.sortedFetchRequest())

    private var items: FetchedResults<TripProjectEntity>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        VStack {
                            Text(item.name ?? "")

                            Button("delete") {
                                viewContext.delete(item)
                            }
                        }
                    } label: {
                        Text(item.startDate ?? .now, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("_example_add_item", systemImage: "plus")
                    }
                }
            }
            Text("_example_select_item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = TripProjectEntity(context: viewContext)
            newItem.name = "New Project"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
            .configureEnvironmentForPreview()
    }
}
