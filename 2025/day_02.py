import re

def sample_input():
    return """
        11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
    """

def day_input():
    day_number = re.search(r'day_(\d+)', __file__).group(1)  # Gets "01"
    with open(f"day_{day_number}.input", "r") as f:
        return f.read()

def parse(data):
    return [
        [
            int(range.split('-')[0]),
            int(range.split('-')[1])
        ]
        for range in data.strip().split(',')
    ]

def valid_id(id, part2 = False):
    ids = str(id)
    # Check groups of increasing size from 2 up to half the string length
    for group_size in range(1, len(ids) // 2 + 1):
        groups = [ids[i:i+group_size] for i in range(0, len(ids), group_size)]
        if len(set(groups)) == 1:
            # all groups are the same
            if part2:
                if len(groups) >= 2:
                    # and there is a clean repeats 2+
                    return False
            else:
                if len(groups) == 2:
                    # and there is a clean "repeats twice" only
                    return False

    return True

def solve(data, part2 = False):
    invalid_id_sum = 0
    for r in parse(data):
        print(f"checking: {r}")
        for id in range(r[0], r[1] + 1):
            if not valid_id(id, part2):
                # print(f"id: {id} invalid")
                invalid_id_sum += id
    print(f"invalid_id_sum: {invalid_id_sum}")
    return invalid_id_sum

assert 1227775554 == solve(sample_input())
assert 29940924880 == solve(day_input())
assert 4174379265 == solve(sample_input(), True)
assert 48631958998 == solve(day_input(), part2 = True)