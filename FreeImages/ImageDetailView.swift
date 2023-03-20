//
//  ImageDetailView.swift
//  FreeImages
//
//  Created by Biagio Ricci on 20/03/23.
//

import SwiftUI

struct ImageDetailView: View {
    var images: Images
    var body: some View {
        VStack{
            
            AsyncImage(url: URL(string: images.download_url)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("There was an error loading the image.")
                } else {
                    ProgressView()
                }
            }
            .frame(width: 400, height: 400)
            
            Text("Author: \(images.author)")
            Text("Resolution: \(images.width) x \(images.height)")
            Button{save(imageUrl: images.download_url)} label: {
                Text("Add to photo library")
            }
        }
    }
    func save(imageUrl: String) {
        
        let imageUrlString = images.download_url
        
        let imageUrl = URL(string: imageUrlString)!
        
        let image = try? UIImage(withContentsOfUrl: imageUrl)
        
        guard let processedImage = image else { return }
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
        }
        imageSaver.errorHandler = {
            print("Oops: \($0.localizedDescription)")
        }
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
}

/*struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView()
    }
}*/
