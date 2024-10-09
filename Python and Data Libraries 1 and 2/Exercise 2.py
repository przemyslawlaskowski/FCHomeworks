#Design a task management system where users can add, remove, and list tasks.

#Requirements:
#Task Class:

#   Attributes: title, completed (boolean indicating if the task is completed).
#   Methods: complete_task() (marks the task as completed), task_info() (returns a string with task details).

#TaskManager Class:

#   Attributes: tasks (a list of Task objects).
#Methods: add_task(title), remove_task(title), list_tasks() (returns a list of all tasks with their status).
#Challenges:

#   Ensure that tasks can be marked as completed.
#   Handle cases where tasks are removed or listed.

# Task Class
class Task:
    def __init__(self, title):
        self.title = title
        self.completed = False
    
    def complete_task(self):
        self.completed = True
        print(f"Task '{self.title}' marked as completed.")
    
    def task_info(self):
        status = "Completed" if self.completed else "Not Completed"
        return f"Task: {self.title} - Status: {status}"


# TaskManager Class
class TaskManager:
    def __init__(self):
        self.tasks = []
    
    def add_task(self, title):
        new_task = Task(title)
        self.tasks.append(new_task)
        print(f"Task '{title}' added.")
    
    def remove_task(self, title):
        for task in self.tasks:
            if task.title == title:
                self.tasks.remove(task)
                print(f"Task '{title}' removed.")
                return
        print(f"Task '{title}' not found.")
    
    def list_tasks(self):
        if not self.tasks:
            print("No tasks available.")
        else:
            for task in self.tasks:
                print(task.task_info())

# Example
if __name__ == "__main__":
    manager = TaskManager()

    # Adding tasks
    manager.add_task("Do laundry")
    manager.add_task("Buy groceries")
    manager.add_task("Clean the house")

    # Listing all tasks
    print("\nAll tasks:")
    manager.list_tasks()

    # Completing a task
    manager.tasks[1].complete_task()

    # Listing tasks after completing one
    print("\nTasks after completing 'Buy groceries':")
    manager.list_tasks()

    # Removing a task
    manager.remove_task("Do laundry")

    # Listing tasks after removal
    print("\nTasks after removing 'Do laundry':")
    manager.list_tasks()

    # Trying to remove a non-existent task
    manager.remove_task("Walk the dog")
