# Swift Operation Queue Concurrency Lab

A Swift learning project exploring concurrent task execution using `BlockOperation` and `OperationQueue`.

## 🎯 Objective

Understand how `OperationQueue` manages concurrent operations and how concurrency limits, dependencies, and operation priorities affect execution.

## 🧠 Concepts Covered

- **`BlockOperation`** — Encapsulates a closure as an operation.
- **`OperationQueue`** — Schedules and manages the execution of operations.
- **`maxConcurrentOperationCount`** — Controls the maximum number of operations that can execute simultaneously.
- **Operation dependencies** — Define ordering constraints between operations.
- **`addDependency(_:)`** — Prevents an operation from starting until its dependencies have finished.
- **`queuePriority`** — Expresses the relative scheduling priority of an operation.
- **`waitUntilFinished`** — Waits for submitted operations to complete before continuing.

## ⚙️ Experiments

The project creates four block-based operations: A, B, C, and D. Each operation simulates a computational task using a loop of one million iterations.

### Experiment 1: Maximum concurrency of 6

```swift
operationQueue.maxConcurrentOperationCount = 6
```

All four operations are eligible to execute concurrently, subject to system scheduling.

### Experiment 2: Maximum concurrency of 2

```swift
operationQueue.maxConcurrentOperationCount = 2
```

The queue permits no more than two operations to execute simultaneously.

### Experiment 3: Operation dependencies

```swift
operationB.addDependency(operationC)
operationD.addDependency(operationB)
```

These dependencies enforce the following order:

**C → B → D**

- Operation B cannot start until C finishes.
- Operation D cannot start until B finishes.
- Operation A remains independent and may execute at any point.

### Experiment 4: Low priority for operation A

```swift
operationA.queuePriority = .low
```

Operation A receives a lower queue priority than operations using the default `.normal` priority.

Queue priority can influence scheduling, but it does not guarantee an exact execution order.

## 🛠️ Technologies

- Swift
- Foundation
- Xcode
- `BlockOperation`
- `OperationQueue`

## 🚀 How to Run

1. Clone or download this repository.
2. Open the Xcode project.
3. Run the command-line application.
4. Inspect the console output for each experiment.
5. Compare the execution order and completion messages.

Each experiment waits for its operations to finish before proceeding to the next one, making the console output easier to analyze.

## 📂 Project Structure

```text
swift-operation-queue-concurrency-lab/
├── OperationQueueConcurrencyLab/
│   └── main.swift
├── OperationQueueConcurrencyLab.xcodeproj/
└── README.md
```

## 📋 Expected Behavior

| Experiment | Expected behavior |
|---|---|
| Maximum concurrency = 6 | Up to four operations may execute concurrently. |
| Maximum concurrency = 2 | At most two operations execute simultaneously. |
| Dependencies enabled | C finishes before B starts; B finishes before D starts. |
| A has low priority | A is assigned `.low` priority, but its execution order is not guaranteed. |

The exact console output may vary because the system controls operation scheduling.

## 📚 Key Takeaway

`OperationQueue` provides a higher-level abstraction for managing concurrent work. Its concurrency limit controls how many operations may run simultaneously, dependencies express ordering requirements, and queue priorities influence scheduling without guaranteeing a fixed order.

These mechanisms help organize complex workloads while keeping task coordination separate from the implementation of each operation.

---

**Project type:** Swift learning exercise  
**Focus:** Operation queues, concurrency limits, dependencies, and scheduling priorities
