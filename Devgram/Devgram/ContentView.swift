//
//  ContentView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 27/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PostsViewModel()
    @State var message = "Hello, world!"
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(message)
            Button("Click") {
                message = "Hi"
            }
        }
        .padding()
        .onAppear{
            viewModel.loadPosts()
        }
    }
}

#Preview {
    ContentView()
}
