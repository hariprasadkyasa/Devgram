//
//  CreatePostView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import SwiftUI

struct CreatePostView: View {
    @StateObject var createPostViewModel = CreatePostViewModel()
    var body: some View {
        VStack{
            Text("Create Post")
                .font(.title)
            TextEditor(text: $createPostViewModel.postContent)
                .foregroundStyle(.black)
                .border(Color.gray, width: 1)
                .frame(height: 300)
                .cornerRadius(8.0)
            
            Button {
                Task{
                    try await createPostViewModel.createPost()
                }
                
            } label: {
                Text("Post")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }.disabled(createPostViewModel.postContent.isEmpty)
            
        }
        .padding()
        
        
    }
}

#Preview {
    CreatePostView()
}
