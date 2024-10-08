
import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var imageURL = URL(string: "https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/195640809/original/9dffc3c65057d916ecf667f5bc81b21872d35d1e/draw-you-a-cute-anime-girl.png")
    @Binding var isTabBarVisible: Bool
    @State private var slideOffset: CGFloat = UIScreen.main.bounds.height
    @State private var topslideOffset: CGFloat = -UIScreen.main.bounds.height
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    // Header Image
                    ZStack(alignment: .topLeading) {
                        AsyncImage(url: imageURL) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: 350)
                                .shadow(color: Color(.systemPink), radius: 5, x: 1, y: 3)
                                
                        } placeholder: {
                            ProgressView()
                                .frame(width: geometry.size.width, height: 350)
                        }
                        Button(action: {
                            isTabBarVisible = true
                            print("button pressed")
                            mode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left.circle.fill")
                                .resizable()
                                   .frame(width: 35, height: 35)
                                .foregroundColor(.white)
                                .shadow(color: Color(.systemGray2), radius: 5, x: 2, y: 2)
                        }
                        .padding(.top,30)
                        .padding(.leading,20)
                        .onAppear {
                                       isTabBarVisible = false // Hide tab bar when ProfileView appears
                                   }
                        
                    }.offset(y: topslideOffset)
                        .animation(.easeInOut(duration: 1.5), value: topslideOffset)
                    .onAppear {
                        withAnimation {
                            topslideOffset = 0 // Slide image from top to center
                        }
                    }
                    // Profile Details and Information
                    ScrollView(.vertical, showsIndicators: false) {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.gray).opacity(0.5)
                            .frame(width: 150, height: 5)
                            .padding()
                        VStack(alignment: .leading){
                            // Profile Image and Info
                            HStack {
                                AsyncImage(url: imageURL) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(50)
                                        .shadow(color: Color(.systemPink), radius: 5, x: 1, y: 3)
                                        .padding(.leading)
                                } placeholder: {
                                    ProgressView()
                                        .padding(25)
                                        .background(
                                            Circle()
                                                .stroke(lineWidth: 2)
                                                .foregroundColor(Color(.systemGray3))
                                                .background(Color(.clear))
                                        )
                                        .padding(.leading, 20)
                                }
                                VStack(alignment: .leading) {
                                    Text("Bunny Rizzo")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("bunny_rizzo")
                                        .foregroundColor(Color(.systemGray3))
                                        .fontWeight(.medium)
                                }.padding(.leading)
                            }
                            .padding(.top)
                            
                            // User Info
                            HStack{
                                UserInfoTag(text: "🍬 Apr 21")
                                UserInfoTag(text: "❤️‍🔥 24")
                                UserInfoTag(text: "Taurus")
                                Spacer()
                            }.padding()
                                .padding(.top, 4)
                            
                            // Action Buttons
                            HStack{
                                ActionButton(icon: "camera.fill") { /* Camera action */ }
                                ActionButton(icon: "message.fill") { /* Chat action */ }
                                NavigationLink(destination: ContentView()) {
                                    ActionButton(icon: "phone.fill") { /* Call action */ }
                                }
                                ActionButton(icon: "video.fill") { /* Video call action */ }
                            }
                            .padding()
                            
                            // Information Sections
                            VStack(alignment: .leading, spacing: 10) {
                                SectionView(icon: "lock.fill", title: "Privacy" , title1: "Friendships are Private", description: "Screenshotting friendship profiles will send a notification - just like Snaps.")
                                
                                NavigationLink(destination: WallpaperView()) {
                                    SectionView(icon: "photo.fill", title: "Our Chat", title1: "Wallpaper", description: "Both you and Jennifer Rizzo will see the wallpaper")
                                }
                                
                                NavigationLink(destination: ShareLocationView()) {
                                    SectionView(icon: "location.fill", title: "Chat Map", title1: "Share My Live Location", description: "", isNew: true)
                                }
                                
                                SectionView(icon: "folder.fill", title: "Saved in Chat", title1: "", description: "Photos and videos saved in Chat will appear here.")
                            }
                            .padding()
                        }
                    }.onAppear {
                        withAnimation {
                            slideOffset = 0
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(40)
                    .offset(y: slideOffset)
                    .animation(.easeInOut(duration: 1.5), value: slideOffset)
                    .offset(y: -10) // Adjust offset to position at the bottom of the image
                }
                .edgesIgnoringSafeArea(.top)
                .navigationBarHidden(true)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
    }
    
  
        }


struct UserInfoTag: View {
    let text: String
    
    var body: some View {
        HStack(spacing: 15) {
            Text(text)
                .font(.caption)
                .fontWeight(.regular)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundColor(Color.white)
                        .opacity(0.2)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .strokeBorder(Color(.systemGray6), lineWidth: 2)
                )
                .cornerRadius(50)
                .shadow(color: Color(.systemGray4), radius: 2, x: 0, y: 2)
        }
    }
}

struct ActionButton: View {
    let icon: String
    let action: () -> Void

    var body: some View {
        HStack(spacing: 20){
            Button(action: action) {
                Image(systemName: icon)
                    .foregroundColor(Color(.systemPink))
                    .padding(.horizontal, 10)
                    .padding()
                     .background(Color.white)
                     .cornerRadius(20)
            }.shadow(radius: 2, x:2, y:0)

        }
    
    }
}

struct SectionView: View {
    let icon: String
    let title: String
    let title1: String
    let description: String
    var isNew: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(Color(.lightGray))
            HStack{
                Image(systemName: icon)
                    .font(.headline)
                    .foregroundColor(Color(.systemPink))
                    .padding(.trailing)

                VStack(alignment: .leading) {
                    Text(title1)
                        .font(.headline)
                        .foregroundColor(Color(.black).opacity(0.5))
                    Text(description)
                        .frame(alignment: .leading)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        
                }

                if isNew {
                    Spacer()
                    Text("NEW")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .padding(.horizontal, 20)
                        .background(Color(.systemPink))
                        .cornerRadius(20)
                       
                }
            }.frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.white)
                        .opacity(0.2)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color(.systemGray6), lineWidth: 2)
                )
                .cornerRadius(10)
                .shadow(color: Color(.systemGray4), radius: 2, x: 0, y: 2)
        }
       
    }
}

// Placeholder views for navigation links
struct WallpaperView: View {
    var body: some View {
        Text("Wallpaper View")
    }
}

struct ShareLocationView: View {
    var body: some View {
        Text("Share My Live Location View")
    }
}


