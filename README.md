# OLSDynamicHeaderViewController for iOS (v1.0)

This is an easy to integrate component that allows a UIScrollView or any of their widely used subclasses (such as UITableView and UICollectionView) to have a header view that can be animated along with scrolling.

Here an example:

<img src="./Resources/OLSDynamicHeaderDemo.gif" width="300">

## Setup

#### On your ViewController:
* Make your `UIViewController` to inherit either one of the helpers `OLSDynamicHeaderTableViewController` or `OLSDynamicHeaderCollectionViewController`

```swift
class MyViewController: OLSDynamicHeaderTableViewController {

    // MARK - OLSDynamicHeaderViewControllerProtocol
    override func headerViewInstance() -> OLSDynamicHeaderView {
        ...
    }
    
    // ... (View Controller lifecycle and logic)
    
```

* On `headerViewInstance()` return an instance of `OLSDynamicHeaderView` subclass. This class is a basic UIView subclass that conforms the protocol that will help you with the animation part =D. 

#### Now... for your header:
* Create a subclasss of `OLSDynamicHeaderView`, and implement the protocol:
```swift
class MyDynamicHeader: OLSDynamicHeaderView {

    class func viewInstance() -> Self { ... }

    func maxHeight() -> CGFloat { ... }

    func minHeight() -> CGFloat { ... }

    func resize(withProgress progress: CGFloat) { ... }

    func overflow(withPoints points: CGFloat)  { ... }
}
```
* `viewInstance` returns an instance of your header, you can load it from a xib or create it directly.
* `maxHeight` returns the maximum height allowed for this view.
* `minHeight` returns the minimum height allowed for this view.
* `resize(withProgress)` will be called when the user scrolls and your header needs to animate. `progress` goes from 0 to 1, 0 min height reached, 1 max height reached.
* `overflow(withPoints)` will be called when the user scrolls further the max height. `points` goes from 0 to N.

#### Note
* The project includes a basic sample code you can use as a guidence to integrate the component in your app.
* The project provides helper subclasses for tableView and collectionView, and the example above takes advantage of those classes. But you can go a step under and inherit from `OLSDynamicHeaderViewController` and move from there to have additional control.
* If you have questions, improvements, ideas or just comments, see to the links below!

## Author

Omar Hagopian, Antihero [@OrangeLoops](http://orangeloops.com)

Contact:

[📨Mail](ohagopian@orangeloops.com) | [🐥Twitter](https://twitter.com/clackmac) | [📚StackOverflow](https://stackoverflow.com/users/219777/omer)

## License

OLSDynamicDynamicHeader is under the MIT license. See the LICENSE file for more info!
