import Foundation
import Ignite

struct Home: StaticPage {
    var title = "Home"

    func body(context: PublishingContext) -> [BlockElement] {
        
        Text("Welcome to The Villages")
            .font(.title2)
        
        Card( imageName: "images/Lake Sumter dock.jpeg") {
            Text("Landing at Lake Sumter")
            Link("Learn More", target: LakeSumter())
                .linkStyle(.button)
        }
            .frame(maxWidth: 500)
            

        List {
            Link("Villages", target: Villages())
            Link("Districts", target: Districts())
        }
    }
}
