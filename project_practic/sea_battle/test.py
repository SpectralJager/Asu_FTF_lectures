import ast
tree = ast.parse(open('Lordofthesea.py').read())
with open('tree_dump.txt','w') as f:
    temp = (ast.dump(tree)).split('),')
    for t in temp:
        f.writelines(t+')\n')
