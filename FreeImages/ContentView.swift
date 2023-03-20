//
//  ContentView.swift
//  FreeImages
//
//  Created by Biagio Ricci on 20/03/23.
//

import SwiftUI

struct ContentView: View {
    @State private var image = [Images]()
    @State private var page: Int = 1
    var body: some View {
        NavigationView{
            VStack {
                Picker("Page selection", selection: $page) {
                    ForEach(0..<41, id: \.self) {
                        number in Text("\(number) page")
                    }
                    .onChange(of: page) { _ in fetch()
                    }
                }
                List{
                    ForEach(image, id: \.id) {
                        image in NavigationLink {
                            ImageDetailView(images: image)
                        } label: {
                            AsyncImage(url: URL(string: image.download_url)) { phase in
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
                            .frame(width: 250, height: 200)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .onAppear{
                fetch()
            }
        }
    }
    func fetch() {
        guard let url = URL(string: "https://picsum.photos/v2/list?page=\(page)&limit=10") else {
            print("error link")
            return
        }
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data, error == nil else {
                print("error")
                return
            }
            do {
                let image = try JSONDecoder().decode( [Images].self, from: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
