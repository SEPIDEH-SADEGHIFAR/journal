import UIKit
import SwiftUI


struct DraggableItem: Identifiable {
    let id = UUID()
    var position: CGPoint
    var scale: CGFloat = 1.0 
    var content: DraggableContent
}

enum DraggableContent {
    case image(UIImage)
    case text(String)
}
