//
//  ___FILENAME___
//  ___PROJECTNAME___
//

import UIKit

protocol ___VARIABLE_sceneName___BusinessLogic {
    func doSomething(request: ___VARIABLE_sceneName___.Something.Request)
//    func doSomethingElse(request: ___VARIABLE_sceneName___.SomethingElse.Request)
}

protocol ___VARIABLE_sceneName___DataStore {
    //var name: String { get set }
}

class ___VARIABLE_sceneName___Interactor: ___VARIABLE_sceneName___DataStore {
    var presenter: ___VARIABLE_sceneName___PresentationLogic?
    var worker: ___VARIABLE_sceneName___WorkerProtocol?
    //var name: String = ""

    deinit {
        //
    }
   
}

// MARK: Do something (and send response to ___VARIABLE_sceneName___Presenter)
extension ___VARIABLE_sceneName___Interactor: ___VARIABLE_sceneName___BusinessLogic {
    
    func doSomething(request: ___VARIABLE_sceneName___.Something.Request) {
        worker = ___VARIABLE_sceneName___Worker()
        worker?.doSomeWork()

        let response = ___VARIABLE_sceneName___.Something.Response()
        presenter?.presentSomething(response: response)
    }
//
//    func doSomethingElse(request: ___VARIABLE_sceneName___.SomethingElse.Request) {
//        worker = ___VARIABLE_sceneName___Worker()
//        worker?.doSomeOtherWork()
//
//        let response = ___VARIABLE_sceneName___.SomethingElse.Response()
//        presenter?.presentSomethingElse(response: response)
//    }
}
