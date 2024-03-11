module InsertionSort


function insertionSortWhile(list::Array, order)
    orderList = copy(list)
    numberOfElements = length(orderList)

    for i in 2:numberOfElements
        current = orderList[i]
        j = i - 1
        while j > 0 && orderList[j] > current
            orderList[j+1] = orderList[j]
            j -= 1
        end
        orderList[j+1] = current
    end

    return orderList
end

function insertionSortFor(list::Array, order)
    orderList = copy(list)
    numberOfElements = length(orderList)

    for i in 2:numberOfElements
        current = orderList[i]
        
        for j in 1:(i-1)
            currentOnOrder = orderList[j]
            if current > currentOnOrder
                continue
            else
                deleteat!(orderList, i)
                insert!(orderList, j, current)
                break               
            end
        end
    end

    return orderList
end

# function insertionSortFor(list::Array, order)
#     orderList = list
#     numberOfElements = length(orderList)

#     for i in 2:numberOfElements
#         current = orderList[i]
        
#         for j in 1:(i-1)
#             currentOnOrder = orderList[j]
#             if current > currentOnOrder
#                 if order == "MinMax"
#                     continue
#                 elseif order == "MaxMin"
#                     deleteat!(orderList, i)
#                     insert!(orderList, j, current)
#                     break
#                 end
#             else
#                 if order == "MinMax"
#                     deleteat!(orderList, i)
#                     insert!(orderList, j, current)
#                     break
#                 elseif order == "MaxMin"
#                     continue
#                 end                
#             end
#         end
#     end

#     return orderList
# end

export insertionSortWhile, insertionSortFor
end