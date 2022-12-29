/*
Given an integer array nums and an integer k, return the kth largest element in the array.

Note that it is the kth largest element in the sorted order, not the kth distinct element.

You must solve it in O(n) time complexity.

Example 1:

Input: nums = [3,2,1,5,6,4], k = 2
Output: 5

Example 2:

Input: nums = [3,2,3,1,2,4,5,5,6], k = 4
Output: 4

Constraints:
1 <= k <= nums.length <= 105
-104 <= nums[i] <= 104

Algorithm:
- Partition subarray around value at randIdx and return pivotIdx.
- partition(startIdx:endIdx:randIdx:) -> pivotIdx
- quickSelect(startIdx:endIdx:findIdx) -> selectIdx
- If pivotIdx is kth, return value at pivotIdx
- If pivotIdx < kth, recurse on pivotIdx + 1, endIdx
- If pivotIdx > kth, recurse on startIdx, pivotIdx - 1
- Return nums[selectIdx]
*/

func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    var nums = nums

    func partition(_ startIdx: Int, _ endIdx: Int, _ randIdx: Int) -> Int {
        var i = startIdx + 1, j = endIdx
        nums.swapAt(startIdx, randIdx)
        while i <= j {
            if nums[i] <= nums[startIdx] {
                i += 1
            } else if nums[j] > nums[startIdx] {
                j -= 1
            } else {
                nums.swapAt(i, j)
                i += 1
                j -= 1
            }
        }
        nums.swapAt(startIdx, j)
        return j
    }

    func quickSelect(_ startIdx: Int, _ endIdx: Int, _ findIdx: Int) -> Int {
        let randIdx = Int.random(in: startIdx...endIdx)
        let pivotIdx = partition(startIdx, endIdx, randIdx)
        if pivotIdx == findIdx {
            return nums[pivotIdx]
        } else if pivotIdx < findIdx {
            return quickSelect(pivotIdx + 1, endIdx, findIdx)
        } else {
            return quickSelect(startIdx, pivotIdx - 1, findIdx)
        }
    }

    return quickSelect(0, nums.count - 1, nums.count - k)
}