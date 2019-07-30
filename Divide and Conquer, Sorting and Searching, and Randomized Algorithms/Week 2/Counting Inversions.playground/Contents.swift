import UIKit

class Solution {
    func countingSolution(_ arr: [Int]) -> (sorted: [Int], inversions: Int) {
        guard arr.count > 1
            else { return (arr, 0) }
        
        let mid = (arr.count % 2 == 0) ? Int(arr.count / 2) - 1 : Int(arr.count / 2)
        let (left, leftInv) = countingSolution(Array(arr[0...mid]))
        let (right, rightInv) = countingSolution(Array(arr[(mid+1)..<arr.count]))
        var resInv = leftInv + rightInv
        
        var res: [Int] = []
        var i = 0
        var j = 0
        for n in 0..<arr.count {
            if j >= right.count {
                res.insert(left[i], at: n)
                i += 1
            } else if i >= left.count {
                res.insert(right[j], at: n)
                j += 1
            } else if left[i] <= right[j] {
                res.insert(left[i], at: n)
                i += 1
            } else if right[j] < left[i] {
                res.insert(right[j], at: n)
                j += 1
                resInv += left.count - i
            }
        }
        return (res, resInv)
    }
}

print(Solution().countingSolution([1,3,5,2,4,6]).inversions) // 3
print(Solution().countingSolution([6,5,4,3,2,1]).inversions) // 15
print(Solution().countingSolution([]).inversions) // 0
print(Solution().countingSolution([0,-1]).inversions) // 1
print(Solution().countingSolution([2,2,2,2,2]).inversions) // 0
