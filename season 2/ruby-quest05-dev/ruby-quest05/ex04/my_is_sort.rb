def my_is_sort(param_1)
    # If the array is empty or has only one element, it's sorted
    return true if param_1.length <= 1
  
    # Check if the array is sorted in ascending order
    sorted_asc = param_1.sort == param_1
  
    # Check if the array is sorted in descending order
    sorted_desc = param_1.sort.reverse == param_1
  
    # Return true if the array is sorted in either ascending or descending order
    sorted_asc || sorted_desc
end

  
  