//
//  CreatePostView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import SwiftUI
/**
 This view provides inteface to create a new post.
 User can perform the following tasks using this inteface:
  - Provide content for a new post using a text editor.
  - Select the type of post (Text, Code, or Link) through a segmented control.
  - Submit the post to the server using the `Post` button.
  - Handle success and error states during post creation.
  - Automatically navigate to the posts feed upon successful post creation.
 */
struct CreatePostView: View {
    //MARK: Properties
    @StateObject var viewModel : CreatePostViewModel
    @State var userSessionManager : UserSessionManager
    @State private var selectedPostType = 0
    @Binding var currentSelectedTab: Tab
    
    /**
     Initializes the `CreatePostView` with the required dependencies.
     - Parameters:
       - userSessionManager: The session manager for getting current user details.
       - postsService: The service responsible for creating new post.
       - currentSelectedTab: A binding that manages the currently active tab in the main Tab view.
     */
    init(userSessionManager: UserSessionManager,postsService: PostsService, currentSelectedTab: Binding<Tab>) {
        _viewModel = .init(wrappedValue: CreatePostViewModel(postsService: postsService))
        _userSessionManager = .init(wrappedValue: userSessionManager)
        _currentSelectedTab = .init(projectedValue: currentSelectedTab)
    }
    
    //MARK: View Body
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
                .accentColor(fontColor)
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
    
    /**
     A varibale that decides the font color based on the selected post type.
     */
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


