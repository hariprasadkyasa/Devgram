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
        LoginView()
    }
}

#Preview {
    ContentView()
}
