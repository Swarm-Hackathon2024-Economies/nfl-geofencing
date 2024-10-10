import SwiftUI

struct ScalableImageView: UIViewRepresentable {
    let image: UIImage

    init(_ image: UIImage) {
        self.image = image
    }

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.image = image
    }
}
