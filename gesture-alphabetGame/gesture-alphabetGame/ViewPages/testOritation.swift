//
//  testOritation.swift
//  gesture-alphabetGame
//
//  Created by 徐浩恩 on 2021/4/9.
//
import SwiftUI

//struct SupportedOrientationsPreferenceKey: PreferenceKey {
//    typealias Value = UIInterfaceOrientationMask
//    static var defaultValue: UIInterfaceOrientationMask {
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            return .all
//        }
//        else {
//            return .allButUpsideDown
//        }
//    }
//
//    static func reduce(value: inout UIInterfaceOrientationMask, nextValue: () -> UIInterfaceOrientationMask) {
//        // use the most restrictive set from the stack
//        value.formIntersection(nextValue())
//    }
//}
//
///// Use this in place of `UIHostingController` in your app's `SceneDelegate`.
/////
///// Supported interface orientations come from the root of the view hierarchy.
//class OrientationLockedController<Content: View>: UIHostingController<OrientationLockedController.Root<Content>> {
//    class Box {
//        var supportedOrientations: UIInterfaceOrientationMask
//        init() {
//            self.supportedOrientations =
//                UIDevice.current.userInterfaceIdiom == .pad
//                    ? .all
//                    : .allButUpsideDown
//        }
//    }
//
//    var orientations: Box!
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        orientations.supportedOrientations
//    }
//
//    init(rootView: Content) {
//        let box = Box()
//        let orientationRoot = Root(contentView: rootView, box: box)
//        super.init(rootView: orientationRoot)
//        self.orientations = box
//    }
//
//    @objc required dynamic init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    struct Root<Content: View>: View {
//        let contentView: Content
//        let box: Box
//
//        var body: some View {
//            contentView
//                .onPreferenceChange(SupportedOrientationsPreferenceKey.self) { value in
//                    // Update the binding to set the value on the root controller.
//                    self.box.supportedOrientations = value
//            }
//        }
//    }
//}
//
//extension View {
//    func supportedOrientations(_ supportedOrientations: UIInterfaceOrientationMask) -> some View {
//        // When rendered, export the requested orientations upward to Root
//        preference(key: SupportedOrientationsPreferenceKey.self, value: supportedOrientations)
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        Text("Hello, World!")
//            .supportedOrientations(.portrait)
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// Our custom view modifier to track rotation and
// call our action
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

// An example view to demonstrate the solution
struct ContentView: View {
    @State private var orientation = UIDeviceOrientation.landscapeLeft


    var body: some View {
        VStack{
            Group {
                if orientation.isPortrait {
                    Text("Portrait")
                } else if orientation.isLandscape {
                    Text("Landscape")
                } else if orientation.isFlat {
                    Text("Flat")
                } else {
                    Text("Unknown")
                }
            }
            .onRotate(){ newOrientation in
                orientation = newOrientation
                print("orientation : \(type(of: orientation))")
            }
            Button(action: {
//                self.modifier(DeviceRotationViewModifier(action: UIDeviceOrientation.landscapeLeft))
            }
                   , label: {
                Text("Button")
            })
        }
    }
}
