# Linear Programming Lab
By Denada Bakiasi & Luis Daniel Casais Mezquida  
Heuristics 22/23  
Bachelor's Degree in Computer Science and Engineering, grp. 89  
Universidad Carlos III de Madrid

## Execution
First install Matprog (GLP).
```
sudo apt install glpk-utils
```

To run the program (eg. part 2):
```
cd part-2/
glpsol -m model.mod -d data.dat -o out.txt
```