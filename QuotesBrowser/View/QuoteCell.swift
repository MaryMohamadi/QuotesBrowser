//
//  QuoteCell.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 17.06.22.
//

import SwiftUI

struct QuoteCell: View {
    @Namespace var nameSpace
    var model: QuoteModel
    @Binding var searchText: String
    @Binding var isTagSelected: Bool
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Spacer()
                Text(model.body)
                    .frame(height: 100)
                Text(model.author)
                    .frame(height: 50)
            }
            HStack {
                TagsView(searchText: $searchText,
                         isTagSelected: $isTagSelected,
                         tags: model.tags)
            }
            
            .frame(height: 50)
            Spacer()
        }
        .padding()
        .background(Color(hex: model.color).matchedGeometryEffect(id: model.id,
                                                                  in: nameSpace))
        .cornerRadius(8)

    }
}

struct QuoteCell_Previews: PreviewProvider {
    static var previews: some View {
        QuoteCell(model: QuoteModel.addData,
                  searchText: .constant("Funny"),
                  isTagSelected: .constant(false))
    }
}
