//
//  ContentView.swift
//  ShipItToMe
//
//  Created by Peter Friese on 03.04.21.
//

import SwiftUI

struct ShippingAddress {
  var firstName: String
  var lastName: String
  var street: String
  var number: String
  var postcode: String
  var city: String
  var county: String
  var country: String
}

extension ShippingAddress {
  init() {
    self.init(firstName: "",
              lastName: "",
              street: "",
              number: "",
              postcode: "",
              city: "",
              county: "",
              country: "")
  }
}

struct ShippingForm: View {
  @State var shippingAddress = ShippingAddress()
  var body: some View {
    Form {
      Section(header: Text("Input")) {
        TextInputField("First Name", text: $shippingAddress.firstName)
          .accentColor(.pink)
        TextInputField("Last Name", text: $shippingAddress.lastName)
        TextInputField("Street", text: $shippingAddress.street)
        TextInputField("Number", text: $shippingAddress.number)
        TextInputField("Post code", text: $shippingAddress.postcode)
        TextInputField("City", text: $shippingAddress.city)
        TextInputField("County", text: $shippingAddress.county)
        TextInputField("Country", text: $shippingAddress.country)
      }
      Section(header: Text("Output")) {
        Text("First name: \(shippingAddress.firstName)")
        Text("Last name: \(shippingAddress.lastName)")
        Text("Street: \(shippingAddress.street)")
        Text("Number: \(shippingAddress.number)")
        Text("City: \(shippingAddress.city)")
        Text("Post code: \(shippingAddress.postcode)")
        Text("County: \(shippingAddress.county)")
      }
    }
    .navigationBarTitle("Address")
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ShippingForm()
    }
  }
}

struct TextInputField: View {
  private var title: String
  @Binding private var text: String
  
  init(_ title: String, text: Binding<String>) {
    self.title = title
    self._text = text
  }
  
  var body: some View {
    ZStack(alignment: .leading) {
      Text(title)
        .foregroundColor(text.isEmpty ? Color(.placeholderText) : .accentColor)
        .offset(y: text.isEmpty ? 0 : -25)
        .scaleEffect(text.isEmpty ? 1: 0.8, anchor: .leading)
      TextField("", text: $text)
    }
    .padding(.top, 15)
    .animation(.default)
  }
}
