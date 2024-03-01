//
//  HomeView.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 29/02/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel:AuthViewModel
    var body: some View {
        Button("Sig Out"){
            viewModel.signOut()
        }
    }
}

#Preview {
    HomeView()
}
