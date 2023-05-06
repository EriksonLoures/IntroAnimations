//
//  OnBoardingItem.swift
//  PagesAnimations
//
//  Created by Erik Loures on 05/05/23.
//

import SwiftUI
import Lottie

struct OnboardingItem: Identifiable, Equatable {
    var id: UUID = .init()
    var title: String
    var subTitle: String
    var lottieView: LottieAnimationView = .init()
//    For Play/Pause Lottie Animation
}
