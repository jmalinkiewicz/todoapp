//
//  TasksTest.swift
//  todoappTests
//
//  Created by Jakub Malinkiewicz on 03/03/2025.
//

import XCTest
@testable import todoapp

final class TasksTest: XCTestCase {
    func testSuccessfulTaskCreation() {
        // Arrange
        let title = "Groceries"
        let description = "Milk, flour, eggs, water, sugar"
        let tasks = TaskViewModel()
        let initialCount = tasks.tasks.count
        
        // Act
        tasks.addTask(title: title, description: description)
        
        // Assert
        XCTAssertEqual(tasks.tasks.count, initialCount + 1, "Task count should increase by 1 after adding a task.")
    }
    
    func testEmptyTaskCreation() {
        // Arrange
        let title = ""
        let description = ""
        let tasks = TaskViewModel()
        let initialCount = tasks.tasks.count
        
        // Act
        tasks.addTask(title: title, description: description)
        
        // Assert
        XCTAssertEqual(tasks.tasks.count, initialCount, "Task count should not increase after attempting to add an empty task.")
    }
    
    func testSuccessfulTaskRemoval() {
        // Arrange
        let title = "Workout"
        let description = "Stairmaster and pull ups"
        let tasks = TaskViewModel()
        tasks.addTask(title: title, description: description)
        
        guard let taskToRemove = tasks.tasks.last else {
            XCTFail("No task was added to remove.")
            return
        }
        
        let initialCount = tasks.tasks.count
        
        // Act
        tasks.removeTask(taskToRemove)
        
        // Assert
        XCTAssertEqual(tasks.tasks.count, initialCount - 1, "Task count should decrease by 1 after removal.")
        XCTAssertFalse(tasks.tasks.contains { $0.id == taskToRemove.id }, "Removed task should no longer exist in the list.")
        
    }
    
    func testRemovalOfNonExistentTask() {
        // Arrange
        let task = Task(title: "Don't exist", description: "I'm not real")
        let tasks = TaskViewModel()
        let initialCount = tasks.tasks.count
        
        // Act
        tasks.removeTask(task)
        
        // Assert
        XCTAssertEqual(tasks.tasks.count, initialCount, "Attempting to remove a non-existent task should not decrease task count.")
    }
    
    func testSuccessfulRemovalOfAllTasks() {
        // Arrange
        let tasks = TaskViewModel()
        tasks.addTask(title: "Task 1", description: "Description 1")
        tasks.addTask(title: "Task 2", description: "Description 2")
        tasks.addTask(title: "Task 3", description: "Description 3")
        
        // Act
        tasks.removeAllTasks()
        
        // Assert
        XCTAssertEqual(tasks.tasks.count, 0, "Tasks count should equal 0 after removing all tasks")
    }
    
    func testSuccessfulToggleOfTaskCompletion() {
        // Arrange
        let tasks = TaskViewModel()
        tasks.addTask(title: "Task 1", description: "Description 1")
        
        guard let initialTask = tasks.tasks.last else {
            XCTFail("No task was added to modify.")
            return
        }
        
        let initialCompletionState = initialTask.completed
        
        // Act - First Toggle
        tasks.toggleTaskCompletion(initialTask)
        
        // Assert - Should be toggled
        guard let updatedTask = tasks.tasks.first(where: { $0.id == initialTask.id }) else {
            XCTFail("Task not found after toggling completion.")
            return
        }
        
        XCTAssertNotEqual(initialCompletionState, updatedTask.completed, "Task completion state should toggle after first call.")

        // Act - Second Toggle
        tasks.toggleTaskCompletion(updatedTask)

        // Assert - Should be back to the original state
        guard let revertedTask = tasks.tasks.first(where: { $0.id == initialTask.id }) else {
            XCTFail("Task not found after second toggle.")
            return
        }
        
        XCTAssertEqual(revertedTask.completed, initialCompletionState, "Task completion state should toggle back to original after second call.")
    }
    
    func testToggleOfTaskCompletionOnNonExistentTask() {
        // Arrange
        let tasks = TaskViewModel()
        tasks.addTask(title: "Real Task", description: "This one exists")
        
        guard let realTask = tasks.tasks.last else {
            XCTFail("No real task was added to test.")
            return
        }
        
        let initialCount = tasks.tasks.count
        let initialCompletionState = realTask.completed
        
        let fakeTask = Task(title: "I'm not real", description: "Fake task")
        
        // Act
        tasks.toggleTaskCompletion(fakeTask)
        
        // Assert
        XCTAssertEqual(tasks.tasks.count, initialCount, "Toggling a non-existent task should not change the task count.")
        XCTAssertFalse(tasks.tasks.contains { $0.id == fakeTask.id }, "Non-existent task should not be added to the list.")
        
        guard let updatedRealTask = tasks.tasks.first(where: { $0.id == realTask.id }) else {
            XCTFail("Real task disappeared after toggling a fake task.")
            return
        }
        
        XCTAssertEqual(updatedRealTask.completed, initialCompletionState, "Existing tasks should not be modified when toggling a non-existent task.")
    }
    
