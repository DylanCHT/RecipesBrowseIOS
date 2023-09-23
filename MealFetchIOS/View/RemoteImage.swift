//
//  RemoteImage.swift
//  MealFetchIOS
//
//  Created by Dylan  Tao on 9/19/23.
//

import SwiftUI
import Combine

struct RemoteImage: View {
    @StateObject private var imageLoader = ImageLoader()
    private let urlString: String
    private let placeholder: Image
    private let contentMode: ContentMode

    init(urlString: String, placeholder: Image = Image(systemName: "photo"), contentMode: ContentMode = .fit) {
        self.urlString = urlString
        self.placeholder = placeholder
        self.contentMode = contentMode
    }

    var body: some View {
        Group {
            if let uiImage = imageLoader.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .onAppear {
            imageLoader.loadImage(from: urlString)
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?

    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .compactMap { UIImage(data: $0) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
}


//struct RemoteImage_Previews: PreviewProvider {
//    static var previews: some View {
//        RemoteImage()
//    }
//}
