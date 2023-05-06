//
//  OnboardingScreen.swift
//  PagesAnimations
//
//  Created by Erik Loures on 05/05/23.
//

import SwiftUI
import Lottie

struct OnboardingScreen: View {
//    MARK: OnBoarding Slides Model Data
    @State var onboardingItems: [OnboardingItem] = [
    
        .init(title: "Title 1",
    subTitle: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley.",
          lottieView: .init (name: "73838",bundle: .main)),
    
        .init(title: "Title 2",
    subTitle: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley.",
              lottieView: .init (name: "80680",bundle: .main)),
    
        .init(title: "Title 3",
    subTitle: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley.",
              lottieView: .init (name: "121104",bundle: .main))
]
//        MARK: Current Slide Index
    @State var currentIndex: Int = 0
    var body: some View {
        GeometryReader{
            let size = $0.size
            
            HStack(spacing: 0) {
                
                ForEach($onboardingItems) {$item in
                    let isLastSlide = (currentIndex == onboardingItems.count - 1)
                    VStack {
//                      MARK: Top Nav Bar
                        
                        HStack {
                            Button("Back") {
                                if currentIndex > 0 {
                                   currentIndex -= 1
                                    playAnimation()
                                
                                }
                            }
                            .opacity(currentIndex > 0 ? 1 : 0)
                            
                            Spacer(minLength: 0)
                            
                            Button("Skip") {
                                currentIndex = onboardingItems.count - 1
                                playAnimation()
                                
                            }
                            .opacity(isLastSlide ? 0 : 1)
                        }
                        .animation(.easeOut, value: currentIndex)
                        .tint(Color.blue)
                        .fontWeight(.bold)
                        
                        
                        
//                      MARK: Movable Slides
                        VStack(spacing: 15 ) {
                            let offset = -CGFloat(currentIndex) * size.width
//                        MARK: Resizable Lottie View
                            ResizableLottieView(onboardingItem: $item)
                                .frame(height: size.width)
                                .onAppear {
//    MARK: Intially Playing First Slide Animation
                                    if currentIndex == indexOf(item) {
                                        item.lottieView.play(toProgress: 0.7)
                                    }
                                }
                                .offset(x: offset)
                                .animation(.easeOut(duration: 0.5), value: currentIndex)
                            
                            Text(item.title)
                                .font(.title.bold())
                                .offset(x: offset)
                                .animation(.easeOut(duration: 0.5).delay(0.1), value: currentIndex)
                            Text(item.subTitle)
                                .font(.system(size:14))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal,15)
                                .foregroundColor(.gray)
                                .offset(x: offset)
                                .animation(.easeOut(duration: 0.5), value: currentIndex)
                        }
                        Spacer(minLength: 0)
                        
//                         MARK: Next / Login Button
                        VStack(spacing: 15) {
                            Text(isLastSlide ? "Login" : "Next")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical,isLastSlide ? 13 : 12)
                                .frame(maxWidth: .infinity)
                                .background {
                                    Capsule()
                                        .fill(Color("Blue"))
                                }
                                .padding(.horizontal,isLastSlide ? 30 : 100 )
                                .onTapGesture {
//   MARK: Updating to Next Index
                                    if currentIndex < onboardingItems.count - 1 {
//   MARK: Pausing Previous Animation
                let currentProgress = onboardingItems[currentIndex].lottieView.currentProgress
                                        onboardingItems[currentIndex].lottieView.currentProgress = (currentProgress == 0 ? 0.7 : currentProgress)
               currentIndex += 1
//   MARK: Playing Next Animation from Start
             playAnimation()
                                        
                                }
                            }
                        HStack {
                            Text("Terms of Service")
                               
                            Text("Privacy Policy")
                        }
                        .font(.caption)
                        .underline(true, color: .primary)
                        .offset(y: 5)
                    }
                    
                }
                    .animation(.easeOut, value: isLastSlide)
                .padding(15 )
                .frame(width: size.width, height: size.height)
            }
        }
            .frame(width: size.width * CGFloat(onboardingItems.count),alignment: .leading)
        }
    }
    
    func playAnimation() {
        onboardingItems[currentIndex].lottieView.currentProgress = 0
        onboardingItems[currentIndex].lottieView.play(toProgress: 0.7)
    }
    
    //   MARK: Retreving Index of the Item in the Array
    func indexOf(_ item: OnboardingItem)->Int {
        
    if let index = onboardingItems.firstIndex(of: item) {
        return index
      }
        return 0
    }
}




struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: Resizable Lottie View Without Background

struct ResizableLottieView: UIViewRepresentable {
    @Binding var onboardingItem: OnboardingItem
    
    func makeUIView(context: Context) ->  UIView {
        let view = UIView()
        view.backgroundColor = .clear
        setupLottieView(view)
        return view
        
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    func setupLottieView(_ to: UIView) {
        let lottieView = onboardingItem.lottieView
        lottieView.backgroundColor = .clear
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        
//    MARK: Applying Constraints
        let constraints = [
            lottieView.widthAnchor.constraint(equalTo: to.widthAnchor),
            lottieView.heightAnchor.constraint(equalTo: to.heightAnchor),
        ]
        to.addSubview(lottieView)
        to.addConstraints(constraints)
         
    }
}
