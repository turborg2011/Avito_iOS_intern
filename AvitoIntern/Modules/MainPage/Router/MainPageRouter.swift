import UIKit

final class MainPageRouter {
    
    private weak var mainPageVC: MainViewController?
    
    init(mainPageVC: MainViewController) {
        self.mainPageVC = mainPageVC
    }
    
    func pushDetailVC(id: String) async {
        print("PUSH DETAIL VC WORKED")
        let detailViewController = await DetailPageAssembly().viewController(id: id)
        
        print("print detail VC is here")
        
        await mainPageVC?.navigationController?.pushViewController(detailViewController, animated: true)
        
        print("DID PUSH DETAIL VC")
        //await mainPageVC?.navigationController?.pushViewController(UIViewController(nibName: nil, bundle: nil), animated: true)
    }
}
