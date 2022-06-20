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
          .clearButtonHidden(false)
        TextInputField("Post code", text: $shippingAddress.postcode)
        TextInputField("City", text: $shippingAddress.city)
        TextInputField("County", text: $shippingAddress.county)
        TextInputField("Country", text: $shippingAddress.country)
          .clearButtonHidden(false)
      }
      .clearButtonHidden(true)
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

struct ShippingForm_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ShippingForm()
    }
  }
}
