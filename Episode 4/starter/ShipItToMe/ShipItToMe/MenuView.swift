//
//  MenuView.swift
//  MenuView
//
//  Created by Peter Friese on 03.09.21.
//

import SwiftUI

struct MenuView: View {
  var body: some View {
    NavigationView {
      List {
        NavigationLink(destination: EmailValidationForm()) {
          Label("Email confirmation", systemImage: "rectangle.and.pencil.and.ellipsis")
        }
        NavigationLink(destination: ShippingForm()) {
          Label("Shipping form", systemImage: "shippingbox")
        }
      }
      .navigationTitle("Input validation")
    }
  }
}

struct MenuView_Previews: PreviewProvider {
  static var previews: some View {
    MenuView()
  }
}
