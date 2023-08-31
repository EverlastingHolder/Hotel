import SwiftUI

extension View {
    func backgroundCapsule() -> some View {
        self
            .padding(.horizontal, 16)
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 5))
    }
    
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}
