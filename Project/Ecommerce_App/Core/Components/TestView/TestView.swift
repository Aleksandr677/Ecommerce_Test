//
//  TestView.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-12.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        VStack {
            Text("This is a test view.\nEverything is working perfectly!😎")
                .font(.title2)
                .multilineTextAlignment(.center)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
