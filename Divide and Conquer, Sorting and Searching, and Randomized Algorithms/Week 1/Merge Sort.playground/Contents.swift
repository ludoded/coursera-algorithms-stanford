import UIKit

class Solution {
    func mergeSort(_ arr: [Int]) -> [Int] {
        guard arr.count > 1
            else { return arr }
        
        if arr.count == 2 {
            return [arr.min()!, arr.max()!]
        } else {
            let mid = Int(arr.count / 2)
            let left = mergeSort(Array(arr[0...mid]))
            let right = mergeSort(Array(arr[(mid+1)..<arr.count]))
            
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
                }
            }
            return res
        }
    }
}


print(Solution().mergeSort([6,2,1,551,335,111,5477,883,2,567,3]))
print(Solution().mergeSort([20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0,-1]))
print(Solution().mergeSort([]))
print(Solution().mergeSort([1000]))
print(Solution().mergeSort([1,2]))
print(Solution().mergeSort([2,1]))
print(Solution().mergeSort([2,2,2,2,2]))
