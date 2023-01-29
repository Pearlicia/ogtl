def my_spaceship(flight_path):
    x, y = 0, 0
    direction = 'up'
    for move in flight_path:
        if move == 'R':
            if direction == 'up':
                direction = 'right'
            elif direction == 'right':
                direction = 'down'
            elif direction == 'down':
                direction = 'left'
            elif direction == 'left':
                direction = 'up'
        elif move == 'L':
            if direction == 'up':
                direction = 'left'
            elif direction == 'left':
                direction = 'down'
            elif direction == 'down':
                direction = 'right'
            elif direction == 'right':
                direction = 'up'
        elif move == 'A':
            if direction == 'up':
                y += 1
            elif direction == 'right':
                x += 1
            elif direction == 'down':
                y -= 1
            elif direction == 'left':
                x -= 1
    return "{x: " + str(x) + ", y: " + str(y) + ", direction: '" + direction + "'}"


print(my_spaceship("RRALAA"))
# Output: "{x: 2, y: -1, direction: 'right'}"
