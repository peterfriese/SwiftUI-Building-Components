//
//  DemoView.swift
//  ShipItToMe
//
//  Created by Peter Friese on 28.07.22.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import SwiftUI
import FloatingLabelTextInputField

struct DemoView: View {
  @State var name: String = ""
  
  var body: some View {
    Form {
      TextInputField("First Name", text: $name)
      TextInputField("Last Name", text: $name)
      TextInputField("Mate", text: $name)
        .clearButtonHidden()
      
    }
  }
}

struct DemoView_Previews: PreviewProvider {
  static var previews: some View {
    DemoView()
  }
}
