module BubbleSort

function bubbleSort(list::Array, order)
    orderList = copy(list)
    numberOfElements = length(orderList)

    for n in 1:numberOfElements
        for i in 2:numberOfElements
            if orderList[i] < orderList[i - 1]
                next = orderList[i - 1]
                actual = orderList[i]
                orderList[i - 1] = actual
                orderList[i] = next
            end
        end
    end

    return orderList
end

export bubbleSort
end