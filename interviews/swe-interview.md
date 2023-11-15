# Software Engineering Interviews

Software engineering interviews often test a candidate's ability to solve problems, write code, and communicate their thought process. In this guide, we will discuss several key concepts that frequently come up in these interviews, along with Python examples for each.

## Big $\mathcal{O}$

**Simple Explanation**: Big $\mathcal{O}$ notation is a way to describe how long an algorithm takes to run or how much memory it uses as the size of the input increases. It gives us an upper bound on the runtime.

### Tricks

1. Include all the things
2. Use logiscal variable names
3. Define the variables you need
4. Adding vs. multiplying
5. Drop constants
6. Use big-O for space; remember the call stack!
7. Drop non-dominant terms

**Example**:
Suppose we want to find if a number exists in a list. One way is to look at each number until we find it.

```python
def find_num(lst, num):
    for n in lst:
        if n == num:
            return True
    return False
```

The time it takes grows linearly with the size of the list, so we say it's $\mathcal{O}(n)$.

### Big $\mathcal{O}$ Notations and Examples

Let's expand on the Big $\mathcal{O}$ topic by discussing various common Big $\mathcal{O}$ notations and providing examples for each.

#### $\mathcal{O}(1)$ - Constant Time

**Simple Explanation**: An algorithm is $\mathcal{O}(1)$ if its runtime doesn't change as the input size increases. It always takes a constant amount of time.

**Example**:
Accessing an element from an array using its index.

```python
def get_element(arr, index):
    return arr[index]
```

#### $\mathcal{O} (\log n)$ - Logarithmic Time

**Simple Explanation**: An algorithm is $\mathcal{O} (\log n)$ if the number of operations is proportional to the logarithm of the input size. Binary search is a classic example.

**Example**:
Binary search in a sorted array.

```python
def binary_search(arr, x):
    l, r = 0, len(arr) - 1
    while l <= r:
        mid = (l + r) // 2
        if arr[mid] == x:
            return mid
        elif arr[mid] < x:
            l = mid + 1
        else:
            r = mid - 1
    return -1
```

#### $\mathcal{O}(n)$ - Linear Time

**Simple Explanation**: An algorithm is $\mathcal{O}(n)$ if its runtime grows linearly with the input size.

**Example**:
Finding the maximum value in an array.

```python
def find_max(arr):
    maximum = arr[0]
    for num in arr:
        if num > maximum:
            maximum = num
    return maximum
```

#### $\mathcal{O}(n \log n)$ - Linear Logarithmic Time

**Simple Explanation**: Common in algorithms that divide the input in each step. Many efficient sorting algorithms have this time complexity.

**Example**:
Merge sort.

```python
def merge_sort(arr):
    if len(arr) <= 1:
        return arr
    mid = len(arr) // 2
    left = merge_sort(arr[:mid])
    right = merge_sort(arr[mid:])
    return merge(left, right)

def merge(left, right):
    result = []
    i = j = 0
    while i < len(left) and j < len(right):
        if left[i] < right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1
    result.extend(left[i:])
    result.extend(right[j:])
    return result
```

#### $\mathcal{O}(n^2)$ - Quadratic Time

**Simple Explanation**: Algorithms with nested loops often have a quadratic time complexity.

**Example**:
Bubble sort.

```python
def bubble_sort(arr):
    n = len(arr)
    for i in range(n):
        for j in range(0, n-i-1):
            if arr[j] > arr[j+1]:
                arr[j], arr[j+1] = arr[j+1], arr[j]
    return arr
```

#### $\mathcal{O}(2^n)$ - Exponential Time

**Simple Explanation**: Algorithms with this time complexity double their runtime with each additional input element. Recursive algorithms that solve a problem of size $n$ by recursively solving two smaller problems of size $n-1$ often have this time complexity.

**Example**:
Recursive calculation of the nth Fibonacci number.

```python
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)
```

#### \( O(n!) \) - Factorial Time

**Simple Explanation**: Algorithms with this time complexity grow extremely fast and can become impractical even for small input sizes. Commonly seen in brute-force solutions.

**Example**:
Generating all possible permutations of a list.

```python
def permutations(lst):
    if len(lst) == 0:
        return [[]]
    perms = []
    for i in range(len(lst)):
        rest = lst[:i] + lst[i+1:]
        for p in permutations(rest):
            perms.append([lst[i]] + p)
    return perms
```


These are just a few examples of Big $\mathcal{O}$ notations. Understanding the time complexity of algorithms is crucial for writing efficient code and excelling in technical interviews.

## Problem Solving

**Simple Explanation**: Problem-solving is the process of defining a problem and determining a solution to that problem.

**Example**:
Find the sum of all numbers up to a given number.

```python
def sum_up_to_n(n):
    return n * (n + 1) // 2
```

### The Seven Steps Tips

