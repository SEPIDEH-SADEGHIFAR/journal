import SwiftUI

struct SquareGridView: View {
    var body: some View {
        GeometryReader { geometry in
            let spacing: CGFloat = 20
            let columns = Int(geometry.size.width / spacing)
            let rows = Int(geometry.size.height / spacing)

            Path { path in
                for col in 0...columns {
                    let x = CGFloat(col) * spacing
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: geometry.size.height))
                }

                for row in 0...rows {
                    let y = CGFloat(row) * spacing
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                }
            }
            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
        }
        .ignoresSafeArea()
    }
}
