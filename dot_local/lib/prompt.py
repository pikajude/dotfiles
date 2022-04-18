import random
import socket

random.seed(socket.gethostname())

print(random.choice([1, 2, 3, 5, 6, 9, 81, 114, 142, 175, 204, 217]))
