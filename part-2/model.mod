# part 2 general model

# sets

set STOPS; # set of stops
set STOP_PASSENGERS;  # stops w/ passengers
set STUDENTS;  # set of students

# parameters

param p {s in STOPS};  # students in stop s

# cost of route from stop i to stop j,
# if there is no route from i to j, then costs[i,j] = 9999; a large value that will be ignored since we are minimizing
# if there is a route from i to j, then costs[i,j] = 1
param costs {i in STOPS, j in STOPS}; 

param possible_stops {i in STUDENTS, j in STOP_PASSENGERS}  binary; # possible stops j for each student i
param b;  # cost per bus
param c;  # cost per km
param d;  # capacity per bus

# student i is sibling of student j 
param siblings {i in STUDENTS, j in STUDENTS } binary; 

  
# decision variables
var A {i in STOPS, j in STOPS} binary; # A[i,j] = 1 if bus goes from stop i to stop j and 0 otherwise
var F {i in STOPS, j in STOPS} integer, >= 0 ; # Flux between stop i and stop j
var M {i in STUDENTS, j in STOP_PASSENGERS} binary; # Assignation of a student i to a stop j


# objective function
minimize cost:
    # To calculate the number of buses, we add up the values of the three edges that go out of stop O,
    # as there are only three possible routes and buses cannot share them.
    c * (sum {i in STOPS, j in STOPS} costs[i,j] * A[i,j]) + b * sum {j in STOPS} A['O',j]; 

s.t. 
   
    # Only one bus can enter a stop
    enter {i in STOP_PASSENGERS}: sum{k in STOPS} A[i,k] = 1; 

    # Only one bus can exit a stop
    exit {j in STOP_PASSENGERS}: sum{k in STOPS} A[k,j] = 1; 

    # The number of buses that enter the school must be equal to the number of buses that exit the parking lot
    reach: sum{j in STOPS} A['O',j] = sum{i in STOPS} A[i,'F']; 

    # The outgoing flux of a stop is the incoming flux plus the number of students at that stop
    flux {i in STOP_PASSENGERS}: sum{k in STOPS} F[i,k] = sum{l in STUDENTS} M[l,i] + sum{j in STOP_PASSENGERS} F[j,i];
   
    # The flux cannot exceed the maximum of the capacity of the bus if that edge is traversed
    capacity {i in STOPS, j in STOPS}: F[i,j] <= d * A[i,j]; 
    
    # For assigning a student to a stop, the stop must be possible for that student
    student_in_stop {i in STUDENTS, j in STOP_PASSENGERS}: M[i,j] <= possible_stops[i,j];

    # A student can only be assigned to one stop
    student_per_stop {k in STUDENTS}: sum{j in STOP_PASSENGERS} M[k,j] = 1;

    # If two students are siblings, they must be assigned to the same stop
    siblings_assignment {k in STOP_PASSENGERS, i in STUDENTS, j in STUDENTS}:  (M[i,k] - M[j,k]) * siblings[i,j] = 0;


