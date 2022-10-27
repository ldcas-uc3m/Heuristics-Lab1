# part 1 general model

# sets
set STOPS;
set STOP_PASSENGERS;  # stops w/ passengers

# parameters
param p {s in STOPS};  # students on stop
param costs {i in STOPS, j in STOPS};
param b;  # cost per bus
param c;  # cost per km
param d;  # capacity per bus

# decision variables
var A {i in STOPS, j in STOPS} binary;
var F {i in STOPS, j in STOPS} integer, >= 0;

# objective function
minimize cost:
    c * (sum {i in STOPS, j in STOPS} costs[i,j] * A[i,j]) + b * sum {j in STOPS} A['O',j];

s.t. 
    enter {i in STOP_PASSENGERS}: sum{k in STOPS} A[i,k] = 1;
    exit {j in STOP_PASSENGERS}: sum{k in STOPS} A[k,j] = 1;
    reach: sum{j in STOPS} A['O',j] = sum{i in STOPS} A[i,'F'];
    flux {i in STOP_PASSENGERS}: sum{k in STOPS} F[i,k] = p[i] + sum{j in STOPS} F[j,i];
    capacity {i in STOPS, j in STOPS}: F[i,j] <= d * A[i,j];

