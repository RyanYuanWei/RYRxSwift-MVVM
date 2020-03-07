//
//  ContentView.swift
//  RYRxSwift+MVVM
//
//  Created by RyanYuan on 2020/3/6.
//  Copyright © 2020 RyanYuan. All rights reserved.
//

import SwiftUI


struct ContentViewControllerRepresentation: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = ContentViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ContentViewControllerRepresentation>) -> ContentViewController {
        let contentViewController = R.storyboard.contentView.contentViewController()
        return contentViewController ?? ContentViewController()
    }
    
    func updateUIViewController(_ uiViewController: ContentViewController, context: UIViewControllerRepresentableContext<ContentViewControllerRepresentation>) {
        
    }
}

struct ContentView: View {
    var body: some View {
        ContentViewControllerRepresentation()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
