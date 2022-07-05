//
//  QuotesDetailView.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 17.06.22.
//

import SwiftUI

struct QuotesDetailView: View {
    @Namespace var nameSpace
    @Binding var selectedItem: QuoteModel?
    @Binding var searchText: String
    var body: some View {
        VStack{
            HStack {
                Button(action: {
                    withAnimation { selectedItem = nil }
                },
                       label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 42, height: 42)
                        .foregroundColor(.black)
                }
                )
                Spacer()
            }
            .frame(height: 150)
            
            VStack {
                Spacer()
                Text(selectedItem?.body ?? "")
                    .padding()
                Text(selectedItem?.author ?? "")
                    .padding()
                TagsView(searchText: $searchText,
                         isTagSelected: .constant(false),
                         tags: selectedItem?.tags ?? [])
                Spacer()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: selectedItem?.color ?? "#C7FFC7").matchedGeometryEffect(id: selectedItem?.id, in: nameSpace))
    }
}

struct QuotesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QuotesDetailView(selectedItem: .constant(QuoteModel.addData),
                         searchText: .constant("Funny"))
    }
}
