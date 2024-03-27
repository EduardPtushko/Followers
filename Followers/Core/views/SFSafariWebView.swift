//
//  SFSafariWebView.swift
//  Followers
//
//  Created by Eduard Ptushko on 26.02.2024.
//

import SafariServices
import SwiftUI

struct SFSafariWebView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context _: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }

    func updateUIViewController(_: SFSafariViewController, context _: Context) {}
}
