# Define Job structure
class Job:
    def __init__(self, id, deadline, profit):
        self.id = id
        self.deadline = deadline
        self.profit = profit

def job_sequencing(jobs):
    # Sort jobs by profit (high to low)
    jobs.sort(key=lambda job: job.profit, reverse=True)

    # Find maximum deadline
    max_deadline = max(job.deadline for job in jobs)

    # Initialize time slots (all empty)
    slots = [None] * (max_deadline + 1)
    total_profit = 0
    job_order = []

    # Assign each job to the latest available slot before its deadline
    for job in jobs:
        for time in range(job.deadline, 0, -1):
            if slots[time] is None:
                slots[time] = job.id
                total_profit += job.profit
                job_order.append(job.id)
                break

    return job_order, total_profit

# Example usage
jobs = [
    Job('J1', 2, 100),
    Job('J2', 1, 19),
    Job('J3', 2, 27),
    Job('J4', 1, 25),
    Job('J5', 3, 15)
]

order, profit = job_sequencing(jobs)
print("Scheduled Jobs:", order)
print("Total Profit:", profit)

# with user input, the example usage would look like this:
# Job Sequencing using Greedy Method (with user input)

# Define Job structure
class Job:
    def __init__(self, id, deadline, profit):
        self.id = id
        self.deadline = deadline
        self.profit = profit

def job_sequencing(jobs):
    # Step 1: Sort jobs by descending profit
    jobs.sort(key=lambda job: job.profit, reverse=True)

    # Step 2: Find maximum deadline
    max_deadline = max(job.deadline for job in jobs)

    # Step 3: Initialize time slots
    slots = [None] * (max_deadline + 1)
    total_profit = 0
    job_order = []

    # Step 4: Assign jobs to available slots before their deadlines
    for job in jobs:
        for time in range(job.deadline, 0, -1):
            if slots[time] is None:
                slots[time] = job.id
                total_profit += job.profit
                job_order.append(job.id)
                break

    return job_order, total_profit


# ----------------------------
# Taking user input
# ----------------------------
n = int(input("Enter number of jobs: "))

jobs = []
for i in range(n):
    job_id = input(f"Enter Job ID for job {i+1}: ")
    deadline = int(input(f"Enter deadline for {job_id}: "))
    profit = int(input(f"Enter profit for {job_id}: "))
    jobs.append(Job(job_id, deadline, profit))

# ----------------------------
# Compute result
# ----------------------------
order, total_profit = job_sequencing(jobs)

# ----------------------------
# Display Output
# ----------------------------
print("\nScheduled Jobs:", order)
print("Total Profit:", total_profit)
