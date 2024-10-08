import SwiftUI

struct TabBarView: View {
    @Binding var selectedTab: String

    var body: some View {
        HStack {
            ForEach(["house", "magnifyingglass", "cart", "heart", "gear"], id: \.self) { icon in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedTab = icon
                    }
                }) {
                    VStack {
                        Image(systemName: icon)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(selectedTab == icon ? Color(.systemPink) : Color(.systemGray))
                            .scaleEffect(selectedTab == icon ? 1.5 : 1.0) // Scale effect for selected tab
//                            .animation(.easeInOut, value: selectedTab) // Add animation to the scale effect
                    }
                    .frame(maxWidth: .infinity)
                    
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(.horizontal)
    }
}
