![logo](./image/image.png)
# CleanSwiftTemplates
Clean Swift (a.k.a VIP) is Uncle Bob’s Clean Architecture applied to iOS and Mac projects. In 'Clean Swift' folder you can find a convenience template to add new Xcode. In 'CleanSwiftExample' you can see a basic example.

# Installation
1. Just Double Click Install_Template

# UnInstallation
1. Just Double Click UnInstall_Template

## Automation
### New Run Script Phase 추가
```
# Install Template
"${BUILD_DIR%/Build/*}/SourcePackages/checkouts/MKUtils/Resources/Xcode Template/Install_Template"
 
# Uninstall Tameplates
# "${BUILD_DIR%/Build/*}/SourcePackages/checkouts/MKUtils/Resources/Xcode Template/UnInstall_Template"
```

## Example usage
Lets say we want to add a login screen to our application. It will receive input from user, which will be validated and finally it will display a succes or failure reponse.
For that please do:
1. Click on 'add new file' in Xcode, and click Next

![imstructionas1](./image/instructions1.png)

2. In your template list go down and choose 'Scene' under 'Clean Swift' section

![imstructionas2](./image/instructions2.png)

3. type 'Login' for your new scene name. It should inherit from UIViewController.

![imstructionas3](./image/instructions3.png)

You should see that all 6 files were added to your project

![imstructionas4](./image/instructions4.png)

Finally, lets write some code!

The flow should look like this:
1. LoginViewController need to request interactor to login, with a username and password.
Therefore, LoginViewInteractor should conform a business logic protocol:
```
protocol LoginBusinessLogic {
    func login(request: Login.Something.Request)
}
```
2. LoginInteractor can validate this data in db or network (NetworkWorker), and will answer it to LoginPresentor. 
Therefore, LoginViewPresenter should conform a presentation logic protocol:
```
protocol LoginPresentationLogic {
    func presentLogin(response: Login.Login.Response)
}
```
It's not to long or complicated, so LoginWorker isn't needed and can be deleted.

3. LoginPresneter will parse and process the reponse, and send to view controller a simple straight forward data:
Therefore, LoginViewController should conform a dispaly logic protocol:
```
protocol LoginDisplayLogic: AnyObject {
    func displayUser(viewModel: Login.Something.ViewModeSuccess)
    func displayError(viewModel: Login.Something.ViewModeFailure)
}
```

The model part is like that:
enum Something {
```
// MARK: Use cases
enum Login {
    // MARK: Use cases

    enum Login {
        struct Request {
            let username, password: String
        }

        struct Response {
            let user: User
        }

        struct ViewModelSuccess {
            let username: String
            let age: Int
        }
        
        struct ViewModelFailure {
            let errorMessage: String
        }  
    }
}
```

4. If user logged in successfully, LoginViewController will inform LoginRouter to move to another screen.
Therefore, LoginRouter should conform a routing logic protocol:
```
protocol LoginRoutingLogic {
    func routeToNextScreen(segue: UIStoryboardSegue?)
}
```

<br>

# About Clean Swift
A very good explanation:

https://zonneveld.dev/the-clean-swift-architecture-explained/

and also:

https://clean-swift.com/clean-swift-ios-architecture/

https://sudonull.com/post/14437-Clean-swift-architecture-as-an-alternative-to-VIPER

https://medium.com/dev-genius/clean-swift-vip-with-example-6f6e643a1a01


In short:
### Structure
The purpose in a Clean Swift design pattern is to separate the responsibilities of different entities for clarity and testibility. Together, these entities form what we call scenes. Each family is able to operate independently using only the components within that family.
The components of each family may include the following:
* View Controller (with .xib or .storyboard file)
* Interactor
* Presenter
* Model
* (optional) Router
* (optional) Worker

### The VIP cycle
The Clean Swift architecture is using a VIP cycle to help you separate logic in your application. The VIP cycle consists of a ViewController, Interactor and a Presenter. All classes are responsible for some logic. The ViewController is responsible for the display logic, the Interactor is responsible for the business logic and the Presenter is responsible for the presentation logic.

The ViewController is the first class where the action is triggered. The class is responsible for managing the views in the ViewController. In the ViewController, all the outlets and IBAction functions should be listed.
As soon as an action in the ViewController started, the ViewController will pass that action to the Interactor. The Interactor is the class where all the use cases should be implemented. By doing this, the Interactor is the class which contains all the business logic. This is a big benefit when writing unit tests, because when testing all interactors, all the business logic in your app is tested.
The Interactor is responsible for handling the request and will return an object to the Presenter. The Presenter is the class which is responsible for presenting the object which is generated by the Interactor. The Presenter will parse that object to a ViewModel object and return an object to the ViewController to display.
Using the Clean Swift architecture, you know exactly which logic should be located in which class. This makes your code more maintainable, because when you need to solve a bug or want to add more functionalities, you know exactly where in your code the change should be made.

### Model
During the VIP cycle, each class will add a data object when requesting an action from the other class in the cycle. When the ViewController asks the interactor to request an action from the Interactor, the ViewController will add a ‘Request’ object. This object contains all the data the interactor needs to do the business logic.
The Interactor will handle the request. Once the data has been processed, it will return a ‘Response’ object to the Presenter. The Presenter will parse the data which is needed to a ‘ViewModel’ object, which will be sent to the ViewController. When the ViewModel is received by the ViewController, the ViewController only needs to update the UI elements with the data in the ViewModel.


### Router
There may be situations in your app that the ViewController will present another ViewController. In Clean Swift, navigating between ViewControllers is done by a Router.
If there are navigation options available for the ViewController, a Router class is added to the ViewController. The Router class contains all the navigation options where that specific ViewController can navigate trough. By doing this, almost each VIP cycle will have a Router, which makes it clear what navigation options a ViewController has.
A Presentor is responsible for the presentation logic. When a screen transition will take place, the ViewController needs to ask this to the Interactor and then the Interactor needs to ask this to the Presentor. From there, the Presentor will decide that the ViewController may route to the next ViewController using the Router.


### Worker
When having all business logic located in the Interactor, there may happen a situation where the Interactor will be a very large class. To prevent this, an Interactor can make use of multiple workers. A Worker is a helper of the Interactor, which can help receiving data.
A Worker is responsible for creating objects and doing network calls. Besides that, a Worker can be used to implement Third Party SDKs in your application. For example, if you use Alamofire for doing network requests, but do all the network requests in workers, the Alamofire SDK only needs to be imported in the worker.
Workers must be generic, which means multiple interactors can use them if needed to handle data.


# License
Inspired from [this template](https://github.com/oluckyman/CleanSwift). CleanSwiftTemplates is available under the MIT license. See the LICENSE file for more info.
