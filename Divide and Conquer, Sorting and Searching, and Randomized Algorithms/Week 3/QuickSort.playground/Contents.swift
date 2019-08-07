import UIKit

class Solution {
    func firstPivot(_ arr: [Int]) -> [Int] {
        guard arr.count > 1 else { return arr }
        
        let params = quickSort(arr, pivotIndex: 0)
        
        let left = firstPivot(Array(params.arr[0..<params.pivot]))
        let right = firstPivot(Array(params.arr[(params.pivot + 1)...]))
        
        return left + [params.arr[params.pivot]] + right
    }
    
    func randomPivot(_ arr: [Int]) -> [Int] {
        guard arr.count > 1 else { return arr }
        
        let pivot = Int(arc4random_uniform(UInt32(arr.count)))
        let params = quickSort(arr, pivotIndex: pivot)
        
        let left = firstPivot(Array(params.arr[0..<params.pivot]))
        let right = firstPivot(Array(params.arr[(params.pivot + 1)...]))
        
        return left + [params.arr[params.pivot]] + right
    }
    
    private func quickSort(_ arr: [Int], pivotIndex: Int) -> (arr: [Int], pivot: Int) {
        var mutArr: [Int] = []
        var pivotId = pivotIndex
        let pivot = arr[pivotId]
        
        for i in 1..<arr.count {
            if arr[i] >= pivot {
                mutArr.insert(arr[i], at: mutArr.endIndex)
            } else {
                mutArr.insert(arr[i], at: 0)
                pivotId += 1
            }
        }
        mutArr.insert(arr.first!, at: pivotId)
        
        return (mutArr, pivotId)
    }
}


print(Solution().randomPivot([2,3,1,7,7,3,2,34,6,8,56,5,34,2,42,424,24,3]))
print(Solution().randomPivot([20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0]))

