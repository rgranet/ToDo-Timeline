//
//  TimeLineView.swift
//  ToDo Timeline
//
//  Created by Ruben Granet on 22/08/2024.
//

import SwiftUI

struct TimeLineView: View {
    @State var items: [TDModel] = [
        TDModel(title: "Buy groceries", details: "Milk, Eggs, Bread, and Butter"),
        TDModel(title: "Finish project", details: "Complete the SwiftUI app for client"),
        TDModel(title: "Workout", details: "Go to the gym for an hour"),
        TDModel(title: "Read book", details: "Finish reading 'The Swift Programming Language'"),
        TDModel(title: "Call mom", details: "Catch up with mom this weekend")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16, content: {
                ForEach(items.indices, id: \.self) { item in
                    TaskView(item: items[item])
                        .background(alignment: .topLeading, content: {
                            GeometryReader { geo in
                                Rectangle()
                                    .frame(width: 2)
                                    .foregroundStyle(items.allSatisfy({$0.isComplete}) ? .green : .gray)
                                    .frame(maxHeight: items[item].isComplete ? geo.size.height - 5 : 0)
                                    .offset(y: 23)
                                    .padding(.leading, 12)
                            }
                        })
                        .onTapGesture {
                            withAnimation(.spring(duration: 0.3)) {
                                items[item].isComplete.toggle()
                            }
                        }
                }
                HStack {
                    Image(systemName: items.allSatisfy({$0.isComplete}) ? "checkmark.circle.fill" : "circle")
                    Text("Finish")
                    Spacer()
                }
                .foregroundStyle(items.allSatisfy({$0.isComplete}) ? .green : .gray)
                .font(.title2)
                .onTapGesture {
                    toggleItems()
                }
            })
        }
        .safeAreaPadding()
    }
    
    func toggleItems() {
        let allTrue = items.allSatisfy({$0.isComplete})
        updateItemsSequentially(makeTrue: !allTrue, reverse: allTrue)
    }
    
    func updateItemsSequentially(makeTrue: Bool, reverse: Bool) {
        let delayStep = 0.3
        let indices = reverse ? Array(items.indices.reversed()) : Array(items.indices)
        for (offset, index) in indices.enumerated() {
            let delay = Double(offset) * delayStep
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation {
                    items[index].isComplete = makeTrue
                }
            }
        }
    }
}

#Preview {
    TimeLineView()
}


struct TDModel: Identifiable {
    var id = UUID()
    var title: String
    var details: String
    var isComplete: Bool = false
}
