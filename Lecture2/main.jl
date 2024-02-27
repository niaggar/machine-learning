include("src/tentMap.jl")
include("src/insertionSort.jl")
include("src/bubbleSort.jl")


using .TentMap
using .InsertionSort
using .BubbleSort

numberOfELements = 20000
disorderList = generateRandomTentMap(numberOfELements, 0.1, 1.99)
disorderList = round.(Int, 1000 .* disorderList)


whileStart = time()
whileOrderList = insertionSortWhile(disorderList, "MaxMin")
whileEnd = time()

forStart = time()
forOrderList = insertionSortFor(disorderList, "MaxMin")
forEnd = time()

bubbleStart = time()
bubbleOrderList = bubbleSort(disorderList, "MaxMin")
bubbleEnd = time()


whileTotalTime = whileEnd - whileStart
forTotalTime = forEnd - forStart
bubbleTotalTime = bubbleEnd - bubbleStart

println("El tiempo transcurrido en while es: ", whileTotalTime, " segundos.")
println("El tiempo transcurrido en for es: ", forTotalTime, " segundos.")
println("El tiempo transcurrido en bubble es: ", bubbleTotalTime, " segundos.")
