import re

def sample_input():
    return """
        L68
        L30
        R48
        L5
        R60
        L55
        L1
        L99
        R14
        L82
    """

def day_input():
    day_number = re.search(r'day_(\d+)', __file__).group(1)  # Gets "01"
    with open(f"day_{day_number}.input", "r") as f:
        return f.read()

def parse(data):
    return [line.strip() for line in data.strip().split('\n') if line.strip()]

def solve(data, part2 = False):
    data = parse(data)
    dial = 50
    times_pointing_at_zero = 0
    parsed = []

    for rotation in data:
        direction = rotation[0]  # First character (L or R)
        number = int(rotation[1:])  # Rest as integer
        parsed.append((direction, number))

    for (dir, distance) in parsed:
        step = -1 if dir == "L" else 1

        for _ in range(distance):
            dial += step
            dial = dial % 100

            if part2:
                if dial == 0:
                    times_pointing_at_zero += 1
        
        dial = dial % 100
        if not part2:
            if dial == 0:
                times_pointing_at_zero += 1

    return times_pointing_at_zero

assert 3 == solve(sample_input())
assert 1059 == solve(day_input())
assert 6 == solve(sample_input(), part2 = True)
assert 6305 == solve(day_input(), part2 = True)