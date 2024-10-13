#Create an event scheduler where users can add, remove, and view events.
#Requirements:
#Event Class:

#       Attributes: name, date, time.
#       Methods: event_info() (returns a string with event details).
#Scheduler Class:

#       Attributes: events (a list of Event objects).
#       Methods: add_event(name, date, time), remove_event(name), view_events() (returns a list of all events with their details).
#Challenges:

#       Implement functionality to handle scheduling conflicts and view all scheduled events.

from datetime import datetime

class Event:
    def __init__(self, name, date, time):
        self.name = name
        self.date = date
        self.time = time
    
    def event_info(self):
        return f"Event: {self.name}, Date: {self.date}, Time: {self.time}"


class Scheduler:
    def __init__(self):
        self.events = []
    
    def add_event(self, name, date, time):
        new_event = Event(name, date, time)
        
        # Check for scheduling conflicts
        for event in self.events:
            if event.date == date and event.time == time:
                print(f"Scheduling conflict! There's already an event at {date} {time}")
                return
        
        self.events.append(new_event)
        print(f"Event '{name}' added successfully")
    
    def remove_event(self, name):
        for event in self.events:
            if event.name == name:
                self.events.remove(event)
                print(f"Event '{name}' removed successfully")
                return
        print(f"Event '{name}' not found")
    
    def view_events(self):
        if not self.events:
            return "No events scheduled"
        
        # Sort events by date and time
        sorted_events = sorted(self.events, key=lambda x: datetime.strptime(f"{x.date} {x.time}", "%Y-%m-%d %H:%M"))
        
        return "\n".join([event.event_info() for event in sorted_events])

# Example
if __name__ == "__main__":
    scheduler = Scheduler()

    # Add some events
    scheduler.add_event("Team Meeting", "2023-06-15", "10:00")
    scheduler.add_event("Lunch with Client", "2023-06-15", "12:30")
    scheduler.add_event("Project Deadline", "2023-06-16", "17:00")
    
    # Try to add an event with a scheduling conflict
    scheduler.add_event("Conflict Event", "2023-06-15", "10:00")

    # View all events
    print("\nAll scheduled events:")
    print(scheduler.view_events())

    # Remove an event
    scheduler.remove_event("Lunch with Client")

    # Try to remove a non-existent event
    scheduler.remove_event("Non-existent Event")

    # View events after removal
    print("\nEvents after removal:")
    print(scheduler.view_events())
