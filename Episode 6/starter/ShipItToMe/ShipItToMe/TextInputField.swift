//
//  TextInputField.swift
//  ShipItToMe
//
//  Created by Peter Friese on 01.05.21.
//

import SwiftUI
import Combine

struct TextInputField: View {
  private var title: String
  @Binding private var text: String
  @Environment(\.clearButtonHidden) var clearButtonHidden
  @Environment(\.isMandatory) var isMandatory
  @Environment(\.validationHandler) var validationHandler
  
  @Binding private var isValidBinding: Bool
  @State private var isValid: Bool = true {
    didSet {
      isValidBinding = isValid
    }
  }
  @State var validationMessage: String = ""
  
  init(_ title: String, text: Binding<String>, isValid isValidBinding: Binding<Bool>? = nil) {
    self.title = title
    self._text = text
    self._isValidBinding = isValidBinding ?? .constant(true)
  }
  
  var clearButton: some View {
    HStack {
      if !clearButtonHidden {
        Spacer()
        Button(action: { text = "" }) {
          Image(systemName: "multiply.circle.fill")
            .foregroundColor(Color(UIColor.systemGray))
        }
      }
      else  {
        EmptyView()
      }
    }
  }
  
  var clearButtonPadding: CGFloat {
    !clearButtonHidden ? 25 : 0
  }
  
  fileprivate func validate(_ value: String) {
    isValid = true
    if isMandatory {
      isValid = !value.isEmpty
      validationMessage = isValid ? "" : "This is a mandatory field"
    }
    
    if isValid {
      guard let validationHandler = self.validationHandler else { return }
      
      let validationResult = validationHandler(value)
      
      if case .failure(let error) = validationResult {
        isValid = false
        self.validationMessage = "\(error.localizedDescription)"
      }
      else if case .success(let isValid) = validationResult {
        self.isValid = isValid
        self.validationMessage = ""
      }
    }
  }

  var body: some View {
    ZStack(alignment: .leading) {
      if !isValid {
        Text(validationMessage)
          .foregroundColor(.red)
          .offset(y: -25)
          .scaleEffect(0.8, anchor: .leading)
      }
      if (text.isEmpty || isValid) {
        Text(title)
          .foregroundColor(text.isEmpty ? Color(.placeholderText) : .accentColor)
          .offset(y: text.isEmpty ? 0 : -25)
          .scaleEffect(text.isEmpty ? 1: 0.8, anchor: .leading)
      }
      TextField("", text: $text)
        .onAppear {
          validate(text)
        }
        .onChange(of: text) { value in
          validate(value)
        }
        .padding(.trailing, clearButtonPadding)
        .overlay(clearButton)
    }
    .padding(.top, 15)
    .animation(.default, value: text)
  }
}

// MARK: - Clear Button

extension View {
  func clearButtonHidden(_ hidesClearButton: Bool = true) -> some View {
    environment(\.clearButtonHidden, hidesClearButton)
  }
}

private struct TextInputFieldClearButtonHidden: EnvironmentKey {
  static var defaultValue: Bool = false
}

extension EnvironmentValues {
  var clearButtonHidden: Bool {
    get { self[TextInputFieldClearButtonHidden.self] }
    set { self[TextInputFieldClearButtonHidden.self] = newValue }
  }
}

// MARK: - Mandatory Field

extension View {
  func isMandatory(_ value: Bool = true) -> some View {
    environment(\.isMandatory, value)
  }
}

private struct TextInputFieldMandatory: EnvironmentKey {
  static var defaultValue: Bool = false
}

extension EnvironmentValues {
  var isMandatory: Bool {
    get { self[TextInputFieldMandatory.self] }
    set { self[TextInputFieldMandatory.self] = newValue }
  }
}

// MARK: - Validation Handler

struct ValidationError: Error {
  let message: String
}

extension ValidationError: LocalizedError {
  public var errorDescription: String? {
    return NSLocalizedString("\(message)", comment: "Message for generic validation errors.")
  }
}

private struct TextInputFieldValidationHandler: EnvironmentKey {
  static var defaultValue: ((String) -> Result<Bool, ValidationError>)?
}

extension EnvironmentValues {
  var validationHandler: ((String) -> Result<Bool, ValidationError>)? {
    get { self[TextInputFieldValidationHandler.self] }
    set { self[TextInputFieldValidationHandler.self] = newValue }
  }
}

extension View {
  func onValidate(validationHandler: @escaping (String) -> Result<Bool, ValidationError>) -> some View {
    environment(\.validationHandler, validationHandler)
  }
}

// MARK: - Previews

struct TextInputField_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      TextInputField("First Name", text: .constant("Bowerick Wowbagger the Infinitely Prolonged from outer space"))
        .clearButtonHidden()
        .previewLayout(.sizeThatFits)
      TextInputField("First Name", text: .constant("Peter"))
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
    }
  }
}
