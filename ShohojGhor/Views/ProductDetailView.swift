import SwiftUI

struct ProductDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedImageIndex = 0
    @State private var quantity = 1
    
    let images = ["photo", "photo", "photo"] // Replace with actual product images
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Image Carousel
                TabView(selection: $selectedImageIndex) {
                    ForEach(0..<images.count, id: \.self) { index in
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .aspectRatio(1, contentMode: .fit)
                            .overlay(
                                Image(systemName: images[index])
                                    .foregroundColor(ColorTheme.secondaryText)
                            )
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: 300)
                
                VStack(alignment: .leading, spacing: 16) {
                    // Product Info
                    Text("Modern Chair")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("$199")
                        .font(.title3)
                        .foregroundColor(ColorTheme.navigation)
                    
                    // Quantity Selector
                    HStack {
                        Text("Quantity")
                        Spacer()
                        HStack {
                            Button(action: { if quantity > 1 { quantity -= 1 } }) {
                                Image(systemName: "minus.circle.fill")
                            }
                            Text("\(quantity)")
                                .frame(width: 40)
                            Button(action: { quantity += 1 }) {
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                        .foregroundColor(ColorTheme.navigation)
                    }
                    
                    // Description
                    Text("Description")
                        .font(.headline)
                    Text("A modern chair with elegant design and comfortable seating. Perfect for any contemporary home setting.")
                        .foregroundColor(ColorTheme.secondaryText)
                    
                    // Add to Cart Button
                    Button(action: {
                        // Add to cart logic
                    }) {
                        Text("Add to Cart")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(ColorTheme.navigation)
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(ColorTheme.background)
    }
} 