1. Listen carefully what the problem is.
2. Draw an example which serves as input and output.
3. Come up with a brute force first. Ask yourself, what's a stupid way of doing this?
4. Optimize the solution and make sure to spend good chunk of time here. Analyze it with space-time complexity. 
5. Walk through the algorithm before you start coding. This is like looking at a map before you start driving. 
6. Write the code. Typically the interviewer doesn't require you to run the code, but rather 2) want to hear the thought process, and 2) don't want to bogged down in syntactical details or writing surrounding classes.
7. Veriffication. You want to verify the code and make sure it is bug-free to the best of your ability.

### Optimizing with BUD

BUD is short for:

- B: Bottlenecks
- U: Unnecessary work
- D: Duplicated work

### Best Conveivable Runtime

"Best conceivable runtime" is about the problem, not a specific algorithm. It has nothing to do with the best case / worst case runtime. 

## Coding

**Simple Explanation**: Coding is the act of translating a solution or algorithm into a programming language so that a computer can execute it.

**Example**:
Write code to reverse a string.

```python
def reverse_string(s):
    return s[::-1]
```

### Use Type Hints

Let's dive deeper into the topic of "Coding" by discussing type hints in Python.

In modern Python programming, type hints are an essential tool that enhance code readability and allow for better static type checking. Introduced in Python 3.5 through [PEP 484](https://www.python.org/dev/peps/pep-0484/), type hints provide a way to specify the expected data types of function arguments and return values. This makes it easier for developers to understand how a function should be used and can help prevent certain types of bugs.

#### Basic Type Hints

For basic data types like integers, strings, and floats, you can use the built-in Python classes as type hints.

**Example**:
```python
def greet(name: str) -> str:
    return "Hello, " + name
```

Here, the `name` parameter is expected to be a string, and the function is also expected to return a string.

#### Lists, Dictionaries, and Other Collections

For collections, you can use the `List`, `Dict`, `Set`, and `Tuple` types from the `typing` module.

**Example**:
```python
from typing import List, Dict

def average(numbers: List[float]) -> float:
    return sum(numbers) / len(numbers)

def get_student_grades(grades: Dict[str, float]) -> List[float]:
    return list(grades.values())
```

#### Custom Types

For custom classes and data structures, you can use the class name as a type hint.

**Example**:
```python
class Student:
    def __init__(self, name: str, age: int):
        self.name = name
        self.age = age

def register_student(student: Student) -> None:
    # Implementation here
    pass
```

#### Optional Types and None

Sometimes, a variable can be of a specific type or `None`. In such cases, you can use the `Optional` type from the `typing` module.

**Example**:
```python
from typing import Optional

def find_student(name: str) -> Optional[Student]:
    # If the student is found, return the Student object, otherwise return None
    pass
```

#### Benefits of Using Type Hints

1. **Improved Code Readability**: Type hints make it clear what types of arguments are expected and what type of value a function will return.
2. **Better Developer Experience**: Integrated development environments (IDEs) can use type hints to provide better auto-completions, warnings, and refactoring capabilities.
3. **Static Type Checking**: Tools like [mypy](http://mypy-lang.org/) can be used to perform static type checking based on type hints, catching potential type-related errors before runtime.

Incorporating type hints into your Python code can greatly enhance its clarity and maintainability. While Python remains a dynamically typed language, type hints offer a way to harness some of the benefits of static typing without sacrificing the language's flexibility.

## Verification

**Simple Explanation**: Verification involves checking that your code works correctly for all possible inputs.

**Example**:
Verify that the reverse function works.

```python
def test_reverse_string():
    assert reverse_string("hello") == "olleh"
    assert reverse_string("world") == "dlrow"
```

## Communication

**Simple Explanation**: Communication involves explaining your thought process, your code, and any decisions you made while solving a problem.

**Example**:
"I chose a hash table for this problem because it allows for constant time lookups, which will make the solution faster."

## Arrays

**Simple Explanation**: An array is a collection of items, where each item can be identified by an index.

**Example**:
Find the maximum value in an array.

```python
def find_max(arr):
    return max(arr)
```

## Strings

**Simple Explanation**: A string is a sequence of characters.

**Example**:
Check if a string is a palindrome (reads the same backward as forward).

```python
def is_palindrome(s):
    return s == s[::-1]
```

## Hash Tables

**Simple Explanation**: A hash table (or dictionary in Python) is a data structure that stores key-value pairs. Hash tables are a cornerstone of efficient algorithmic design, offering rapid access to data. Key attributes include:

- **Speed**: Hash tables typically allow for constant time average complexity for search operations, making data retrieval swift.
- **Key-Value Pairs**: Data is stored in key-value pairs, where each unique key maps to a specific value.
- **Collisions**: Since multiple keys might hash to the same index, handling collisions is essential. Common strategies include chaining (where each table entry references a list of all key-value pairs that hash to the same index) and open addressing (where alternative slots are sought in the array).
- **Dynamic Resizing**: To maintain efficiency, a hash table can be resized, often doubling its capacity when it's about to be filled and halving when it's less used.
- **Use Cases**: They're invaluable for tasks like data deduplication, counting distinct elements, and cache implementations.

The design and implementation of a hash table significantly influence the efficiency of algorithms that utilize it.

**Example**:
Count the frequency of each character in a string.

```python
def char_frequency(s):
    freq = {}
    for char in s:
        freq[char] = freq.get(char, 0) + 1
    return freq
```

## Search

**Simple Explanation**: Searching is the process of finding a particular item in a collection.

**Example**:
Binary search in a sorted array.

```python
def binary_search(arr, x):
    l, r = 0, len(arr) - 1
    while l <= r:
        mid = (l + r) // 2
        if arr[mid] == x:
            return mid
        elif arr[mid] < x:
            l = mid + 1
        else:
            r = mid - 1
    return -1
```

## Sorting

**Simple Explanation**: Sorting is the process of arranging items in a particular order (ascending or descending).

**Example**:
Bubble sort.

```python
def bubble_sort(arr):
    n = len(arr)
    for i in range(n):
        for j in range(0, n-i-1):
            if arr[j] > arr[j+1]:
                arr[j], arr[j+1] = arr[j+1], arr[j]
    return arr
```

### Tips and Tricks

- Make sure you are certain and aware of the problem statement and that you are dealing with a sorting problem
- Wrtie sorting from scratch or from using builty-in sorting algorithms with multiple toolkits in your pocket
- Know not the basic sorting algorithms such as bubble sort, quick sort, and merge sort, but also know the unconventional ones such as radix sort, and bucket sort. 

### More in Sorting

Sorting is fundamental in algorithmic design, impacting data organization and processing efficiency. Key considerations include:

- **Comparison-Based**: Most classic sorting algorithms are comparison-based, meaning they work by comparing elements.
- **Stability**: A stable sort preserves the relative order of equal elements. This can be crucial in applications like database sorting.
- **In-Place**: An in-place sort uses a constant amount of extra memory (typically $\mathcal{O}(1)$).
- **Time Complexities**: Different algorithms have varied best, average, and worst-case time complexities. The choice often depends on data characteristics and specific needs.
- **Adaptivity**: Some algorithms benefit from existing order in the data, becoming faster as the input becomes more sorted.

#### **Bubble Sort**

Bubble Sort is a simple comparison-based algorithm where the largest elements "bubble" to the end of the list through successive swaps. It's inefficient for large lists, with a worst-case and average-case time complexity of $\mathcal{O}(n^2)$.

```python
def bubble_sort(arr):
    n = len(arr)
    for i in range(n):
        for j in range(0, n-i-1):
            if arr[j] > arr[j+1]:
                arr[j], arr[j+1] = arr[j+1], arr[j]
    return arr
```

####  **Merge Sort**

Merge Sort is a divide-and-conquer algorithm that splits the list in half, recursively sorts both halves, and then merges them back together. It's more efficient than Bubble Sort, with a worst-case time complexity of $\mathcal{O}(n \log n)$.

```python
def merge_sort(arr):
    if len(arr) <= 1:
        return arr
    mid = len(arr) // 2
    left = merge_sort(arr[:mid])
    right = merge_sort(arr[mid:])
    return merge(left, right)

def merge(left, right):
    result = []
    i = j = 0
    while i < len(left) and j < len(right):
        if left[i] < right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1
    result.extend(left[i:])
    result.extend(right[j:])
    return result
```

Both Bubble Sort and Merge Sort have their niches; the former for its simplicity and the latter for its efficiency in many scenarios.

#### **Quick Sort**

Quick Sort is a divide-and-conquer algorithm. It selects a 'pivot' element from the array and partitions the other elements into two sub-arrays, according to whether they are less than or greater than the pivot. The sub-arrays are then sorted recursively. Quick Sort can be very fast in practice, with an average-case time complexity of $\mathcal{O}(n \log n)$, but a worst-case of $\mathcal{O}(n^2)$.

```python
def quick_sort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    return quick_sort(left) + middle + quick_sort(right)
```

#### **Radix Sort**

Radix Sort is a non-comparative sorting algorithm that works by distributing elements into buckets according to their individual digits. It processes the digits of each number one at a time, from the least significant digit (LSD) to the most significant digit (MSD) or vice-versa. Its time complexity is $\mathcal{O}(nk)$, where $n$ is the number of elements and $k$ is the number of passes of the sorting process.

```python
def counting_sort_for_radix(arr, position):
    size = len(arr)
    output = [0] * size
    count = [0] * 10

    for i in range(size):
        index = arr[i] // position % 10
        count[index] += 1

    for i in range(1, 10):
        count[i] += count[i - 1]

    i = size - 1
    while i >= 0:
        index = arr[i] // position % 10
        output[count[index] - 1] = arr[i]
        count[index] -= 1
        i -= 1

    for i in range(size):
        arr[i] = output[i]

def radix_sort(arr):
    max_num = max(arr)
    position = 1
    while max_num // position > 0:
        counting_sort_for_radix(arr, position)
        position *= 10
    return arr
```

#### **Bucket Sort**

Bucket Sort divides the interval of sorted values into buckets or bins. Elements are then distributed into these buckets. Each bucket is then sorted individually, either using a different sorting algorithm or recursively applying bucket sort. Its average-case time complexity is $\mathcal{O}(n + n^2/k + k)$ where $n$ is the number of elements and $k$ is the number of buckets. When $k$ is approximately $n$, the performance is close to $\mathcal{O}(n)$.

```python
def bucket_sort(arr):
    if len(arr) == 0:
        return arr

    min_val, max_val = min(arr), max(arr)
    bucket_range = (max_val - min_val) / len(arr)
    buckets = [[] for _ in range(len(arr) + 1)]

    for num in arr:
        buckets[int((num - min_val) / bucket_range)].append(num)

    sorted_arr = []
    for bucket in buckets:
        sorted_arr.extend(sorted(bucket))

    return sorted_arr
```

Each of these algorithms has its strengths and is particularly suited to certain types of data or certain problem scenarios. Understanding their underlying mechanics and when to use them is a key skill in algorithm design.

## Recursion

**Simple Explanation**: Recursion is when a function calls itself to solve smaller instances of the same problem.

**Example**:
Find the factorial of a number.

```python
def factorial(n):
    if n == 0:
        return 1
    return n * factorial(n-1)
```

### Fibonacci Number

Here's a simple recursive function to find the Fibonacci number at a given position, using type hints:

```python
def fibonacci(n: int) -> int:
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)
```

In this function, if $n$ is 0 or 1, the function returns $n$ itself (as the 0th and 1st Fibonacci numbers are 0 and 1, respectively). For any other value of $n$, the function returns the sum of the Fibonacci numbers at positions $n-1$ and $n-2$. This is a direct application of the Fibonacci sequence definition.

However, it's worth noting that this naive recursive approach is not efficient for large values of $n$ due to the significant number of overlapping computations. For larger values, more efficient algorithms (like memoization or iterative approaches) should be considered.

### Use Recursion to Check Whether a Number is in a Tree

Let's begin by creating the binary tree.

#### Binary Tree Class

```python
class TreeNode:
    def __init__(self, value: int) -> None:
        self.value = value
        self.left = None
        self.right = None
```

This `TreeNode` class represents a node in our binary tree. Each node has a `value` and two child nodes: `left` and `right`.

#### Recursive Function to Check for a Value

```python
def contains_value(node: TreeNode, target: int) -> bool:
    if not node:  # If the node is None, we've reached the end without finding the value
        return False
    if node.value == target:  # If the current node's value matches the target
        return True
    # Recursively check the left and right children
    return contains_value(node.left, target) or contains_value(node.right, target)
```

#### Explanation

1. The `contains_value` function checks if a given binary tree (or subtree) contains a specific value.
2. If the current node (`node`) is `None`, the function returns `False`, indicating that the tree doesn't contain the target value.
3. If the value of the current node matches the target value, the function returns `True`.
4. If neither of the above conditions is met, the function recursively checks the left and right children of the current node.

#### Usage Example

```python
# Create a binary tree:     1
#                         /   \
#                        2     3
#                       / \   / \
#                      4   5 6   7

root = TreeNode(1)
root.left = TreeNode(2)
root.right = TreeNode(3)
root.left.left = TreeNode(4)
root.left.right = TreeNode(5)
root.right.left = TreeNode(6)
root.right.right = TreeNode(7)

print(contains_value(root, 5))  # Output: True
print(contains_value(root, 8))  # Output: False
```

In the example usage, we created a small binary tree and checked whether it contains the value `5` (which it does) and the value `8` (which it doesn't).

## Stacks

**Simple Explanation**: A stack is a collection of items where the last item added is the first item removed (Last-In-First-Out).

**Example**:
Check for balanced parentheses using a stack.

```python
def are_parentheses_balanced(s):
    stack = []
    mapping = {")": "(", "]": "[", "}": "{"}
    for char in s:
        if char in mapping:
            top_element = stack.pop() if stack else '#'
            if mapping[char] != top_element:
                return False
        else:
            stack.append(char)
    return not stack
```

### More in Stacks

Let's begin by designing the `Node` and `Stack` classes as described:

#### Node Class

This class represents an individual node in our stack. Each node has a `value` and a reference to the `next` node.

```python
class Node:
    def __init__(self, val) -> None:
        self.value = val
        self.next = None
```

#### Stack Class

This class represents our stack. It has methods to `push`, `pop`, and `peek` as described.

```python
class Stack:
    def __init__(self) -> None:
        self.top = None

    def push(self, val) -> None:
        new_node = Node(val)
        new_node.next = self.top
        self.top = new_node

    def pop(self):
        if self.top:
            popped_value = self.top.value
            self.top = self.top.next
            return popped_value
        return None

    def peek(self):
        return self.top.value if self.top else None
```

#### Testing with the given array

Now, let's use the array `[1,2,3,4,5]` to test our stack:

```python
stack = Stack()

# Pushing values onto the stack
for value in [1,2,3,4,5]:
    stack.push(value)

print(stack.peek())  # Should print 5, as it's the top of the stack

# Popping values from the stack
print(stack.pop())  # Should print 5
print(stack.pop())  # Should print 4
print(stack.peek())  # Should print 3, as it's now the top of the stack
```

When you push values onto the stack, they are added to the top. When you pop values, they are removed from the top. The `peek` method lets you see the current top value without removing it. In the context of algorithmic design, stacks are useful in various scenarios, such as evaluating expressions, implementing undo-redo functionality, and more.

## Queues

**Simple Explanation**: A queue is a collection of items where the first item added is the first item removed (First-In-First-Out or FIFO). It's like a line at a grocery store checkout.

**Example**:
Using Python's `queue` module to create a simple queue.

```python
import queue

q = queue.Queue()
q.put(1)
q.put(2)
q.put(3)

# The first item to be removed will be 1
print(q.get())  # Output: 1
```

### Trips

- It is a first-in, first out approach. You want to process items in the order they appear. 
- You want to be familiar with `.enqueue` and `.dequeue` methods. 
- Be careful of how the head and tail are updated. 
- Know when to use queue, linked list, stacks, etc..

### More in Queue

Let's dive into the implementation of a `Queue` using a linked list.

#### Node Class

This class represents an individual node in our linked list. Each node has a `value` and a reference to the `next` node.

```python
class Node:
    def __init__(self, val) -> None:
        self.value = val
        self.next = None
```

#### Queue Class

This class represents our queue. It has methods to `enqueue` and `dequeue` as described. We'll also implement a `__str__` method to make it easy to print the queue's contents.

```python
class Queue:
    def __init__(self) -> None:
        self.front = None
        self.rear = None

    def enqueue(self, val) -> None:
        new_node = Node(val)
        if not self.rear:
            self.front = self.rear = new_node
            return
        self.rear.next = new_node
        self.rear = new_node

    def dequeue(self):
        if not self.front:
            return None
        dequeued_value = self.front.value
        self.front = self.front.next
        if not self.front:
            self.rear = None
        return dequeued_value

    def __str__(self) -> str:
        values = []
        current = self.front
        while current:
            values.append(current.value)
            current = current.next
        return ' -> '.join(map(str, values))
```

#### Testing with the given array

Now, let's use the array `[1,2,3,4,5]` to test our queue:

```python
queue = Queue()

# Enqueueing values onto the queue
for value in [1,2,3,4,5]:
    queue.enqueue(value)

# Dequeueing values from the queue and printing it at each step
while True:
    dequeued_value = queue.dequeue()
    if dequeued_value is None:
        break
    print(f"Dequeued: {dequeued_value}, Queue: {queue}")
```

In this example, when values are enqueued, they are added to the rear of the queue. When values are dequeued, they are removed from the front of the queue, consistent with the First-In-First-Out (FIFO) behavior of a queue. The `__str__` method allows us to print the current state of the queue at each step.

## Trees

**Simple Explanation**: A tree is a hierarchical data structure that consists of nodes connected by edges. The topmost node is called the root, and nodes with no children are called leaves.

**Example**:
Defining a simple binary tree.

```python
class TreeNode:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

root = TreeNode(10)
root.left = TreeNode(5)
root.right = TreeNode(20)
```

### Boggle Example / Find Words

To find specific valid words like "cat" from the grid, we need a dictionary or a list of valid words to cross-reference with the generated words from the grid. 

For the purpose of this example, I'll assume we have a list `valid_words` that contains the word "cat". Our DFS-based function will then generate words from the grid and only return those that are present in `valid_words`.

Let's implement this:

```python
def find_words(grid):
    if not grid:
        return []

    rows, cols = len(grid), len(grid[0])
    words = set()
    valid_words = {"cat", "top"}
    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]  # right, down, left, up

    def dfs(x, y, current_word):
        if not (0 <= x < rows and 0 <= y < cols) or (x, y) in visited:
            return

        new_word = current_word + grid[x][y]
        if new_word in valid_words:
            words.add(new_word)

        visited.add((x, y))

        for dx, dy in directions:
            dfs(x + dx, y + dy, new_word)

        visited.remove((x, y))

    for i in range(rows):
        for j in range(cols):
            visited = set()
            dfs(i, j, "")

    return list(words)

# Test on the provided grid
grid = [
    ['c', 'a', 't'],
    ['d', 'e', 'o'],
    ['g', 'h', 'p']
]

print(find_words(grid))
```

This code will correctly identify and return the word "cat" and "top from the provided grid.

### Count Islands (DFS)

Given a binary 2D matrix, find the number of islands. A group of connected 1s forms an island. For example, the below matrix contains 4 islands.

```md
Input: mat[][] = {
    {1, 1, 0, 0, 0},
    {0, 1, 0, 0, 1},
    {1, 0, 0, 1, 1},
    {0, 0, 0, 0, 0},
    {1, 0, 1, 0, 0}
}
```
The goal is to count adjst islands and islands here is defined as integer 1 that is connected together. "Connected" means left/right and top/bottom. 

```md
Expected Output: 4
```

Hint: Define a helper function first. Then use recursion method. This should be depth first search. 

Use the above information, write a python function that does it. 

#### Solution

To solve this problem, we'll use Depth First Search (DFS) to traverse through the 2D matrix. Starting from each cell, we'll use DFS to explore its neighboring cells. When a cell with value `1` is visited, we'll mark it as visited and continue the DFS for its neighbors. This way, we'll traverse the entire island of connected `1`s. For every unvisited cell with value `1`, it indicates the start of a new island.

Let's write the function to solve this:

```python
def num_islands(matrix):
    if not matrix:
        return 0

    rows, cols = len(matrix), len(matrix[0])
    visited = [[False for _ in range(cols)] for _ in range(rows)]
    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]  # right, down, left, up

    def dfs(x, y):
        if not (0 <= x < rows and 0 <= y < cols) or visited[x][y] or matrix[x][y] == 0:
            return
        visited[x][y] = True
        for dx, dy in directions:
            dfs(x + dx, y + dy)

    count = 0
    for i in range(rows):
        for j in range(cols):
            if matrix[i][j] == 1 and not visited[i][j]:
                dfs(i, j)
                count += 1

    return count

# Test with the given matrix
mat = [
    [1, 1, 0, 0, 0],
    [0, 1, 0, 0, 1],
    [1, 0, 0, 1, 1],
    [0, 0, 0, 0, 0],
    [1, 0, 1, 0, 0]
]
print(num_islands(mat))
```

The `dfs` function traverses the matrix in depth-first manner starting from a given cell `(x, y)`. If the current cell is unvisited and has a value `1`, it continues the DFS to its neighboring cells. This helps in visiting all the cells belonging to one island. The outer loop iterates over each cell and starts a DFS if it finds the start of a new island.

#### Time-Space Complexity

Let's analyze the time and space complexity of the `num_islands` function:

**Time Complexity**:

1. **Depth First Search (DFS) Calls**: At most, every cell in the matrix will be visited once by the DFS. Therefore, the DFS contributes a time complexity of $\mathcal{O}(\text{rows} \times \text{cols})$, where `rows` is the number of rows in the matrix and `cols` is the number of columns.
2. **Outer Loops**: The nested loops that iterate over every cell in the matrix also contribute a time complexity of $\mathcal{O}(\text{rows} \times \text{cols})$.

Since both the DFS and the outer loops have the same time complexity and they don't multiply with each other (i.e., one doesn't nest inside the other), the overall time complexity of the function is $\mathcal{O}(\text{rows} \times \text{cols})$.

**Space Complexity**:

1. **Visited Matrix**: The `visited` matrix consumes $\mathcal{O}(\text{rows} \times \text{cols})$ space.
2. **Recursion Stack**: In the worst case, the DFS might end up visiting all cells in the matrix due to deep recursive calls. This contributes a space complexity of $\mathcal{O}(\text{rows} \times \text{cols})$ for the call stack.
3. **Other Variables**: Other variables in the function (like `count`, `directions`, etc.) take constant space, which is $\mathcal{O}(1)$.

Considering the space taken by the `visited` matrix and the maximum potential call stack size of the DFS, the overall space complexity of the function is $\mathcal{O}(\text{rows} \times \text{cols})$.

In summary:
- Time Complexity: $\mathcal{O}(\text{rows} \times \text{cols})$
- Space Complexity: $\mathcal{O}(\text{rows} \times \text{cols})$

## Heaps

**Simple Explanation**: A heap is a specialized tree-based data structure that satisfies the heap property. For a max heap, for any given node I, the value of I is greater than the values of its children. For a min heap, it's the opposite.

**Example**:
Using Python's `heapq` module to create a min-heap.

```python
import heapq

heap = []
heapq.heappush(heap, 10)
heapq.heappush(heap, 5)
heapq.heappush(heap, 20)

# The smallest item will be popped first
print(heapq.heappop(heap))  # Output: 5
```

### Largest Triple Products

You're given a list of n integers `arr[0..(n-1)]`. You must compute a list `output[0..(n-1)]` such that, for each index i (between 0 and n-1, inclusive), `output[i]` is equal to the product of the three largest elements out of `arr[0..i]` (or equal to $-1$ if $i < 2$, as `arr[0..i]` then includes fewer than three elements).

Note that the three largest elements used to form any product may have the same values as one another, but they must be at different indices in arr.

```md
Example 1
n = 5
arr = [1, 2, 3, 4, 5]
output = [-1, -1, 6, 24, 60]
The 3rd element of output is 3*2*1 = 6, the 4th is 4*3*2 = 24, and the 5th is 5*4*3 = 60.

Example 2
n = 5
arr = [2, 1, 2, 1, 2]
output = [-1, -1, 4, 4, 8]
The 3rd element of output is 2*2*1 = 4, the 4th is 2*2*1 = 4, and the 5th is 2*2*2 = 8.
```

#### Original Solution

```py
def helper(arr):
  ans = 1
  for i in arr:
    ans = ans*i
    
  return ans

def pick_top_3(arr):
  arr.sort()
  arr = arr[::-1]
  return arr[:3]


def findMaxProduct(arr):
  # Write your code here
  if len(arr) == 0:
    return
  
  if len(arr) == 1:
    return [-1]
  
  if len(arr) == 2:
    return [-1, -1]
  
  answer = [-1, -1]
  if len(arr) > 2:
    for i in range(2, len(arr)):
      current_array = arr[0:(i+1)]
      top_3_elements = pick_top_3(current_array)
      current_prod = helper(top_3_elements)
      answer.append(current_prod)
      
    return answer
```

The code you have provided for solving the Largest Triple Products problem does not use a priority queue; rather, it uses sorting to find the top three elements at each iteration.

The code you have provided for solving the Largest Triple Products problem does not use a priority queue; rather, it uses sorting to find the top three elements at each iteration.

Here's the breakdown of the time and space complexity for your code:

**Time Complexity:**

- The main loop runs $n-2$ times, where $n$ is the length of the input array.
- Inside the loop, you are creating a subarray `current_array` which is a $\mathcal{O}(i)$ operation.
- Then you are sorting this subarray, which takes $\mathcal{O}(i \log i)$ time.
- The product operation is $\mathcal{O}(1)$, since it always operates on three elements.

The total time complexity would be the sum of the sorting operations over all the subarrays:

$$T(n) = \sum_{i=3}^{n} O(i \log i)$$

Which can be approximated to $\mathcal{O}(n^2 \log n)$ in the worst case when $n$ is large, because the sorting time grows with the size of the subarray.

**Space Complexity:**

- The space complexity of your code is $\mathcal{O}(n)$ due to the space required for the `answer` list that stores $n$ elements.
- Additionally, there is the space taken by the `current_array` which at most will store $n$ elements, but since it is reused and not stored persistently across iterations, it does not add to the overall space complexity.

#### Solution Using Priority Queue

Here's how you would do it:

- Use a min-heap to keep track of the three largest elements. The min-heap allows you to efficiently get rid of the smallest of the top three elements when you need to insert a new element into this set.
- For each element in `arr`, insert it into the heap.
- If the heap size exceeds three, remove the smallest element (the root of the min-heap).
- When you have three elements in the heap, the product of these will be the required product for the current position in the output array.
- Before you have three elements, the output is -1.

The time complexity of this approach would be $\mathcal{O}(n \log 3)$, which simplifies to $\mathcal{O}(n)$, since the heap operations (insertion and extraction) can be done in $\mathcal{O}(\log k)$ time, where $\mathcal{O}(k)$ is the number of elements in the heap, which is constant (3 in this case). The space complexity would be $\mathcal{O}(1)$ or $\mathcal{O}(k)$ considering the heap size is constant and does not grow with $\mathcal{O}(n)$.

The priority queue approach to solving the problem has been implemented in Python as follows:

```python
import heapq

def findMaxProduct(arr):
    # Initialize the heap and the answer array with default -1 values
    heap = []
    answer = [-1] * len(arr)
    
    for i in range(len(arr)):
        # Push the current element into the heap
        heapq.heappush(heap, arr[i])
        # If the heap has more than three elements, pop the smallest one
        if len(heap) > 3:
            heapq.heappop(heap)
        # If the heap has three elements, multiply them to get the current product
        if len(heap) == 3:
            answer[i] = heap[0] * heap[1] * heap[2]
            
    return answer

# Example usage:
arr1 = [1, 2, 3, 4, 5]
arr2 = [2, 1, 2, 1, 2]
print(findMaxProduct(arr1))  # Expected output: [-1, -1, 6, 24, 60]
print(findMaxProduct(arr2))  # Expected output: [-1, -1, 4, 4, 8]
```

When executed, the function `findMaxProduct` correctly computes the expected outputs:

- For the array `[1, 2, 3, 4, 5]`, the output is `[-1, -1, 6, 24, 60]`.
- For the array `[2, 1, 2, 1, 2]`, the output is `[-1, -1, 4, 4, 8]`.

This implementation efficiently uses a min-heap (priority queue) to keep track of the top three elements at any point in the array, ensuring that the time complexity is `O(n)` where `n` is the length of the input array.

#### Try Use List

```py
def findMaxProduct(arr):
  # Write your code here
  if len(arr) == 0:
    return
  
  if len(arr) == 1:
    return [-1]
  
  if len(arr) == 2:
    return [-1, -1]
  
  heap = []
  answer = [-1, -1]
  if len(arr) > 2:
    for i in range(len(arr)):
      heap.append(arr[i])
      if len(heap) > 3:
        heap.sort()
        heap = heap[::-1]
        heap.pop()
      if len(heap) == 3:
        answer.append(heap[0] * heap[1] * heap[2])
      
    return answer
```

**Important Comment**

The provided function uses a list to simulate a priority queue without using the actual heap data structure provided by Python's `heapq` module. However, the way it's used in your function does not embody the efficient operations of a true heap.

**Time Complexity:**

- The main loop runs for each element in `arr`, so it has a linear component $\mathcal{O}(n)$.
- Within the loop, you append an element to the heap, which is $\mathcal{O}(1)$ on average but can be $\mathcal{O}(n)$ in the worst case due to the need to resize the list.
- When the heap size is greater than 3, you sort it, which is $\mathcal{O}(k \log k)$, where $\mathcal{O}(k)$ is the size of the heap. In this case, $\mathcal{O}(k)$ is at most 4, so this is a constant operation, but the constant factor is significant.
- After sorting, you reverse the list (`heap[::-1]`), which is $\mathcal{O}(k)$.
- The `pop` operation is $\mathcal{O}(1)$.

The dominant factor here is the sort operation inside the loop. Even though the heap size is small, the sort is called for every element in the array. The overall time complexity would be $\mathcal{O}(n \log k)$ with the constant $\mathcal{O}(k)$ having a relatively small impact, so we can approximate this to $\mathcal{O}(n)$, but it's important to note that the sorting makes this less efficient than a true heap implementation.

**Space Complexity:**

- The space complexity for the `heap` list is $\mathcal{O}(1)$ since it stores at most 3 elements.
- The `answer` list is $\mathcal{O}(n)$ since it stores an element for each input in `arr`.

So, the space complexity of the function is $\mathcal{O}(n)$.

**Is it a heap structure?**

No, the structure you are using is not a heap. A heap is a specialized tree-based data structure that satisfies the heap property: if $P$ is a parent node of $C$, then the key (the value) of $P$ is either greater than or equal to (in a max heap) or less than or equal to (in a min heap) the key of $C$. The node at the "top" of the heap (the root node) has the greatest value in a max heap or the smallest in a min heap.

In your function, you are enforcing this property manually by sorting the list every time it exceeds a size of 3. This does ensure that the largest (or smallest) element is always at a specific position in the list, but it does not provide the same performance guarantees as a heap. A true heap structure allows you to insert and extract elements in $\mathcal{O}(\log n)$ time, which is not the case with your list-based approach since the sort operation is more costly.


## Graphs

**Simple Explanation**: A graph is a collection of nodes (or vertices) and edges that connect these nodes. It can be used to represent many real-world systems like networks, roads, etc.

**Example**:
Representing a simple undirected graph using an adjacency list.

```python
graph = {
    'A': ['B', 'C'],
    'B': ['A', 'D', 'E'],
    'C': ['A', 'F'],
    'D': ['B'],
    'E': ['B', 'F'],
    'F': ['C', 'E']
}
```

## Greedy Algorithms

**Simple Explanation**: Greedy algorithms make locally optimal choices at each step with the hopes of finding a global optimum. They don't always guarantee the best solution, but they are often fast and good for optimization problems.

**Example**:
The coin change problem. Given coins of certain denominations and a total amount, find the minimum number of coins that make up that amount.

```python
def coin_change(coins, amount):
    coins.sort(reverse=True)
    count = 0
    for coin in coins:
        if amount == 0:
            break
        num_coins = amount // coin
        count += num_coins
        amount -= coin * num_coins
    return count if amount == 0 else -1

print(coin_change([1, 2, 5], 11))  # Output: 3 (5 + 5 + 1)
```

---

These are the additional sections you've requested. Integrating them with the previous content would yield a comprehensive guide on many of the fundamental topics in computer science and algorithms.

This markdown file provides an overview of common topics in software engineering interviews. It's important to practice and understand the underlying principles behind each topic to succeed in interviews.