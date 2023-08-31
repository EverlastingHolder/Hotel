import SwiftUI

struct APIResultView<T: Hashable, Content: View>: View {
    @Binding var result: APIResult<T>
    
    let content: (_ item: T) -> Content
    let refreshable: () async -> Void
    
    init(
        result: Binding<APIResult<T>>,
        @ViewBuilder content: @escaping (_ item: T) -> Content,
        refreshable: @escaping () async -> Void = {}
    ) {
        self._result = result
        self.content = content
        self.refreshable = refreshable
    }
    
    var body: some View {
        VStack {
            switch result {
            case .success(let contentView):
                content(contentView)
            case .loading:
                ProgressView()
            case .error:
                ScrollView {
                    VStack {
                        Text("Произошла ошибка")
                        Button(action: {
                            Task {
                                refreshable
                            }
                        }) {
                            Text("Повторить")
                        }
                    }
                }.refreshable {
                    await refreshable()
                }
            }
        }.animation(.default, value: result)
    }
}
