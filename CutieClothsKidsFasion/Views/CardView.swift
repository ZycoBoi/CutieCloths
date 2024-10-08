import SwiftUI

enum DayState {
    case love
    case cart
    case empty
}

struct Card: Identifiable {
    let id = UUID()
    let day: String
}

struct CardView: View {
    var card: Card
    var onRemove: () -> Void
    var cardAlpha: Double = 1.0
    
    @State private var translation: CGSize = .zero
    @State private var motionOffset: Double = 0.0
    @State private var motionScale: Double = 0.0
    @State private var lastCardState: DayState = .empty
    
    private func getIconName(state: DayState) -> String {
        switch state {
            case .love:     return "heart"
            case .cart:     return "cart"
            default:        return "Empty"
        }
    }
    
    private func setCardState(offset: CGFloat) -> DayState {
        if offset <= CardViewConsts.poopTriggerZone   { return .cart }
        if offset >= CardViewConsts.loveTriggerZone   { return .love }
        return .empty
    }
    
    private func remap(value: Double, fromMin: Double, fromMax: Double, toMin: Double, toMax: Double) -> Double {
        let proportion = (value - fromMin) / (fromMax - fromMin)
        return proportion * (toMax - toMin) + toMin
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                VStack {
                    Spacer()
                    Image(getIconName(state: self.lastCardState))
                        .frame(width: CardViewConsts.iconSize.width, height: CardViewConsts.iconSize.height)
                        .opacity(self.motionScale)
                        .scaleEffect(CGFloat(self.motionScale))
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                
                Image(card.day)
                               .resizable()
                               .scaledToFill()
                    .kerning(CardViewConsts.labelTextKerning)
                    .foregroundColor(Color(.systemGray2))
            }
            .frame(width: geometry.size.width, height: geometry.size.width * CardViewConsts.cardRatio)
            .background(Color.white)
            .opacity(cardAlpha)
            .cornerRadius(CardViewConsts.cardCornerRadius)
            .shadow(
                color: Color(.systemGray3),
                radius: CardViewConsts.cardShadowBlur,
                x: 0,
                y: CardViewConsts.cardShadowOffset
            )
            .rotationEffect(
                .degrees(Double(self.translation.width / geometry.size.width * CardViewConsts.cardRotLimit)),
                anchor: .bottom
            )
            .offset(x: self.translation.width, y: self.translation.height)
            .animation(.interactiveSpring(
                        response: CardViewConsts.springResponse,
                        blendDuration: CardViewConsts.springBlendDur), value: translation)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.translation = gesture.translation
                        self.motionOffset = Double(gesture.translation.width / geometry.size.width)
                        self.motionScale = remap(
                            value: self.motionOffset,
                            fromMin: CardViewConsts.motionRemapFromMin,
                            fromMax: CardViewConsts.motionRemapFromMax,
                            toMin: CardViewConsts.motionRemapToMin,
                            toMax: CardViewConsts.motionRemapToMax
                        )
                        self.lastCardState = setCardState(offset: gesture.translation.width)
                    }
                    .onEnded { gesture in
                        if abs(gesture.translation.width) > geometry.size.width * 0.5 {
                            onRemove() // Remove the card when it's swiped enough
                        } else {
                            withAnimation(.interactiveSpring(
                                response: CardViewConsts.springResponse,
                                blendDuration: CardViewConsts.springBlendDur)) {
                                    self.translation = .zero
                                    self.motionScale = 0.0
                                }
                        }
                    }
            )
        }
    }
}

private struct CardViewConsts {
    static let cardRotLimit: CGFloat = 20.0
    static let poopTriggerZone: CGFloat = -0.1
    static let loveTriggerZone: CGFloat = 0.1
    
    static let cardRatio: CGFloat = 1.333
    static let cardCornerRadius: CGFloat = 24.0
    static let cardShadowOffset: CGFloat = 16.0
    static let cardShadowBlur: CGFloat = 16.0
    
    static let labelTextSize: CGFloat = 24.0
    static let labelTextKerning: CGFloat = 6.0
    
    static let motionRemapFromMin: Double = 0.0
    static let motionRemapFromMax: Double = 0.25
    static let motionRemapToMin: Double = 0.0
    static let motionRemapToMax: Double = 1.0
    
    static let springResponse: Double = 0.5
    static let springBlendDur: Double = 0.3
    
    static let iconSize: CGSize = CGSize(width: 96.0, height: 96.0)
}

struct CardStackView: View {
    
    @State private var cards: [Card] = [
        Card(day: "product2"),
        Card(day: "product3"),
        Card(day: "product1"),
        Card(day: "product5"),
        Card(day: "product6"),
    ]
    
    var body: some View {
        ZStack {
            ForEach(cards) { card in
                CardView(card: card, onRemove: {
                    removeCard(card)
                })
                .padding()
                .offset(y: CGFloat(cards.firstIndex(where: { $0.id == card.id })!) * 10)
            }
        }
    }
    
    private func removeCard(_ card: Card) {
        withAnimation {
            cards.removeAll { $0.id == card.id }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackView()
            .background(Color(.systemRed))
            .edgesIgnoringSafeArea(.all)
    }
}
