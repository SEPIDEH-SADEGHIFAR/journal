import SwiftUI
// MARK: - Grid Views
struct DotGridView: View {
    var body: some View {
        GeometryReader { geometry in
            let spacing: CGFloat = 20
            let columns = Int(geometry.size.width / spacing)
            let rows = Int(geometry.size.height / spacing)

            Path { path in
                for col in 0...columns {
                    for row in 0...rows {
                        let x = CGFloat(col) * spacing
                        let y = CGFloat(row) * spacing
                        path.addEllipse(in: CGRect(x: x, y: y, width: 3, height: 3))
                    }
                }
            }
            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
        }
        .ignoresSafeArea()
    }
}
