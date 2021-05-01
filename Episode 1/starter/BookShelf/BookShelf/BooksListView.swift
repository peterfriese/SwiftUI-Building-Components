//
//  ContentView.swift
//  BookShelf
//
//  Created by Peter Friese on 02/01/2021.
//

import SwiftUI

class BooksViewModel: ObservableObject {
  @Published var books: [Book] = Book.samples
}

struct BooksListView: View {
  @ObservedObject var booksViewModel: BooksViewModel
  
  var body: some View {
    List {
      ForEach(booksViewModel.books) { book in
        NavigationLink(destination: Text("\(book.title)")) {
          HStack(alignment: .top) {
            Image(book.mediumCoverImageName)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(height: 90)
            VStack(alignment: .leading) {
              Text(book.title)
                .font(.headline)
              Text("by \(book.author)")
                .font(.subheadline)
              Text("\(book.pages) pages")
                .font(.subheadline)
            }
            Spacer()
          }
        }
      }
    }
  }
}

struct BooksListView_Previews: PreviewProvider {
  static let booksViewModel = BooksViewModel()
  
  static var previews: some View {
    NavigationView {
      BooksListView(booksViewModel: booksViewModel)
        .navigationTitle("Books")
        .preferredColorScheme(.light)
    }
  }
}
