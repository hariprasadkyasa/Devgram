//
//  CreatePostView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import SwiftUI

struct CreatePostView: View {
    @StateObject var viewModel : CreatePostViewModel
    @State var userSessionManager : UserSessionManager
    @State private var selectedPostType = 0
    @Binding var currentSelectedTab: Tab
    
    init(userSessionManager: UserSessionManager,postsService: PostsService, currentSelectedTab: Binding<Tab>) {
        _viewModel = .init(wrappedValue: CreatePostViewModel(postsService: postsService))
        _userSessionManager = .init(wrappedValue: userSessionManager)
        _currentSelectedTab = .init(projectedValue: currentSelectedTab)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            HStack{
                Text("Create Post")
                    .font(.title)
                Spacer()
                Button {
                    if let clipboardText = UIPasteboard.general.string {
                        viewModel.postContent = clipboardText
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
            
            TextEditor(text: $viewModel.postContent)
                .autocorrectionDisabled()
                .textInputAutocapitalization(selectedPostType == 1 ? .never : .sentences)
                .scrollContentBackground(.hidden)
                .background(selectedPostType == 1 ? Color.black : Color.white)
                .font(.system(.body, design: selectedPostType == 1 ? .monospaced : .default))
                .foregroundStyle(fontColor)
                .frame(height: 300)
                .cornerRadius(8.0)
                .border(Color.gray, width: 1)
                .accessibilityIdentifier("NewPost_Editor")
            Picker("Post type", selection: $selectedPostType) {
                ForEach(0..<viewModel.postTypes.count, id: \.self) { index in
                    let postType = viewModel.postTypes[index]
                    Text(postType).tag(index)
                }
            }.pickerStyle(.segmented)
                
            Button {
                Task{ @MainActor in
                    if let currentUser = userSessionManager.getCurrentUser() {
                        do {
                            try await viewModel.createPost(type: selectedPostType, for: currentUser)
                            //display an overlay that post is shared
                            viewModel.displayOverlayMessage = true
                            //dismiss after 2 seconds
                            try? await Task.sleep(nanoseconds: 1_000_000_000)
                            viewModel.displayOverlayMessage = false
                            //navigate to posts view
                            viewModel.postContent = ""
                            self.currentSelectedTab = Tab.posts
                        }catch{
                            print("Error creating post \(error)")
                            viewModel.displayError(error: error, heading: Constants.ErrorMessages.errorCreatingPostHeading)
                        }
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
            }.disabled(viewModel.postContent.isEmpty)
            
        }
        .navigationBarTitle("New Post")
        .padding()
        .overlay {
            if viewModel.displayOverlayMessage {
                OverlayMessageView(message: "Post shared", indicateSuccess: true)
            }
        }
        .alert(viewModel.messageToDisplay.heading, isPresented: $viewModel.displayMessage) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.messageToDisplay.message)
        }
        .onAppear{
            print("on appear cteat post")
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


