import SwiftUI

struct HomePageView: View {
    @State private var currentIndex = 0
    @State private var timer: Timer?
    private let numberOfImages = 4
    let categories = ["Beauty", "Womens", "Kids", "Mens", "T-Shirts"]
    @State private var favoritedImages = Array(repeating: false, count: 6)
    @Binding var isTabBarVisible: Bool
    
    // Sample products
    @State private var products = [
        Product(imageName: "product1", name: "Smoko Cup", price: "$20", description: "17 oz handmade I love you MOM cup, Mint Pink White Speckled mug with message, Mother's day cup, A mug for mum.", productname: "Modie Models"),
        Product(imageName: "product2", name: "Stylish T-Shirt", price: "$25", description: "Comfortable cotton T-shirt for everyday wear.", productname: "Modie Models"),
        Product(imageName: "product3", name: "Smoko Cup", price: "$20", description: "17 oz handmade I love you MOM cup, Mint Pink White Speckled mug with message, Mother's day cup, A mug for mum.", productname: "Modie Models"),
        Product(imageName: "product4", name: "Stylish T-Shirt", price: "$25", description: "Comfortable cotton T-shirt for everyday wear.", productname: "Modie Models"),
        Product(imageName: "product5", name: "Smoko Cup", price: "$20", description: "17 oz handmade I love you MOM cup, Mint Pink White Speckled mug with message, Mother's day cup, A mug for mum.", productname: "Modie Models"),
        Product(imageName: "product6", name: "Stylish T-Shirt", price: "$25", description: "Comfortable cotton T-shirt for everyday wear.", productname: "Modie Models")
        ]
    
    var body: some View {
        NavigationView {
            VStack {
                TopView(isTabBarVisible: $isTabBarVisible)
                    .padding(.horizontal)
                    .padding(.bottom)
                
                // Top Section
                HStack {
                    TextField("Search", text: .constant(""))
                        .padding(.leading, 20)
                        .frame(height: 40)
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                    
                    Spacer()
                    
                    Button(action: {
                        // Notification action
                    }) {
                        Image(systemName: "bell")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color(.systemPink))
                    }
                    .padding(.trailing, 20)
                }
                .padding(.horizontal, 20)
                
                ScrollView(showsIndicators: false) {
                    // Carousel
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: -48) {
                                ForEach(0..<numberOfImages, id: \.self) { index in
                                    GeometryReader { geometry in
                                        Image("adpkg\(index + 1)")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.main.bounds.width * 0.8, height: 40)
                                            .cornerRadius(8)
                                            .scaleEffect(x: scaleValue(geometry: geometry), y: scaleValue(geometry: geometry))
                                            .animation(.easeInOut, value: scaleValue(geometry: geometry))
                                    }
                                    .frame(width: UIScreen.main.bounds.width * 0.8, height: 40)
                                    .id(index) // Assign a unique id to each item for scrolling
                                } // Assign a unique id to each item for scrolling
                                
                            }
                            .padding()
                        }
                        .onAppear {
                            startAutoScroll(proxy: proxy)
                        }
                        .onDisappear {
                            stopAutoScroll()
                        }
                    }
                    
                    // Categories
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(0..<categories.count, id: \.self) { index in
                                VStack {
                                    Image("category\(index + 1)")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                    Text(categories[index])
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding()
                    }
                    
                    
                    // New Collections
                    VStack(alignment: .leading) {
                        HStack {
                            Text("New collections")
                                .font(.headline)
                                .foregroundColor(Color(.systemGray))
                            
                            Spacer()
                            
                            Button(action: {
                                // Show all action
                            }) {
                                Text("show all")
                                    .foregroundColor(Color(.systemPink))
                                    .font(.subheadline)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                                ForEach(products) { product in
                                    NavigationLink(destination: DetailPage(product: product, isTabBarVisible: $isTabBarVisible)) {
                                        ZStack(alignment: .bottom) {
                                            Image(product.imageName)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 180, height: 255)
                                                .cornerRadius(10)
                                                .overlay(
                                                    HStack {
                                                        Spacer()
                                                        Button(action: {
                                                            withAnimation {
                                                                // Toggle the favorited state for the specific image
                                                                if let index = products.firstIndex(where: { $0.id == product.id }) {
                                                                    favoritedImages[index].toggle()
                                                                }
                                                            }
                                                        }) {
                                                            Image(systemName: favoritedImages[products.firstIndex(of: product)!] ? "heart.fill" : "heart")
                                                                .resizable()
                                                                .frame(width: favoritedImages[products.firstIndex(of: product)!] ? 18 : 13, height: favoritedImages[products.firstIndex(of: product)!] ? 18 : 13)
                                                                .foregroundColor(favoritedImages[products.firstIndex(of: product)!] ? .pink : .gray)
                                                                .shadow(color: favoritedImages[products.firstIndex(of: product)!] ? Color(.systemPink) : .gray, radius: 5, x: 1, y: 3)
                                                        }
                                                        .padding([.top, .trailing], 10)
                                                    },
                                                    alignment: .topTrailing
                                                )
                                            
                                            VStack {
                                                Text(product.name)
                                                    .font(.headline)
                                                    .foregroundColor(Color(.black).opacity(0.6))
                                                    .frame(maxWidth: .infinity)
                                                
                                                Text(product.price)
                                                    .font(.subheadline)
                                                    .foregroundColor(Color(.black).opacity(0.6))
                                                    .frame(maxWidth: .infinity)
                                                    .padding(.bottom)
                                            }
                                            .padding(.horizontal)
                                            .background(
                                                LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.3), Color.white.opacity(0.6), Color.white.opacity(0.9), Color.white]),
                                                               startPoint: .top,
                                                               endPoint: .bottom)
                                                
                                                .blur(radius: 2)
                                                .padding(.bottom ,  -4)
                                            )
                                        }
                                    }
                                }
                            }
                        }
