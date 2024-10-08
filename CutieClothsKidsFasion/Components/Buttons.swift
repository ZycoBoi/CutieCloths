//
//  Buttons.swift
//  CutieClothsKidsFasion
//
//  Created by sankar on 08/08/24.
//

import SwiftUI

struct PinkButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .padding()
                .foregroundColor(Color.white)
                .font(.subheadline)
                .padding()
                .padding(.horizontal, 30)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color(.systemPink))
                        .opacity(0.5)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(Color(.systemGray5), lineWidth: 2)
                )
                .cornerRadius(30)
        } .shadow(color: Color(.systemGray3), radius: 5, x: 2, y: 2)
    }
}


struct cartButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
           Image(systemName: title)
                .padding()
                .foregroundColor(Color(.systemPink))
                .font(.title3)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color(.systemGray6))
                        .opacity(0.2)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(Color(.systemGray6), lineWidth: 2)
                )
                .cornerRadius(30)
        } .shadow(color: Color(.systemGray3), radius: 5, x: 2, y: 2)
    }
}
