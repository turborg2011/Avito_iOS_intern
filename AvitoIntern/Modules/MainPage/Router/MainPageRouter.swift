import UIKit

final class MainPageRouter {
    
    private weak var mainPageVC: MainViewController?
    
    init(mainPageVC: MainViewController) {
        self.mainPageVC = mainPageVC
    }
    
    func pushDetailVC(id: String) async {
        let detailViewController = await DetailPageAssembly().viewController(id: id)
        await mainPageVC?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
