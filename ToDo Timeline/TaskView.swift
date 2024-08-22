//
//  TaskView.swift
//  ToDo Timeline
//
//  Created by Ruben Granet on 22/08/2024.
//

import SwiftUI

struct TaskView: View {
    var item: TDModel
    
    var body: some View {
        HStack {
            Image(systemName: item.isComplete ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(item.isComplete ? .green : .gray)
                .frame(maxHeight: .infinity, alignment: .top)
                .font(.title2)
            
            VStack(alignment: .leading) {
                HStack(content: {
                    Text(item.title)
                        .font(.title2)
                        .strikethrough(item.isComplete)
                    
                    Spacer()
                    
                    Image(systemName: "pencil")
                        .frame(width: 28, height: 28)
                        .background(.thinMaterial, in: Circle())
                        .offset(x: 5, y: -5)
                })
                
                Text(item.details)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(.thinMaterial, in: .rect(cornerRadius: 12))
            .animation(.none, value: item.isComplete)
            
            Spacer()
        }
    }
}

#Preview {
    TaskView(item: TDModel(title: "Read book", details: "Finish reading 'The Swift Programming Language'"))
}
