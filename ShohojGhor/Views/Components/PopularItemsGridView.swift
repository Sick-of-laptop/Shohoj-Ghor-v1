import SwiftUI

struct PopularItemsGridView: View {
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Popular")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(0..<6) { _ in
                    PopularItemCard()
                }
            }
            .padding(.horizontal)
        }
    }
}

struct PopularItemCard: View {
    var body: some View {
        NavigationLink(destination: ProductDetailView()) {
            VStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .aspectRatio(1, contentMode: .fit)
                    .cornerRadius(12)
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(ColorTheme.secondaryText)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Modern Chair")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(ColorTheme.text)
                    
                    Text("$199")
                        .font(.caption)
                        .foregroundColor(ColorTheme.navigation)
                }
                .padding(.vertical, 8)
            }
            .background(ColorTheme.primary)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
    }
} 