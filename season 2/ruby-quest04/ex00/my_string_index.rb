def my_string_index(haystack, needle)
    i = 0
    while i < haystack.length
      if haystack[i] == needle
        return i
      end
      i += 1
    end
    return -1 
end
  