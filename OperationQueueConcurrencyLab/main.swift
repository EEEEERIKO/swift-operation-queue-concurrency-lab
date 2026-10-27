//
//  main.swift
//  OperationQueueConcurrencyLab
//
//  Created by Erik Valencia Cardona on 27/10/26.
//

import Foundation

final class OperationQueueConcurrencyLab {
    
    private let operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "com.example.operation-queue-concurrency-lab"
        queue.maxConcurrentOperationCount = 6
        return queue
    }()
    
    
    private func createOperation(
        named name: String,
        priority: Operation.QueuePriority = .normal
    ) -> BlockOperation {
        
        let operation = BlockOperation {
            print("Operation \(name) started")
            
            for _ in 0..<1000000 {
                // simate a long running task
            }
            
            print("Operation \(name) finished")
        }
        
        operation.queuePriority = priority
        return operation
    }
    
    
    func runExperiment(
        maxConcurrentOperations: Int,
        useDependencies: Bool,
        lowPriorityForA: Bool
    ) {
        operationQueue.maxConcurrentOperationCount =
        maxConcurrentOperations
        
        let operationA = createOperation(
            named: "A",
            priority: lowPriorityForA ? .low : .normal
        )
        
        let operationB = createOperation(named: "B")
        let operationC = createOperation(named: "C")
        let operationD = createOperation(named: "D")
        
        if useDependencies {
            operationB.addDependency(operationC)
            operationD.addDependency(operationB)
        }
        
        print("""
               
               ===== EXPERIMENT =====
               Max concurrent operations: \(maxConcurrentOperations)
               Dependencies enabled: \(useDependencies)
               Low priority for A: \(lowPriorityForA)
               ======================
               """)
        
        operationQueue.addOperations(
            [operationA, operationB, operationC, operationD],
            waitUntilFinished: true
        )
        
        print("All operations finished")
    }
}

let lab = OperationQueueConcurrencyLab()
// 1: max concurrency = 6
lab.runExperiment(
    maxConcurrentOperations: 6,
    useDependencies: false,
    lowPriorityForA: false
)

//2: max concurrency = 2
lab.runExperiment(
    maxConcurrentOperations: 2,
    useDependencies: false,
    lowPriorityForA: false
)

//3: dependencies C - B - D
lab.runExperiment(
    maxConcurrentOperations: 6,
    useDependencies: true,
    lowPriorityForA: false
)

//2: low priority
lab.runExperiment(
    maxConcurrentOperations: 6,
    useDependencies: false,
    lowPriorityForA: true
)
