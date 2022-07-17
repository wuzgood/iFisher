//
//  FishListView.swift
//  iFisherman
//
//  Created by Wuz Good on 07.07.2022.
//

import SwiftUI

struct FishListView: View {
    
    // MARK: - Properties
    @State private var isShowingAnecdote = false
    @StateObject private var modelData = DBViewModel()
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            Group {
                if modelData.fishes.count == 0 {
                    Text("Го рыбачить 🎣")
                } else {
                    fishesList
                }
            }
            .navigationTitle("iFisher")
            .sheet(isPresented: $modelData.openNewPage, content: {
                NewFishView()
                    .environmentObject(modelData)
            })
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {} label: {
                        Image(systemName: "map").hidden()
                    }
                    Spacer()
                    Button {
                        modelData.openNewPage.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    Spacer()
                    Button {
                        isShowingAnecdote = true
                    } label: {
                        Image(systemName: "theatermasks")
                    }
                }
            }
            .alert("Анекдот", isPresented: $isShowingAnecdote, actions: {
                Button("😄") {}
            }, message: {
                Text(getAnecdote())
            })
        }
    }
    
    var fishesList: some View {
        List {
            ForEach(modelData.fishes) { fish in
                NavigationLink(destination: FishDetailView(fish: fish)) {
                    FishRow(fish: fish)
                }
                .contextMenu {
                    Button {
                        modelData.updateObject = fish
                        modelData.openNewPage.toggle()
                    } label: {
                        Label("Изменить", systemImage: "square.and.pencil")
                    }
                }
            }
            .onDelete(perform: modelData.deleteRow)
        }
    }
        
    private func getAnecdote() -> String {
        let anecdotes = anecdotes.components(separatedBy: "*   *   *")
        return anecdotes.randomElement() ?? ""
    }
    
}

// MARK: - Preview
struct FishListView_Previews: PreviewProvider {
    static var previews: some View {
        FishListView()
    }
}

