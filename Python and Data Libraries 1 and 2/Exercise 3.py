#Create a fitness tracker system where users can log their daily activities and view their statistics.
#Requirements:
#Activity Class:
#   Attributes: date, activity_type (e.g., running, cycling), duration (in minutes).
#   Methods: activity_info() (returns a string with activity details).

#FitnessTracker Class:

#   Attributes: activities (a list of Activity objects).
#   Methods: log_activity(date, activity_type, duration), total_duration(activity_type) (calculates the total duration of a specific activity type).

#Challenges:

#  Implement functionality to log activities and calculate the total duration for each type of activity.

# Activity Class
class Activity:
    def __init__(self, date, activity_type, duration):
        self.date = date
        self.activity_type = activity_type
        self.duration = duration
    
    def activity_info(self):
        return f"Date: {self.date}, Type: {self.activity_type}, Duration: {self.duration} minutes"


# FitnessTracker Class
class FitnessTracker:
    def __init__(self):
        self.activities = []
    
    def log_activity(self, date, activity_type, duration):
        new_activity = Activity(date, activity_type, duration)
        self.activities.append(new_activity)
        print(f"Activity logged: {new_activity.activity_info()}")
    
    def total_duration(self, activity_type):
        total = 0
        for activity in self.activities:
            if activity.activity_type == activity_type:
                total += activity.duration
        return total
    
    def list_activities(self):
        if not self.activities:
            print("No activities logged yet.")
        else:
            for activity in self.activities:
                print(activity.activity_info())

# Example
if __name__ == "__main__":
    tracker = FitnessTracker()

    # Logging activities
    tracker.log_activity("2023-05-01", "running", 30)
    tracker.log_activity("2023-05-02", "cycling", 45)
    tracker.log_activity("2023-05-03", "running", 35)
    tracker.log_activity("2023-05-04", "swimming", 40)

    # Listing all activities
    print("\nAll logged activities:")
    tracker.list_activities()

    # Calculating total duration for running
    running_total = tracker.total_duration("running")
    print(f"\nTotal duration for running: {running_total} minutes")

    # Calculating total duration for cycling
    cycling_total = tracker.total_duration("cycling")
    print(f"Total duration for cycling: {cycling_total} minutes")