//                        .padding(.bottom, 10)
                    }
                    
                    Spacer()
                }
                // Bottom Tab Bar
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
    }
    
    // Functions for carousel
    private func scaleValue(geometry: GeometryProxy) -> CGFloat {
        let midX = geometry.frame(in: .global).midX
        let screenWidth = UIScreen.main.bounds.width
        let scale = max(0.7, 1 - abs(midX - screenWidth / 2) / screenWidth)
        return scale
    }
    
    private func startAutoScroll(proxy: ScrollViewProxy) {
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % numberOfImages
                proxy.scrollTo(currentIndex, anchor: .center)
            }
        }
    }
    
    private func stopAutoScroll() {
        timer?.invalidate()
    }
}



struct TopView: View {
    
    var imageURL = URL(string: "https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/195640809/original/9dffc3c65057d916ecf667f5bc81b21872d35d1e/draw-you-a-cute-anime-girl.png")
    @State private var xOffset: CGFloat = 1
    @State private var yOffset: CGFloat = 3
    @State private var angle: CGFloat = 0
    @Binding var isTabBarVisible: Bool
    
    var body: some View {
        
        HStack {
            // Replace with your custom hamburger menu icon
            Image(systemName: "line.horizontal.3")
                .foregroundColor(Color(.systemGray2))
                .font(.title)
            Spacer()
            
            // Replace with your logo or text
            Image("bannerImg")
                .resizable()
                .scaledToFill()
                .frame(height: 60)
            Spacer()
            
            
            NavigationLink(destination: ProfileView(isTabBarVisible: $isTabBarVisible)) {
                AsyncImage(url: imageURL){ image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .cornerRadius(50)
                        .shadow(color: Color(.systemPink), radius: 6, x: xOffset, y: yOffset)
                        .scaleEffect(1.1)
                        .onAppear {
                            startAnimatingShadow()
                        }

                } placeholder: {
                    ProgressView()
                }
            } .onAppear {
                isTabBarVisible = true // Show tab bar when HomePageView is visible
            }
            
            // Replace with your custom profile image
            
        }.padding(.horizontal)
    }
    
    func startAnimatingShadow() {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                withAnimation(.linear(duration: 0.1)) {
                    // Increment the angle to simulate clockwise rotation
                    angle += 10
                    
                    // Convert angle to radians for trigonometric functions
                    let radians = angle * .pi / 180
                    
                    // Calculate new x and y offsets using trigonometry
                    xOffset = 5 * cos(radians) // Adjust the multiplier for a larger or smaller circular path
                    yOffset = 5 * sin(radians) // Adjust the multiplier for a larger or smaller circular path
                }        }
    }


}



