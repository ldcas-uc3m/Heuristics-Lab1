# part 1 general model

# sets
set EDGES;
set STOPS;
set STOP_PASSENGERS;  # stops w/ passengers

# parameters
param p {s in STOPS};  # students on stop
param a {x in EDGES};  # cost of edge
param b;  # cost per bus
param c;  # cost per km
param d;  # capacity per bus

# decision variables
var x {k in EDGES};

# objective function
minimize cost:
    c * (sum {k in EDGES} a[k] * x[k]) + b * (sum)