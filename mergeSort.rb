def mergeSort(arr)
  if arr.length>1
    middle=arr.length/2
    left=arr[0,middle]
    right=arr[middle,arr.length-1]
    
    mergeSort(left)
    mergeSort(right)
    
    leftIndex=0
    rightIndex=0
    resultIndex=0

    while leftIndex<left.length and rightIndex<right.length
      if left[leftIndex]<right[rightIndex]
        arr[resultIndex]=left[leftIndex]
        leftIndex+=1
      else
        arr[resultIndex]=right[rightIndex]
        rightIndex+=1
      end
      resultIndex+=1
    end

    while leftIndex<left.length
      arr[resultIndex]=left[leftIndex]
      leftIndex+=1
      resultIndex+=1
    end

    while rightIndex<right.length
      arr[resultIndex]=right[rightIndex]
      rightIndex+=1
      resultIndex+=1
    end
  end
end

# lst=[2,3,67,12,89,4,1]
# p "original",lst
# mergeSort(lst)
# p "sorted",lst