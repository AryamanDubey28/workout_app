import random

pushup_exercises = [
    "Deficit Pushup", "3 Sec Paused Pushups", "Diamond Pushup", "Decline Pushup", "Ring Pushup", "Counter Top Dips",
    "Clap Pushup"
]

pullup_exercises = [
    "Standard Pull-Up", "Chin-Up", "Wide Grip Pull-Up", "Close Grip Chin-Up",
    "Commando Pull-Up", "Ring Pull-Up", "Ring Rows", "Wide Grip Chin-Up", "3 Sec Paused Pull-Up", "3 Sec Paused Chin-Up"
]

squat_lunge_exercises = [
    "Heel Elevated Squat", "Jump Squat", "5 Sec Paused Heel Elevated Squat",
    "Bulgarian Split Squat", "Walking Lunge"
]

def generate_random_workout():
    pushup = random.choice(pushup_exercises)
    pullup = random.choice(pullup_exercises)
    squat_lunge = random.choice(squat_lunge_exercises)
    return {
        "pushup": pushup,
        "pullup": pullup,
        "squat_lunge": squat_lunge
    }