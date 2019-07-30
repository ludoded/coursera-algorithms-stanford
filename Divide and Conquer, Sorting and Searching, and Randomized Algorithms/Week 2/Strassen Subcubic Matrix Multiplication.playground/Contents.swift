import UIKit

/**
 This solution imply that matricies are nxn sizes, where n is even and n > 2
 */
class Solution {
    func multiply(m1: [[Int]], m2: [[Int]]) -> [[Int]] {
        guard m1.count > 2, m2.count > 2, m1.count % 2 == 0 else {
            return mMultiply(m1: m1, m2: m2)
        }
        
        let midN = Int(m1.count / 2)
        let A = Array(m1[0..<midN].map{ Array($0[0..<midN]) })
        let B = Array(m1[0..<midN].map{ Array($0[midN...]) })
        let C = Array(m1[midN...].map{ Array($0[0..<midN]) })
        let D = Array(m1[midN...].map{ Array($0[midN...]) })
        let E = Array(m2[0..<midN].map{ Array($0[0..<midN]) })
        let F = Array(m2[0..<midN].map{ Array($0[midN...]) })
        let G = Array(m2[midN...].map{ Array($0[0..<midN]) })
        let H = Array(m2[midN...].map{ Array($0[midN...]) })
        
        let P1 = mMultiply(m1: A, m2: mSubstract(m1: F, m2: H))
        let P2 = mMultiply(m1: mAdd(m1: A, m2: B), m2: H)
        let P3 = mMultiply(m1: mAdd(m1: C, m2: D), m2: E)
        let P4 = mMultiply(m1: D, m2: mSubstract(m1: G, m2: E))
        let P5 = mMultiply(m1: mAdd(m1: A, m2: D), m2: mAdd(m1: E, m2: H))
        let P6 = mMultiply(m1: mSubstract(m1: B, m2: D), m2: mAdd(m1: G, m2: H))
        let P7 = mMultiply(m1: mSubstract(m1: A, m2: C), m2: mAdd(m1: E, m2: F))
        
        var product = Array(repeating: Array(repeating: 0, count: m1.count), count: m1.count)
        let topLeft = ArraySlice(mAdd(m1: mSubstract(m1: mAdd(m1: P5, m2: P4), m2: P2), m2: P6))
        let topRight = ArraySlice(mAdd(m1: P1, m2: P2))
        let bottomLeft = ArraySlice(mAdd(m1: P3, m2: P4))
        let bottomRight = ArraySlice(mSubstract(m1: mSubstract(m1: mAdd(m1: P1, m2: P5), m2: P3), m2: P7))
        
        for i in 0..<midN {
            for j in 0..<midN {
                product[i][j] = topLeft[i][j]
                product[i][midN + j] = topRight[i][j]
                product[midN + i][j] = bottomLeft[i][j]
                product[midN + i][midN + j] = bottomRight[i][j]
            }
        }
        
        return product
    }
}

extension Solution {
    func mMultiply(m1: [[Int]], m2: [[Int]]) -> [[Int]] {
        var res: [[Int]] = Array.init(repeating: Array.init(repeating: 0, count: m1.count), count: m1.count)
        for i in 0..<m1.count {
            for j in 0..<m2.count {
                var sum = 0
                for k in 0..<m1.count {
                    sum += m1[i][k] * m2[k][j]
                }
                res[i][j] = sum
            }
        }
        
        return res
    }
    
    func mAdd(m1: [[Int]], m2: [[Int]]) -> [[Int]] {
        var res: [[Int]] = Array.init(repeating: Array.init(repeating: 0, count: m1.count), count: m1.count)
        for i in 0..<m1.count {
            for j in 0..<m2.count {
                res[i][j] = m1[i][j] + m2[i][j]
            }
        }
        
        return res
    }
    
    func mSubstract(m1: [[Int]], m2: [[Int]]) -> [[Int]] {
        var res: [[Int]] = Array.init(repeating: Array.init(repeating: 0, count: m1.count), count: m1.count)
        for i in 0..<m1.count {
            for j in 0..<m2.count {
                res[i][j] = m1[i][j] - m2[i][j]
            }
        }
        
        return res
    }
}

print(Solution.init().multiply(m1: [[2,3,4,5], [4,5,6,7], [1,2,3,4], [3,4,5,6]], m2: [[1,2,3,4], [2,3,4,5], [3,4,5,6], [4,5,6,7]])) //[[40, 54, 68, 82], [60, 82, 104, 126], [30, 40, 50, 60], [50, 68, 86, 104]]
