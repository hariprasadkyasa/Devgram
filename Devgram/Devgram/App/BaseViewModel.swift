//
//  BaseViewModel.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 02/01/25.
//
import Foundation
/**
 A struct representing a message with a heading and body text.
 */
struct Message{
    let heading : String
    let message : String
}
/**
 `BaseViewModel` class that provides shared state and functionality for managing and displaying messages, overlays, and loading indicators in the app. Other key viewmodel classes extends from this class.
 This class conforms to `ObservableObject`, enabling views to automatically update whenever its published properties change.
 */
class BaseViewModel : ObservableObject {
    @Published var displayMessage : Bool = false
    @Published var messageToDisplay : Message = Message(heading: "", message: "")
    @Published var displayOverlayMessage : Bool = false
    @Published var isLoading: Bool = false
    var overlayMessage : String = ""
    
    /**
     Updates the state to display an error message with the given heading.
     This method is designed to handle errors and present them to the user in a consistent format. If the error is of type `ConnectionError`, it uses the localized description from that error.
     - Parameters:
        - error: The error object to be displayed.
        - heading: The heading/title of the error message.
     */
    func displayError(error: Error, heading: String){
        var message = error.localizedDescription
        if let connectionError = error as? ConnectionError{
            message = connectionError.localizedDescription
        }
        messageToDisplay = Message(heading: heading, message: message)
        displayMessage = true
    }
}
