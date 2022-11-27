def compare(a1,a2,a3 :int):
    stack = list()
    if a1>a3:
        stack.append(a1)
        if a2 > a3:
            stack.append(a2)
            stack.append(a3)
        else:
            stack.append(a3)
            stack.append(a2)
    else:
        stack.append(a3)
        stack.append(a1)
        stack.append(a2)
    Print(stack)
    
def Print(stack:list):
    c = 3
    while c != 0:
        print(stack.pop())
        c -= 1
            
x = 4
y = 5
z = 4 

if x > y:
    compare(x,y,z)
else:
    compare(y,x,z)
    