    func testSuccessfulToggleOfTaskPin() {
        // Arrange
        let tasks = TaskViewModel()
        tasks.addTask(title: "Task 1", description: "Description 1")
        
        guard let initialTask = tasks.tasks.last else {
            XCTFail("No task was added to modify.")
            return
        }
        
        let initialPinnedState = initialTask.pinned
        
        // Act - First Toggle
        tasks.toggleTaskPin(initialTask)
        
        // Assert - Should be toggled
        guard let updatedTask = tasks.tasks.first(where: { $0.id == initialTask.id }) else {
            XCTFail("Task not found after toggling pin.")
            return
        }
        
        XCTAssertNotEqual(initialPinnedState, updatedTask.pinned, "Task pin state should toggle after first call.")

        // Act - Second Toggle
        tasks.toggleTaskPin(updatedTask)

        // Assert - Should be back to the original state
        guard let revertedTask = tasks.tasks.first(where: { $0.id == initialTask.id }) else {
            XCTFail("Task not found after second toggle.")
            return
        }
        
        XCTAssertEqual(revertedTask.pinned, initialPinnedState, "Task pin state should toggle back to original after second call.")
    }
    
    func testToggleOfTaskPinOnNonExistentTask() {
        // Arrange
        let tasks = TaskViewModel()
        tasks.addTask(title: "Real Task", description: "This one exists")
        
        guard let realTask = tasks.tasks.last else {
            XCTFail("No real task was added to test.")
            return
        }
        
        let initialCount = tasks.tasks.count
        let initialPinState = realTask.pinned
        
        let fakeTask = Task(title: "I'm not real", description: "Fake task")
        
        // Act
        tasks.toggleTaskCompletion(fakeTask)
        
        // Assert
        XCTAssertEqual(tasks.tasks.count, initialCount, "Toggling a non-existent task should not change the task count.")
        XCTAssertFalse(tasks.tasks.contains { $0.id == fakeTask.id }, "Non-existent task should not be added to the list.")
        
        guard let updatedRealTask = tasks.tasks.first(where: { $0.id == realTask.id }) else {
            XCTFail("Real task disappeared after toggling a fake task.")
            return
        }
        
        XCTAssertEqual(updatedRealTask.completed, initialPinState, "Existing tasks should not be modified when toggling a non-existent task.")
    }
    
    func testSuccessfulTaskUpdate() {
        // Arrange
        let tasks = TaskViewModel()
        tasks.addTask(title: "Please update me", description: "I need to be updated")
        let initialCount = tasks.tasks.count
        
        guard let taskToUpdate = tasks.tasks.last else {
            XCTFail("No task was added to test.")
            return
        }
        
        // Act
        
        tasks.updateTask(taskToUpdate, title: "I'm updated", description: "Glad to be updated")
        
        // Assert
        guard let updatedTask = tasks.tasks.first(where: { $0.id == taskToUpdate.id }) else {
            XCTFail("Updated task not found.")
            return
        }
        
        XCTAssertEqual(updatedTask.title, "I'm updated", "Task title should be updated.")
        XCTAssertEqual(updatedTask.description, "Glad to be updated", "Task description should be updated.")
        XCTAssertEqual(updatedTask.id, taskToUpdate.id, "Task ID should remain the same after an update.")
        XCTAssertEqual(tasks.tasks.count, initialCount, "Updating a task should not change the total task count.")
    }

    func testUpdateOfNonExistentTask() {
        // Arrange
        let tasks = TaskViewModel()
        tasks.addTask(title: "Real Task", description: "This one exists")
        
        let initialCount = tasks.tasks.count
        
        let fakeTask = Task(title: "I'm not real", description: "Fake task") // Not in `tasks.tasks`
        
        // Act
        tasks.updateTask(fakeTask, title: "Updated Title", description: "Updated Description")
        
        // Assert
        XCTAssertEqual(tasks.tasks.count, initialCount, "Updating a non-existent task should not change the task count.")
        XCTAssertFalse(tasks.tasks.contains { $0.id == fakeTask.id }, "Non-existent task should not be added to the list.")

        // Ensure existing tasks remain unchanged
        guard let realTask = tasks.tasks.first else {
            XCTFail("Existing task should still be in the list.")
            return
        }
        
        XCTAssertEqual(realTask.title, "Real Task", "Existing task title should remain unchanged.")
        XCTAssertEqual(realTask.description, "This one exists", "Existing task description should remain unchanged.")
    }
}
