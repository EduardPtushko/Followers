//
//  GFTextField.swift
//  Followers
//
//  Created by Eduard Ptushko on 13.01.2024.
//

import SwiftUI

struct GFTextField: View {
    @Binding var text: String

    var body: some View {
        TextField("Enter a username", text: $text)
            .font(.title2)
            .autocorrectionDisabled()
            .multilineTextAlignment(.center)
            .padding(8)
            .background(Color(UIColor.tertiarySystemBackground))
            .overlay (
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(UIColor.systemGray4), lineWidth: 2)
            )
    }
}

#Preview {
    @State var text: String = ""

    return  GFTextField(text: $text)
}
