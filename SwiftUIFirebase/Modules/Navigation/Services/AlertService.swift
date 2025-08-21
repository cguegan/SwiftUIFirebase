//
//  AlertService.swift
//  SwiftUIFirebase
//
//  Created by Christophe Guégan on 21/08/2025.
//

import SwiftUI

@MainActor
@Observable
class AlertService {
    var title: String?
    var message: String = ""
    var isPresented: Bool = false
    
    func showAlert(title: String? = nil, message: String) {
        self.title = title
        self.message = message
        self.isPresented = true
    }
}

struct WithAlertView<Content: View>: View {
    
    @Environment(AlertService.self) private var alert

    var content: () -> Content

    var body: some View {
        @Bindable var alert = alert
        content()
            .alert(isPresented: $alert.isPresented) {
                Alert( title: Text(alert.title ?? "Error"),
                       message: Text(alert.message),
                       dismissButton: .default(Text("OK")) )
            }
    }
    
}
