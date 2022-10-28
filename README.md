# Linear Programming Lab
By Denada Bakiasi & Luis Daniel Casais Mezquida  
Heuristics 22/23  
Bachelor's Degree in Computer Science and Engineering, grp. 89  
Universidad Carlos III de Madrid

## Problem statement
A problem the management board of some schools must solve each year is the organization of the school bus routes. Specifically, the board of one school has contacted the students of the Heuristics and Optimization course to solve several problems related to the school bus routes design.

### Part 1: Basic Modeling with LibreOffice Calc
The first problem the school board wants to solve is the generation of the routes the buses must follow to pick up the students in their assigned stops and drive them to school.

![Figure 1](img/ex1_graph.svg)

Figure 1 shows the problem we must solve. All buses responsible for the school routes leave every morning from the parking. Each of these buses picks up the students from their assigned stops and drives them to the school. Figure 1 shows a graph where each vertex represents a different location: the parking (vertex with buses), the school (vertex with the building), and the different stops. In our case there are three stops (S1, S2 and S3). The green numbers on each stop represent the number of students that take the bus to school in that stop. So, 15 students take the bus at stop S1, 5 students take the bus at stop S2 and 10 students take the bus at stop S3. The edges of the graph represent to streets to move from one location to another. Alongside each edge a number shows the distance between the locations in km. So we know that the distance between stops S2 and S3 is 5km, the distance between stop S3 and the school is 4km, and so on. The figure only shows streets that can be used to go from one location to the other. On the other hand, the school can only use three buses to follow the routes and pick up the students (in general, the maximum number of buses that can be used is the number of stops). All buses have the same capacity, which is 20 students.  
Any solution must comply with the following constraints:
- Each stop is visited by a single route.
- From each stop only one route can exit.
- The number of routes cannot be greater than the number of available buses.
- All routes start from the parking and end at the school. Thus, the number of routes starting at the parking must be the same as the number of routes finishing at the school. In the example two routes exit the school and they both finish at the school.
- The flow of students from location X to location Y (number of students going from X to Y ) cannot be greater than the bus capacity if there is a route that goes from X to Y . If there is no route between two locations, the flow of students must be zero.

