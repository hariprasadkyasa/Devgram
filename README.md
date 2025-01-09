# Devgram

Devgram is a social networking app designed for developers with the following basic functionality:

## Features:
- **Signing up as a new user**
- **Authentication** with registered credentials
- **Auto sign-in** if already logged in previously
- **Viewing posts feed** from other users in the community
- **Reacting to posts** by clap/like
- **Sharing a new post** to the community
  - Posts can be of 3 types: Text, Code, and Link
- **View current user profile** with a list of their own posts

---

## Architecture
This app uses **MVVM architecture** to separate concerns.  
The view structure is managed with **NavigationView** and **TabView**.

---

## Objective and Focus:
The app demonstrates:
- **Clean Architecture**
- **Dependency Injection**
- **Pagination**
- **Reusable Components**

With additional time, there is significant potential to implement more features and scale the app effectively, leveraging the existing architecture.

---

## Usage Instructions:

- Launch the app 
- Signup by providing a unique email id and other details.
- The app automatically logs in after successful signup
- Alternatively, you can login with a demo account:- email: demo@test.com, password: demouser
- The app displays posts that community has shared
- Use Create Post option to share new post
---

## Key Components:
- **AuthenticationService**: A protocol defining a set of methods to handle user signup and authentication operations.
- **AuthenticationServiceManager**: A class implementing the `AuthenticationService`.
- **PostsService**: A protocol defining methods to perform fetching and updating operations on posts.
- **PostsServiceManager**: A class implementing the `PostsService`.
- **UserSessionManager**: A protocol to manage the current user's authentication session.
- **LoginView** & **SignupView**: Views to display user signup and authentication interfaces.
- **LoginViewModel**: An `ObservableObject` that manages the UI for `LoginView` and implements `UserSessionManager` to manage the current user session.
- **MainTabView**: The top-level `TabView` in the app, consisting of 3 tabs for displaying:
  - Posts feed
  - Create post
  - User profile
- **PostsView**: Displays posts in a scrollable view with lazy loading.
- **CreatePostView**: Displays an interface to create a new post.
- **ProfileView**: Displays the user profile.

---

## Application Control Flow and Structure:
1. When the app is launched, the **DevgramApp struct** is instantiated as the entry point of the app.
2. **DevgramApp** creates instances for `AuthenticationServiceManager` and `PostsServiceManager` as state variables.
3. **DevgramApp** adds `LoginView` to the app window and passes the instances of `AuthenticationServiceManager` and `PostsServiceManager` as protocol references of `AuthenticationService` and `PostsService`.
   - This step injects the dependencies as abstract types while keeping the concrete implementation types hidden.
4. The `LoginView`:
   - Displays the login/signup interface in a `NavigationView`.
   - Checks for an active session for a previously logged-in user and validates it.
   - Automatically logs in the user if the session is valid.
5. After authentication:
   - `LoginView` pushes `MainTabView` onto the `NavigationView`.
   - Passes instances of `LoginViewModel`, `AuthenticationService`, and `PostsService` as dependencies to `MainTabView`.
6. **MainTabView** creates:
   - `PostsView`
   - `CreatePostsView`
   - `ProfileView`
   - Passes applicable dependencies to each view.

### ViewModel Responsibilities:
- Each View creates corresponding `ObservableObject` ViewModel instances and manages their dependencies.
- ViewModels manage fetching data using dependencies, handle state updates, and coordinate data between the model layer and the views.

---

## Key Functionality:

### **Viewing Posts with Pagination**
1. After user authentication, the app displays `PostsView`.
2. When `PostsView` is instantiated:
   - It creates an instance of `PostsViewModel` as a `@StateObject`.
   - `PostsViewModel` depends on `PostsService` and accepts it as a dependency in the initializer.
3. When the view appears:
   - `PostsView` calls a method on `PostsViewModel` to fetch posts.
   - `PostsViewModel` uses `PostsService` to fetch the data and store it in a `Published` property.
4. `PostsView` uses a **LazyVStack** to render posts in a `ScrollView`.
5. As the user scrolls:
   - `PostsViewModel` fetches the next set of data and appends it to the `Published` property.
   - This triggers UI updates, rendering new posts in the `LazyVStack`.

### **Creating a Post**
1. User selects the "Add Post" tab to access `CreatePostView`.
2. When `CreatePostView` is instantiated:
   - It creates an instance of `CreatePostViewModel` as a `@StateObject`.
   - `CreatePostViewModel` depends on `PostsService` and accepts it as a dependency in the initializer.
3. The view provides an interface for creating posts with the following types:
   - **Text**: A plain text post.
   - **Code**: A block of code.
   - **Link**: A link to a URL.
4. Once the user clicks the "Create Post" button:
   - `CreatePostView` calls a method on `CreatePostViewModel` to save the post using `PostsService`.
5. On successful post creation:
   - The app switches back to the `PostsView` tab, displaying the updated feed.
6. If an error occurs while saving:
   - An alert is displayed, and the app remains on `CreatePostView`.

### **User Profile**
1. User selects the "Profile" tab to access `ProfileView`.
2. When `ProfileView` is instantiated:
   - It creates an instance of `ProfileViewModel` as a `@StateObject`.
   - `ProfileViewModel` depends on `PostsService` and `UserSessionManager` and accepts them as dependencies.
3. When the view appears:
   - `ProfileViewModel` fetches user profile data and the user's posts.
   - `ProfileViewModel` uses:
     - `UserSessionManager` to get the current user profile (e.g., username and email).
     - `PostsService` to fetch all posts by the current user.
4. The view displays:
   - User details in a `VStack`.
   - User posts in a `GridView` with pagination for incremental loading.
5. When the user clicks "Logout":
   - `ProfileViewModel` invalidates the user session using `UserSessionManager`.
   - This updates the app to navigate back to `LoginView`.

---
## Areas for improvement/extention:
Due to time constraints, i was unable to work on enhancing error handling to display more specific error messages and resolving certain identified bugs along with following planned functionality.
- Opening post in a separate view
- Editing profile
- Upload image for profile
- New Post with image type
## Summary
This app demonstrates key architectural patterns and modern practices in iOS app development:
- Clean Architecture
- Dependency Injection
- Pagination
- Reusable Components

With proper implementation and scalability in mind, it serves as a robust prototype for a developer-focused social networking application.
