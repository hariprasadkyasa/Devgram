//
//  BaseViewModel.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 02/01/25.
//

import Foundation

struct Message{
    let heading : String
    let message : String
}

class BaseViewModel : ObservableObject {
    @Published var displayMessage : Bool = false
    @Published var messageToDisplay : Message = Message(heading: "", message: "")
    @Published var displayOverlayMessage : Bool = false
    var overlayMessage : String = ""
    
    func displayError(error: Error, heading: String){
        var message = error.localizedDescription
        if let connectionError = error as? ConnectionError{
            message = connectionError.localizedDescription
        }
        messageToDisplay = Message(heading: heading, message: message)
        displayMessage = true
    }
}
