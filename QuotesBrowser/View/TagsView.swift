//
//  TagsView.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 18.06.22.
//

import SwiftUI

struct TagsView: View {
    @Binding var searchText: String
    @Binding var isTagSelected: Bool
    var tags: [String]
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(tags, id: \.self) { tag in
                    HStack {
                        Image(systemName: "tag")
                            .resizable()
                            .frame(width: 12, height: 12)
                        Text(tag)
                            .font(Font.caption2)
                            .fixedSize()
                            .frame(height: 12)
                            
                    }

                    .onTapGesture {
                        isTagSelected = true
                        searchText = tag
                    }
                    .padding(6)
                    .background(Color.gray)
                    .cornerRadius(8)
                }
            }
        }
    }
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        TagsView(searchText: .constant("Funny"),
                 isTagSelected: .constant(false),
                 tags: ["Funny", "Medical"])
    }
}
