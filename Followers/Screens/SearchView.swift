//
//  SearchView.swift
//  Followers
//
//  Created by Eduard Ptushko on 13.01.2024.
//

import SwiftUI

struct SearchView: View {
    @State private var text = ""
    @FocusState private var focusedField: Bool
    @State private var path = NavigationPath()
    @State private var showingAlert = false

    var isUsernameEntered: Bool { !text.isEmpty }

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack {
                    Images.ghLogo
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding(.top, 80)

                    CustomTextField(text: $text)
                        .frame(height: 50)
                        .padding(.horizontal, 50)
                        .padding(.top, 48)
                        .focused($focusedField)
                        .submitLabel(.go)
                        .tint(.black)
                        .onSubmit {
                            path.append(text)
                            text = ""
                        }

                    Spacer()

                    CustomButton(backgroundColor: .green, title: "Get Followers") {
                        guard isUsernameEntered else {
                            withAnimation {
                                showingAlert = true
                            }
                            return
                        }
                        path.append(text)
                        text = ""
                    }
                    .frame(height: 50)
                    .padding(.horizontal, 50)
                    .padding(.bottom, 50)
                }
                .navigationDestination(for: String.self) { text in
                    FollowerListView(username: text)
                        .navigationTitle(text)
                        .navigationBarTitleDisplayMode(.large)
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .contentShape(Rectangle())
                .onTapGesture {
                    focusedField = false
                }
            }
            .navigationTitle("Search")
            .customAlert("Empty Username", isPresented: $showingAlert, actionText: "Ok") {
                showingAlert = false
            } message: {
                BodyLabel(title: "Please enter a username. We need to know who to look for.")
            }
        }
    }
}

#Preview {
    SearchView()
}
