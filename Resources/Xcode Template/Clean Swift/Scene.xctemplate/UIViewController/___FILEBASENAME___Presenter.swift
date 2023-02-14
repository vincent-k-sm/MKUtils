//
//  ___FILENAME___
//  ___PROJECTNAME___
//

import UIKit

protocol ___VARIABLE_sceneName___PresentationLogic {
    func presentSomething(response: ___VARIABLE_sceneName___.Something.Response)
}

class ___VARIABLE_sceneName___Presenter {
    weak var viewController: ___VARIABLE_sceneName___DisplayLogic?

    // MARK: Parse and calc respnse from ___VARIABLE_sceneName___Interactor and send simple view model to ___VARIABLE_sceneName___ViewController to be displayed

    deinit {
        //
    }
    
}

extension ___VARIABLE_sceneName___Presenter: ___VARIABLE_sceneName___PresentationLogic {
    
    func presentSomething(response: ___VARIABLE_sceneName___.Something.Response) {
        let viewModel = ___VARIABLE_sceneName___.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
//
//    func presentSomethingElse(response: ___VARIABLE_sceneName___.SomethingElse.Response) {
//        let viewModel = ___VARIABLE_sceneName___.SomethingElse.ViewModel()
//        viewController?.displaySomethingElse(viewModel: viewModel)
//    }
}
