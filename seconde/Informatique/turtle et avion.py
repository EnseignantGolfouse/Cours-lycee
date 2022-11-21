import turtle


def lance_avion(t):
    GRAVITÉ_X = 0
    GRAVITÉ_Y = -1
    screen_x, screen_y = t.screen.window_width(), t.screen.window_height()
    print(f"width = {screen_x}, heigth = {screen_y}")
    speed = t.speed(); t.speed(0)
    t.goto(-screen_x/2 + 10, 0)
    t.speed(speed)
    t.clear()

    vitessex = 10
    vitessey = 10
    for i in range(100):
        vitessex += GRAVITÉ_X
        vitessey += GRAVITÉ_Y
        x, y = t.position()
        if y <= (-screen_y/2 - vitessey):
            vitessey = -vitessey
        x += vitessex
        y += vitessey
        t.setpos(x, y)

t = turtle.Turtle()
lance_avion(t)
