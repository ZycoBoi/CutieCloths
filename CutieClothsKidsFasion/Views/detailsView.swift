import SwiftUI

struct DetailPage: View {
    var product: Product
    @Binding var isTabBarVisible: Bool
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var topslideOffset: CGFloat = -UIScreen.main.bounds.height
    @State private var bottomslideOffset: CGFloat = UIScreen.main.bounds.height
    @State private var leadingslideOffset: CGFloat = -UIScreen.main.bounds.width
    @State private var trailingslideOffset: CGFloat = UIScreen.main.bounds.width
    @State private var currentIndex: Int = 0
    private let numberOfImages = 3 // Assume you have 3 images for the product
    @State private var favoritedImages = Bool()
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                Image(product.imageName)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 500)
                    .cornerRadius(40)
                    .shadow(color: Color(.systemGray2), radius: 5, x: 2, y: 2)
                    .offset(y: topslideOffset)
                    .animation(.easeInOut(duration: 1.5), value: topslideOffset)
                HStack {
                    Button(action: {
                        mode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white)
                            .shadow(color: Color(.systemGray2), radius: 5, x: 2, y: 2)
                    }
                    Spacer()
                    Button(action: {
                        withAnimation {
                            favoritedImages.toggle()
                        }
                    }) {
                        Image(systemName: favoritedImages ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: favoritedImages ? 30 : 22, height: favoritedImages ? 30 : 22)
                            .foregroundColor(favoritedImages ? .pink : .white)
                            .shadow(color: favoritedImages ? Color(.systemPink) : .gray, radius: 5, x: 1, y: 3)
                    }
                }
                
                .padding(.top, 40)
                .padding(.horizontal, 25)
            }
            .edgesIgnoringSafeArea(.top)
            
            // Page Indicator
            HStack {
                ForEach(0..<numberOfImages, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color(.systemPink) : Color(.gray))
                        .frame(width: index == currentIndex ? 13 : 8, height: index == currentIndex ? 13 : 8)
                        .animation(.easeInOut, value: currentIndex)
                }
            }.offset(x: leadingslideOffset)
                .animation(.easeInOut(duration: 1.5), value: leadingslideOffset)
            .padding(.top, -25)
            .padding(.bottom)
            .frame(maxWidth: .infinity)
            .onAppear {
                isTabBarVisible = false
                withAnimation {
                    topslideOffset = 0
                    leadingslideOffset = 0
                }
                startTimer()
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(product.name)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Text(product.price)
                        .font(.title2)
                        .foregroundColor(.gray)
                }.offset(y: trailingslideOffset)
                    .animation(.easeInOut(duration: 1.5), value: trailingslideOffset)
                    .padding(.bottom, 2)
                
                Text(product.productname)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.systemGray2))
                    .offset(x: leadingslideOffset)
                    .animation(.easeInOut(duration: 1.5), value: leadingslideOffset)
                    .padding(.bottom, 30)

                Text(product.description)
                    .font(.callout)
                    .foregroundColor(Color(.systemGray3))
                    .offset(x: bottomslideOffset)
                    .animation(.easeInOut(duration: 1.5), value: bottomslideOffset)

                Spacer()

                HStack {
                    PinkButton(title: "Buy Now") {
                        print("Buy Now Pressed")
                    }.offset(y: trailingslideOffset)
                        .animation(.easeInOut(duration: 1.5), value: trailingslideOffset)
                    Spacer()
                    cartButton(title: "cart.fill") {
                        print("Cart Pressed")
                    }
                    .offset(x: leadingslideOffset)
                    .animation(.easeInOut(duration: 1.5), value: leadingslideOffset)
                }
                .padding([.horizontal, .bottom], 20)
            } .onAppear {
               
                withAnimation {
                    topslideOffset = 0
                    leadingslideOffset = 0
                    trailingslideOffset = 0
                    bottomslideOffset = 0
                }
              
            }
            .padding(.horizontal, 20)
        }.navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
    }

    // Timer to automatically change pages (optional)
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % numberOfImages
            }
        }
    }
}
