import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0.5

    var body: some View {
        VStack {
            if isActive {
                MainContentView()
            } else {
                Image("aicenter") // Replace with your launch image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300) // Adjust size as needed
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeOut(duration: 1.0)) {
                            self.scale = 1.0
                            self.opacity = 1.0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}
