//
//  EmailValidationForm.swift
//  EmailValidationForm
//
//  Created by Peter Friese on 03.09.21.
//

import SwiftUI
import Combine

class EmailValidationViewModel: ObservableObject {
  @Published var email = ""
  @Published var emailConfirmation = ""
  
  @Published var isEmailValid = false
  @Published var isEmailConfirmationValid = false
  
  @Published var errorMessage = ""
  
  @Published var isFormValid = false
  
  @Published var presentSuccessMessage = false
  
  init() {
    let emailsMatchPublisher =
    Publishers.CombineLatest($email, $emailConfirmation)
      .map { $0 == $1 }
      .share()
    
    emailsMatchPublisher
      .map { $0 ? "" : "Emails don't match" }
      .assign(to: &$errorMessage)
    
    emailsMatchPublisher
      .combineLatest($isEmailValid, $isEmailConfirmationValid)
      .map { $0 && $1 && $2 }
      .assign(to: &$isFormValid)
  }
}

struct EmailValidationForm: View {
  @StateObject var viewModel = EmailValidationViewModel()
  
  var errorLabel: some View {
    Text(viewModel.errorMessage)
      .textCase(.none)
      .foregroundColor(.red)
  }
  
  var body: some View {
    Form {
      Section(header: errorLabel) {
        TextInputField("Email address",
                       text: $viewModel.email,
                       isValid: $viewModel.isEmailValid)
          .isMandatory()
          .onValidate { value in
            value.isEmail() ? .success(true) : .failure(.init(message: "\(value) is not a valid email address"))
          }
          .autocapitalization(.none)
        
        TextInputField("Confirm your email address",
                       text: $viewModel.emailConfirmation,
                       isValid: $viewModel.isEmailConfirmationValid)
          .isMandatory()
          .onValidate { value in
            value.isEmail() ? .success(true) : .failure(.init(message: "\(value) is not a valid email address"))
          }
          .autocapitalization(.none)
      }
      Section {
        Button("Submit") {
          viewModel.presentSuccessMessage.toggle()
        }
        .disabled(!viewModel.isFormValid)
      }
    }
    .navigationTitle("Email validation")
    .alert("Success", isPresented: $viewModel.presentSuccessMessage) {
      Button("OK") { }
    } message: {
      Text("You entered: \(viewModel.email)")
    }
  }
}

struct EmailValidationForm_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      EmailValidationForm()
    }
  }
}
