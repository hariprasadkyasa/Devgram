//
//  OverlayMessageView.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 30/12/24.
//

import SwiftUI
/**
 A view that displays an overlay message with optional visual indicators for progress, success, or error.
 This reusable component is designed to show feedback to the user in the form of:
 - A progress spinner when a process is ongoing.
 - A success icon when an operation is completed successfully.
 - An error icon when an operation fails.
 This component can be used in .overlay view modifier in any view 
 */
struct OverlayMessageView: View {
    @State var message : String = ""
    @State var showProgress : Bool = false
    @State var indicateSuccess : Bool = false
    @State var indicateError : Bool = false
    var body: some View {
        VStack(spacing:15) {
            if showProgress {
                ProgressView()
            }else if indicateSuccess {
                Image(systemName: "checkmark.circle.fill")
                    .scaleEffect(2)
                    .foregroundStyle(Color.green)
            } else if indicateError{
                Image(systemName: "x.circle.fill")
                    .scaleEffect(2)
                    .foregroundStyle(Color.red)
            }
            Text(message)
        }
        .frame(width: 200, height: 100)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.3), radius: 20)
    }
}

#Preview {
    OverlayMessageView(message:"Post shared", indicateError: true)
}
