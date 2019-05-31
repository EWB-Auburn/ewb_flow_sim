# ewb_flow_sim

Numerical simulator for gravity-fed sprinkler systems.  
Written for the [Auburn University Student Chapter](https://wp.auburn.edu/ewb/) of [EWB-USA](https://www.ewb-usa.org).

## About
The Bolivia Team in the Auburn University chapter of EWB-USA has designed a gravity-fed sprinkler system, which is to be installed in Quesimpuco, Bolivia, during the team’s Summer 2019 trip. This system consists of a large concrete tank, which is filled with water from a stream catchment. Water from this tank flows through a network of glue-jointed PVC pipe to a set of impulse sprinkler heads, each of which is attached to the system by a garden hose.

This system must be able to deliver sufficient water flow to all of the sprinkler heads, while also maintaining enough pressure to allow each sprinkler head to function properly. This collection of Matlab functions and scripts aims to estimate of the stead-state head and flow at all points in the system.

These scripts are capable of solving any arbitrary pipe configuration, provided the following are true:
- The system draws water from a single source
- There are no cycles in the system topology
