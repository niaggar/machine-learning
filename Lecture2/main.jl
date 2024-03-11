include("src/tentMap.jl")
include("src/insertionSort.jl")
include("src/bubbleSort.jl")


using .TentMap
using .InsertionSort
using .BubbleSort

numberOfELements = 1000
disorderList = generateRandomTentMap(numberOfELements, 0.1, 1.99)
disorderList = round.(Int, 1000 .* disorderList)

# println("-> Lista desordenada genearda con mapeo tienda de campaña.")
# println(disorderList)

println("Fin de la creacion de los nnumeros.")

whileStart = time()
whileOrderList = insertionSortWhile(disorderList, "MaxMin")
# println("-> Lista ordenda -Insertion Sort While-")
# println(whileOrderList)
whileEnd = time()

forStart = time()
forOrderList = insertionSortFor(disorderList, "MaxMin")
# println("-> Lista ordenda -Insertion Sort For-")
# println(forOrderList)
forEnd = time()

bubbleStart = time()
bubbleOrderList = bubbleSort(disorderList, "MaxMin")
# println("-> Lista ordenda -Bubble Sort-")
# println(bubbleOrderList)
bubbleEnd = time()


whileTotalTime = whileEnd - whileStart
forTotalTime = forEnd - forStart
bubbleTotalTime = bubbleEnd - bubbleStart

println("-> Tiempos transcurridos")
println("- Insertion sort while: ", whileTotalTime, " s.")
println("- Insertion sort for: ", forTotalTime, " s.")
println("- Bubble sort: ", bubbleTotalTime, " s.")
