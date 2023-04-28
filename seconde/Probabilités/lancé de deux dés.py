import tkinter as tk
import tkinter.font as tkFont
from random import randint

window = tk.Tk()
fontObj = tkFont.Font(size=20)

tirage_frame = tk.Frame(master=window)
tirage_frame.rowconfigure(1, minsize=20)
tirages_results = {}
for i in range(2, 13):
    label = tk.Label(master=tirage_frame,
                     text=f"résultat = {i}", relief=tk.RAISED,
                     font=fontObj)
    label.grid(row=i, column=0, padx=3, pady=3)
    # label.pack()

    label = tk.Label(master=tirage_frame, text=f"", width=20, relief=tk.RAISED,font=fontObj)
    label.grid(row=i, column=1, padx=3, pady=3)
    # label.pack()
    tirages_results[i] = label

NOMBRE_TIRAGES: int = 50

# Create an event handler


def lance_des(event):
    """Lance le nombre de dés spécifiés"""
    NOMBRE_TIRAGES = int(nb_input.get())
    print(f"{NOMBRE_TIRAGES} tirages")
    totals = {}
    for i in range(2, 13):
        totals[i] = 0
    for _ in range(NOMBRE_TIRAGES):
        de1: int = randint(1, 6)
        de2: int = randint(1, 6)
        totals[de1+de2] += 1
    for i in range(2, 13):
        total = totals[i]
        print(f"nb de {i} = {total}")
        tirages_results[i]['text'] = str(total)


button_frame = tk.Frame(master=window)
label = tk.Label(master=button_frame, text="Nombre de tirages",font=fontObj)
nb_input = tk.Entry(master=button_frame,font=fontObj)
nb_input.insert(0, "50")
button = tk.Button(master=button_frame, text="GO",font=fontObj)
button.bind("<Button-1>", lance_des)

label.grid(row=0, column=0)
nb_input.grid(row=0, column=1)
button.grid(row=0, column=2)

button_frame.grid(row=0, column=0)
tirage_frame.grid(row=1, column=0)

window.mainloop()