The school board is interested in designing the school bus routes in order to minimize the cost associated with them. Each bus used adds a cost of 120 e. Additionally, to this cost we must add the gas cost, which is 5e/km. Thus, considering the solution show in Figure 1 (red and blue routes) the total cost would be 120 × 2 + 5 × (8 + 6 + 10 + 5 + 7) = 420 e. These routes form a solution that is not necessarily optimal.  
The find the optimal solution you must:
1. Model the problem as a Integer Lineal Programming task ([Modelling P1](#modelling-p1)).
2. Implement and solve the model in a spreadsheet (`part-1/exercise1lab.ods`).

#### Modelling P1
Set of stops:  
![](https://latex.codecogs.com/svg.image?S=%5C%7BO,%5C%20S1,%5C%20S2,%5C%20S3,%5C%20F%5C%7D)  
Set of stops with passengers:  
![](https://latex.codecogs.com/svg.image?P=%5C%7BS1,%5C%20S2,%5C%20S3%5C%7D)  
**Decistion variable** - edge between stop i and stop j:  
![](https://latex.codecogs.com/svg.image?A_%7Bij%7D%5Cin%20%5C%7B0,%5C%201%5C%7D;%20i,j%5Cin%20S)  
**Decistion variable** - flux between stop i and stop j:  
![](https://latex.codecogs.com/svg.image?F_{ij}\in&space;F;&space;i,j\in&space;S)  
![](https://latex.codecogs.com/svg.image?F_{ij}\in&space;\mathbb{N};&space;F\in&space;P\times&space;P)  
Students in stop k:  
![](https://latex.codecogs.com/svg.image?p_{k}\in&space;\mathbb{N};&space;k\in&space;P)  
Cost of edge k:  
![](https://latex.codecogs.com/svg.image?a_{k}\in&space;\mathbb{N};&space;k&space;\in&space;[1,9]\subset&space;\mathbb{N})  
Cost of going from i to j:  
![](https://latex.codecogs.com/svg.image?C_{ij}\in&space;\mathbb{N})  
![](https://latex.codecogs.com/svg.image?C_%7Bif%7D=%5Cinfty%5C%20iff%5C%20there%5C%20is%5C%20no%5C%20edge%5C%20from%5C%20i%5C%20to%5C%20j)   
![](https://latex.codecogs.com/svg.image?C\in&space;P\times&space;P)  
![](https://latex.codecogs.com/svg.image?C=%5Cbegin%7Bbmatrix%7D%5Cinfty%20&%20a_%7B1%7D%20&%20a_%7B2%7D%20&%20a_%7B3%7D%20&%20%5Cinfty%20%5C%5C%5Cinfty%20&%20%5Cinfty%20&%20a_%7B4%7D%20&%20a_%7B5%7D%20&%20a_%7B6%7D%20%5C%5C%5Cinfty%20&%20a_%7B4%7D%20&%20%5Cinfty%20&%20a_%7B7%7D%20&%20a_%7B8%7D%20%5C%5C%5Cinfty%20&%20a_%7B5%7D%20&%20a_%7B7%7D%20&%20%5Cinfty%20&%20a_%7B9%7D%20%5C%5C%5Cinfty%20&%20%5Cinfty%20&%20%5Cinfty%20&%20%5Cinfty%20&%20%5Cinfty%20%5C%5C%5Cend%7Bbmatrix%7D)  
Cost per bus:  
![](https://latex.codecogs.com/svg.image?b%5Cin%20%5Cmathbb%7BN%7D)  
Cost per km:  
![](https://latex.codecogs.com/svg.image?c%5Cin%20%5Cmathbb%7BN%7D)  
Capacity of each bus:  
![](https://latex.codecogs.com/svg.image?d%5Cin%20%5Cmathbb%7BN%7D)  

---
![](https://latex.codecogs.com/svg.image?min%5C%20Z=c%5Ccdot%20%5Csum_%7Bi,j%5Cin%20S%7DC_%7Bij%7D%5Ccdot%20A_%7Bij%7D&plus;b%5Csum_%7Bj%5Cin%20S%7DA_%7BOj%7D)  

![](https://latex.codecogs.com/svg.image?s.t.)  
![](https://latex.codecogs.com/svg.image?(1)%5C%20%5Cforall%20i%5Cin%20P,%5Csum_%7Bk%5Cin%20S%7DA_%7Bik%7D=1)  
![](https://latex.codecogs.com/svg.image?(2)%5C%20%5Cforall%20j%5Cin%20P,%5Csum_%7Bk%5Cin%20S%7DA_%7Bik%7D=1)  
![](https://latex.codecogs.com/svg.image?(3)%5C%20%5Csum_%7Bj%5Cin%20S%7DA_%7BOj%7D=%5Csum_%7Bi%5Cin%20S%7DA_%7BiF%7D)  
![](https://latex.codecogs.com/svg.image?(4)%5C%20%5Cforall%20i%5Cin%20P,%5Csum_%7Bk%5Cin%20S%7DF_%7Bik%7D=p_%7Bi%7D&plus;%5Csum_%7Bj%5Cin%20P%7DF_%7Bji%7D)  
![](https://latex.codecogs.com/svg.image?(5)%5C%20%5Cforall%20i,j%5Cin%20S,F_%7Bij%7D%5Cleq%20d%5Ccdot%20A_%7Bij%7D) 

![](https://latex.codecogs.com/svg.image?(I)%5C%20F_%7Bij%7D%5Cgeq%200;%20i,j%5Cin%20S;%20F_%7Bij%7D%5Cin%20%5Cmathbb%7BN%7D)  

#### Solution P1
The solution is Z* = 400:
![Figure 1](img/ex1_sol_graph.svg)


### Part 2: Advanced modeling with GLPK
In addition to the route optimization problem defined in Part 1, the school board thinks the transport cost can be reduced even more if the stops the students are assigned to could be changed. For this, they have defined the different stops each student could walk to, considering that the distance between their house and a possible stop cannot be greater than a fixed distance.  
Figure 2 shows an example of the new problem for 8 students. The capacity of the buses is now 4 students. The dotted lines represent the stops each student can walk to. More specifically:
- Stop S1 can be used by the students A1, A2, A3, A4 and A5.
- Stop S2 can be used by the students A4 and A5.
- Stop S3 can be used by the students A4, A5, A6, A7 and A8.

The school board has family information for each student, so they can easily determine if a group of students are siblings. If a group of students are siblings, the must always be assigned to the same stop. In this example, A4 and A5 are siblings. Since siblings must be assigned to the same stop and the number of students in one stop cannot be greater than the bus capacity, A4 and A5 must be assigned to S2. If they weren’t siblings, one could be assigned to S1 and the other to S2, making a trip to S2 not mandatory.

![Figure 2](img/ex2_graph.svg)

The new solution must determine both the routes as the bus stop assigned to each student.  
You must:
- Model the problem described in part 2 as a Linear Programming task. To do this, take the model from Part 1 and make the necessary modifications ([Modelling P2](#modelling-p2)).
- Implement the model from Part 1 in MathProg. This model will help you get familiar with MathProg’s syntax before implementing the model from Part 2. The model for Part 1 must be general enough to allow solving problems different from the one shown in 1 with the least possible modifications. In fact, these modifications should be carried out in the data file `part-1/data.dat`, without making any modifications to the model file `part-1/model.mod`.
- Once the model from Part 1 has been implemented in MathProg, it is request to perform the necessary modifications to include the problem described in Part 2. Again, the model for Part 2 (`part-1/model.mod`) must be general enough to allow solving problems different than the one in Figure 2 by changing `part-2/data.dat`.

#### Modelling P2
Set of stops:  
![](https://latex.codecogs.com/svg.image?S=%5C%7BO,%5C%20S1,%5C%20S2,%5C%20S3,%5C%20F%5C%7D)  
Set of stops with passengers:  
![](https://latex.codecogs.com/svg.image?P=%5C%7BS1,%5C%20S2,%5C%20S3%5C%7D)  
**Decistion variable** - edge between stop i and stop j:  
![](https://latex.codecogs.com/svg.image?A_%7Bij%7D%5Cin%20%5C%7B0,%5C%201%5C%7D;%20i,j%5Cin%20S)  
**Decistion variable** - flux between stop i and stop j:  
![](https://latex.codecogs.com/svg.image?F_{ij}\in&space;F;&space;i,j\in&space;S)  
![](https://latex.codecogs.com/svg.image?F_{ij}\in&space;\mathbb{N};&space;F\in&space;P\times&space;P)  
Students in stop k:  
![](https://latex.codecogs.com/svg.image?p_{k}\in&space;\mathbb{N};&space;k\in&space;P)  
Cost of edge k:  
![](https://latex.codecogs.com/svg.image?a_{k}\in&space;\mathbb{N};&space;k&space;\in&space;[1,9]\subset&space;\mathbb{N})  
Cost of going from i to j:  
![](https://latex.codecogs.com/svg.image?C_{ij}\in&space;\mathbb{N})  
![](https://latex.codecogs.com/svg.image?C_%7Bif%7D=%5Cinfty%5C%20iff%5C%20there%5C%20is%5C%20no%5C%20edge%5C%20from%5C%20i%5C%20to%5C%20j)   
![](https://latex.codecogs.com/svg.image?C\in&space;P\times&space;P)  
![](https://latex.codecogs.com/svg.image?C=%5Cbegin%7Bbmatrix%7D%5Cinfty%20&%20a_%7B1%7D%20&%20a_%7B2%7D%20&%20a_%7B3%7D%20&%20%5Cinfty%20%5C%5C%5Cinfty%20&%20%5Cinfty%20&%20a_%7B4%7D%20&%20a_%7B5%7D%20&%20a_%7B6%7D%20%5C%5C%5Cinfty%20&%20a_%7B4%7D%20&%20%5Cinfty%20&%20a_%7B7%7D%20&%20a_%7B8%7D%20%5C%5C%5Cinfty%20&%20a_%7B5%7D%20&%20a_%7B7%7D%20&%20%5Cinfty%20&%20a_%7B9%7D%20%5C%5C%5Cinfty%20&%20%5Cinfty%20&%20%5Cinfty%20&%20%5Cinfty%20&%20%5Cinfty%20%5C%5C%5Cend%7Bbmatrix%7D)  
Cost per bus:  
![](https://latex.codecogs.com/svg.image?b%5Cin%20%5Cmathbb%7BN%7D)  
Cost per km:  
![](https://latex.codecogs.com/svg.image?c%5Cin%20%5Cmathbb%7BN%7D)  
Capacity of each bus:  
![](https://latex.codecogs.com/svg.image?d%5Cin%20%5Cmathbb%7BN%7D)  
Set of students:  
![](https://latex.codecogs.com/svg.image?H=%5C%7Bh_%7B1%7D,%5C%20h_%7B2%7D,%5C%20h_%7B3%7D,%5C%20h_%7B4%7D,%5C%20h_%7B5%7D,%5C%20h_%7B6%7D,%5C%20h_%7B7%7D,%5C%20h_%7B8%7D%5C%7D)  
Possible stops j for each student i:  
![](https://latex.codecogs.com/svg.image?G_%7Bij%7D%5Cin%20%5C%7B0,%5C%201%5C%7D)  
![](https://latex.codecogs.com/svg.image?G%5Cin%20H%5Ctimes%20P)  
**Decistion variable** - possible stops j for each student i:  
![](https://latex.codecogs.com/svg.image?M_%7Bij%7D%5Cin%20%5C%7B0,%5C%201%5C%7D)  
![](https://latex.codecogs.com/svg.image?M%5Cin%20H%5Ctimes%20P)  
Student i is sibling of student j:  
![](https://latex.codecogs.com/svg.image?R_%7Bij%7D%5Cin%20%5C%7B0,%5C%201%5C%7D)  
![](https://latex.codecogs.com/svg.image?R%5Cin%20H%5Ctimes%20H)  

---
![](https://latex.codecogs.com/svg.image?min%5C%20Z=c%5Ccdot%20%5Csum_%7Bi,j%5Cin%20S%7DC_%7Bij%7D%5Ccdot%20A_%7Bij%7D&plus;b%5Csum_%7Bj%5Cin%20S%7DA_%7BOj%7D)  

![](https://latex.codecogs.com/svg.image?s.t.)  
![1](https://latex.codecogs.com/svg.image?(1)%5C%20%5Cforall%20i%5Cin%20P,%5Csum_%7Bk%5Cin%20S%7DA_%7Bik%7D=1)  
![2](https://latex.codecogs.com/svg.image?(2)%5C%20%5Cforall%20j%5Cin%20P,%5Csum_%7Bk%5Cin%20S%7DA_%7Bik%7D=1)  
![3](https://latex.codecogs.com/svg.image?(3)%5C%20%5Csum_%7Bj%5Cin%20S%7DA_%7BOj%7D=%5Csum_%7Bi%5Cin%20S%7DA_%7BiF%7D)  
![4](https://latex.codecogs.com/svg.image?(4)%5C%20%5Cforall%20i%5Cin%20P,%5Csum_%7Bk%5Cin%20S%7DF_%7Bik%7D=%5Csum_%7Bi%5Cin%20H%7DM_%7Bli%7D&plus;%5Csum_%7Bj%5Cin%20P%7DF_%7Bji%7D)  
![5](https://latex.codecogs.com/svg.image?(5)%5C%20%5Cforall%20i,j%5Cin%20S,F_%7Bij%7D%5Cleq%20d%5Ccdot%20A_%7Bij%7D)  
![6](https://latex.codecogs.com/svg.image?(6)%5C%20%5Cforall%20i%5Cin%20H,%5C%20%5Cforall%20j%5Cin%20P,%5C%20M_%7Bij%7D%5Cleq%20G_%7Bij%7D)  
![7](https://latex.codecogs.com/svg.image?(7)%5C%20%5Cforall%20k%5Cin%20H,%5C%20%5Csum_%7Bj%5Cin%20P%7DM_%7Bkj%7D=1)  
![8](https://latex.codecogs.com/svg.image?(8)%5C%20%5Cforall%20k%5Cin%20P,%5C%20%5Cforall%20i,j%5Cin%20H,%5C%20R_%7Bij%7D%5Ccdot%20(M_%7Bik%7D-M_%7Bjk%7D)=0)  

![](https://latex.codecogs.com/svg.image?(I)%5C%20F_%7Bij%7D%5Cgeq%200;%20i,j%5Cin%20S;%20F_%7Bij%7D%5Cin%20%5Cmathbb%7BN%7D)  
![](https://latex.codecogs.com/svg.image?(II)%5C%20M_%7Bij%7D%5Cgeq%200;%5C%20i%5Cin%20H,%5C%20j%5Cin%20P;%5C%20M_%7Bij%7D%5Cin%20%5C%7B0,%5C%201%5C%7D)

#### Solution P2
The solution is Z* = 585:
![Figure 1](img/ex2_sol_graph.svg)

### Part 3: Analysis of the results
All results obtained in the previous sections have to be analyzed in this section. The solutions obtained must be described (verifying that all constraints from the statement are met) and which constraints are more relevant must be identified.  
You must also analyze complexity: how many variables were defined? How many constraints were defined? Create new problems for Part 1 and Part 2. Explain the new solutions found for these problems and explain how the modifications affect the difficulty of solving them.  

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