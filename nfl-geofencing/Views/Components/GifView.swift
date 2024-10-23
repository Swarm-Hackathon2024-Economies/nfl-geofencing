import SwiftUI

struct GifView: View {
    @State private var images: [Image] = []
    @State private var gifCount: Int = 0
    @State private var currentIndex: Int = 0

    var gifName: String
    var minimumInterval: Double

    var body: some View {
        TimelineView(.animation(minimumInterval: minimumInterval)) { context in
            Group {
                if images.isEmpty {
                    Text("エラー")
                } else {
                    images[currentIndex]
                        .resizable()
                        .scaledToFit()
                }
            }
            .onChange(of: context.date) {
                if currentIndex == (gifCount - 1) {
                    currentIndex = 0
                } else {
                    currentIndex += 1
                }
            }
        }
        .onAppear {
            guard let bundleURL = Bundle.main.url(forResource: gifName, withExtension: "gif"),
                  let gifData = try? Data(contentsOf: bundleURL),
                  let source = CGImageSourceCreateWithData(gifData as CFData, nil)
            else {
                return
            }
            gifCount = CGImageSourceGetCount(source)
            var cgImages: [CGImage?] = []
            for i in 0..<gifCount {
                cgImages.append(CGImageSourceCreateImageAtIndex(source, i, nil))
            }
            let uiImages = cgImages.compactMap({ $0 }).map({ UIImage(cgImage: $0) })
            images = uiImages.map({ Image(uiImage: $0) })
        }
    }
}
