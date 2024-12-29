//
//  LoginViewModel.swift
//  Devgram
//
//  Created by Raghavendra Hariprasad Kyasa on 29/12/24.
//

import Foundation

class LoginViewModel : ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var userAuthenticated = false
}
