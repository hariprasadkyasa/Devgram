//
//  CreatePostView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import SwiftUI

struct CreatePostView: View {
    @StateObject var createPostViewModel = CreatePostViewModel()
    @EnvironmentObject var loginViewModel : LoginViewModel
    @State private var selectedPostType = 0
    @Binding var currentSelectedTab: Tab
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            HStack{
                Text("Create Post")
                    .font(.title)
                Spacer()
                Button {
                    if let clipboardText = UIPasteboard.general.string {
                        createPostViewModel.postContent = clipboardText
                    }
                } label: {
                    Text("Paste")
                        .font(.caption)
                        .foregroundStyle(Color.black)
                        .padding(5)
                        .border(Color.gray, width: 1)
                        .cornerRadius(3.0)
                }

            }
            
            TextEditor(text: $createPostViewModel.postContent)
                .autocorrectionDisabled()
                .textInputAutocapitalization(selectedPostType == 1 ? .never : .sentences)
                .scrollContentBackground(.hidden)
                .background(selectedPostType == 1 ? Color.black : Color.white)
                .font(.system(.body, design: selectedPostType == 1 ? .monospaced : .default))
                .foregroundStyle(fontColor)
                .frame(height: 300)
                .cornerRadius(8.0)
                .border(Color.gray, width: 1)
            Picker("Post type", selection: $selectedPostType) {
                ForEach(0..<createPostViewModel.postTypes.count, id: \.self) { index in
                    let postType = createPostViewModel.postTypes[index]
                    Text(postType).tag(index)
                }
            }.pickerStyle(.segmented)
                
            Button {
                Task{ @MainActor in
                    if let currentUser = loginViewModel.currentUser {
                        try await createPostViewModel.createPost(type: selectedPostType, for: currentUser)
                        //display an overlay that post is shared
                        createPostViewModel.displayOverlayMessage = true
                        //dismiss after 2 seconds
                        try? await Task.sleep(nanoseconds: 1_000_000_000)
                        createPostViewModel.displayOverlayMessage = false
                        //navigate to posts view
                        self.currentSelectedTab = Tab.posts
                    }
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
        .navigationBarTitle("New Post")
        .padding()
        .overlay {
            if createPostViewModel.displayOverlayMessage {
                OverlayMessageView(message: "Post shared.", indicateSuccess: true)
            }
            
        }
    }
    
    
    var fontColor : Color {
        switch selectedPostType {
        case 0:
            return .black
        case 1:
            return .white
        case 2:
            return .blue
            
        default:
            return .black
        }
    }
}

#Preview {
    CreatePostView( currentSelectedTab: .constant(Tab.createPost))
}
