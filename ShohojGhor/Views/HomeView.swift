import SwiftUI

struct HomeView: View {
    @State private var selectedCategory = 0
    @State private var isAnimating = false
    
    let categories = ["All", "Popular", "For You", "New"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Categories
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(0..<categories.count) { index in
                                CategoryButton(
                                    title: categories[index],
                                    isSelected: selectedCategory == index
                                ) {
                                    withAnimation {
                                        selectedCategory = index
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Featured Items
                    FeaturedItemsView()
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : 50)
                    
                    // Popular Items Grid
                    PopularItemsGridView()
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : 30)
                }
            }
            .navigationTitle("Shohoj Ghor")
            .navigationBarItems(
                trailing: Button(action: {
                    // Show sidebar
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(ColorTheme.text)
                }
            )
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                isAnimating = true
            }
        }
    }
}

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.medium)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? ColorTheme.navigation : ColorTheme.primary)
                )
                .foregroundColor(isSelected ? .white : ColorTheme.text)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
} 