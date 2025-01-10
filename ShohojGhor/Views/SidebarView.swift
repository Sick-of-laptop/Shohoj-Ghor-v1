import SwiftUI

struct SidebarView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            // Semi-transparent background
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        isShowing = false
                    }
                }
            
            // Sidebar content
            HStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    HStack {
                        Text("Menu")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                isShowing = false
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(ColorTheme.secondaryText)
                                .font(.title2)
                        }
                    }
                    .padding()
                    
                    // Menu Items
                    VStack(spacing: 0) {
                        SidebarMenuItem(icon: "bag", title: "My Orders")
                        SidebarMenuItem(icon: "info.circle", title: "About")
                        SidebarMenuItem(icon: "questionmark.circle", title: "Help")
                        SidebarMenuItem(icon: "arrow.right.square", title: "Logout")
                    }
                    
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width * 0.75)
                .background(ColorTheme.primary)
                .edgesIgnoringSafeArea(.vertical)
            }
        }
    }
}

struct SidebarMenuItem: View {
    let icon: String
    let title: String
    
    var body: some View {
        Button(action: {
            // Handle menu item tap
        }) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .frame(width: 24)
                Text(title)
                Spacer()
            }
            .foregroundColor(ColorTheme.text)
            .padding()
        }
        .background(ColorTheme.primary)
    }
} 