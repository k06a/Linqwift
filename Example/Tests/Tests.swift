import UIKit
import XCTest
import Linqwift

class Tests: XCTestCase
{
    func testWhere()
    {
        let seq = AnySequence([1,2,3,4,5,6,7,8])
        XCTAssertEqual([1,3,5,7], Array<Int>(seq.Where { a,i in i%2==0 }))
        XCTAssertEqual([2,4,6,8], Array<Int>(seq.Where { a,i in i%2==1 }))
        XCTAssertEqual([2,4,6,8], Array<Int>(seq.Where { a,i in a%2==0 }))
        XCTAssertEqual([1,3,5,7], Array<Int>(seq.Where { a,i in a%2==1 }))
        XCTAssertEqual([3,4,5,6], Array<Int>(seq.Where { a,i in a>2&&a<7 }))
    }
    
    func testSelect()
    {
        let seq = AnySequence([1,2,3,4])
        XCTAssertEqual([2,4,6,8], Array<Int>(seq.Select { a,i in a*2 }))
        XCTAssertEqual([6,7,8,9], Array<Int>(seq.Select { a,i in a+5 }))
        XCTAssertEqual([1,3,5,7], Array<Int>(seq.Select { a,i in a+i }))
        
        let dict: [Int:String] = [
            1:"One",
            2:"Two",
            3:"Three",
            4:"Four"
        ]
        let ans = ["One","Two","Three","Four"]
        XCTAssertEqual(ans, Array<String>(seq.Select { a,i in dict[a]! }))
    }
}
