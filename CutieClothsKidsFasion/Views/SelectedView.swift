import SwiftUI

struct selectedView: View {
    @State private var isPanelVisible = false
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                ZStack {
                    if isPanelVisible {
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 500)
                            .cornerRadius(30)
                            .shadow(radius: 10)
                            .transition(.move(edge: .bottom))
                            .animation(.easeInOut(duration: 0.4), value: isPanelVisible)
                    }
                    
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    isPanelVisible.toggle()
                                }
                            }) {
                                Image(systemName: isPanelVisible ? "multiply" : "chevron.down" )
                                    .foregroundColor(.blue)
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                            }
                            .padding(.trailing, 20)
                            .padding(.top, 20)
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 20) {
                            ForEach(0..<3) { index in
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.blue.opacity(0.7))
                                    .frame(height: 100)
                                    .scaleEffect(isPanelVisible ? 1 : 0.9)
                                    .opacity(isPanelVisible ? 1 : 0)
                                    .animation(.easeInOut.delay(Double(index) * 0.2), value: isPanelVisible)
                            }
                        }
                        .padding(.horizontal, 30)
                        
                        Spacer()
                    }
                }
                .frame(height: isPanelVisible ? 500 : 0)
                .animation(.easeInOut(duration: 0.5), value: isPanelVisible)
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

