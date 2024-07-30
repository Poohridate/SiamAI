import SwiftUI
import WebKit

@main
struct SiamAIApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
       
        }
    }
}

struct MainContentView: View {
    
    @StateObject private var webViewStore = WebViewStore()

    var body: some View {
        NavigationView {
            WebView(webView: webViewStore.webView)
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle("SiamAI", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            if webViewStore.webView.canGoBack {
                                webViewStore.webView.goBack()
                            }
                        }) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(webViewStore.canGoBack ? .blue : .gray)
                        }
                        .disabled(!webViewStore.canGoBack)
                    }
                }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // ใช้แบบนี้เพื่อให้ NavigationView ใช้พื้นที่ทั้งหมด
    }
}

final class WebViewStore: ObservableObject {
    @Published var canGoBack: Bool = false
    var webView: WKWebView
    
    private var observation: NSKeyValueObservation?

    init() {
        self.webView = WKWebView()
        self.observation = webView.observe(\.canGoBack, options: [.new]) { [weak self] _, change in
            self?.canGoBack = change.newValue ?? false
        }
    }
}

struct WebView: UIViewRepresentable {
    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if uiView.url == nil {
            let request = URLRequest(url: URL(string: "http://http://siamuniversity.org/ai")!)
            uiView.load(request)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // โค้ดเพื่อจัดการเมื่อเว็บวิวโหลดเสร็จสิ้น
        }
    }
}
