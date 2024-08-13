import Foundation
import Ignite

@main
struct IgniteWebsite {
    static func main() async {
        let site = ExampleSite()

        do {
            try await site.publish()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ExampleSite: Site {    
    var name = "The Villages Primer"
    var titleSuffix = " – An Unofficial Introduction to The Villages"
    var url: URL = URL("https://mythlandia.github.io")
    var builtInIconsEnabled = true

    var author = "Mythlandia LLC"

    var homePage = Home()
    var theme = MyTheme()
    
    var pages: [any StaticPage] {
        Villages()
        Districts()
        LakeSumter()
    }

}


