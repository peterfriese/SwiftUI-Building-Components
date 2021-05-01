//
//  TextInputField.swift
//  ShipItToMe
//
//  Created by Peter Friese on 01.05.21.
//

import SwiftUI

struct TextInputField: View {
  private var title: String
  @Binding private var text: String
  @Environment(\.clearButtonHidden) var clearButtonHidden
  
  init(_ title: String, text: Binding<String>) {
    self.title = title
    self._text = text
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
  
  var body: some View {
    ZStack(alignment: .leading) {
      Text(title)
        .foregroundColor(text.isEmpty ? Color(.placeholderText) : .accentColor)
        .offset(y: text.isEmpty ? 0 : -25)
        .scaleEffect(text.isEmpty ? 1: 0.8, anchor: .leading)
      TextField("", text: $text)
        .padding(.trailing, clearButtonPadding)
        .overlay(clearButton)
    }
    .padding(.top, 15)
    .animation(.default)
  }
}

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
