//
//  BookRowView.swift
//  BookShelf
//
//  Created by Peter Friese on 30.03.21.
//

import SwiftUI

struct BookRowView: View {
  var book: Book
  
  fileprivate func detailsLabel(_ text: String) -> Text {
    return Text(text)
      .font(.subheadline)
  }
  
  var titleLabel: some View {
    Text(book.title)
      .font(.headline)
  }
  
  var body: some View {
    HStack(alignment: .top) {
      Image(book.mediumCoverImageName)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(height: 90)
      VStack(alignment: .leading) {
        titleLabel
        detailsLabel("by \(book.author)")
        detailsLabel("\(book.pages) pages")
      }
      Spacer()
    }
  }
}

struct BookRowView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      BookRowView(book: Book.samples[0])
        .previewLayout(.sizeThatFits)
      BookRowView(book: Book.samples[0])
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
    }
  }
}
