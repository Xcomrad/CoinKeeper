
import Foundation

class Di {
    
    static var shared: Di = Di()
    
    var dataManager = DataManagerImpl()
    
    init() {
        self.dataManager = DataManagerImpl()
    }
}
