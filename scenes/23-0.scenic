# Expert 1:
"""
1. The main objects that need to be included in the scene are:
   - Self-driving vehicle (modeled as a 2017 Lincoln MKZ)
   - Bicycle
2. The spatial relationships between the objects are:
   - The self-driving vehicle is traveling along Maple Street and approaching the junction of Elmwood Avenue and Oak Lane.
   - The bicycle is positioned on Oak Lane, with a safety distance of 10 meters required between it and the vehicle.
   - Both the vehicle and the bicycle are moving.
3. The events in the scene are:
   - The self-driving vehicle follows a prescribed trajectory along Maple Street.
   - Upon approaching the junction, the vehicle detects the bicycle with a speed exceeding 1.5 m/s and initiates a braking action.
   - The vehicle maintains a safety distance of 10 meters from the bicycle.
   - The scenario concludes as the vehicle moves beyond 50 meters from its initial position on Maple Street.
   The Linear Temporal Logic (LTL) formula capturing these events is:
   G(vehicle.follows_trajectory -> F(vehicle.brakes_at_bicycle -> G(vehicle.maintains_safety_distance -> F(vehicle.moves_beyond_50m)))
4. Details missing from the description:
   - Specific trajectory of the vehicle
   - Exact location of the junction of Elmwood Avenue and Oak Lane
   - Speed and direction of the bicycle
   - Lane change behavior of the vehicle at the junction
5. Probability distribution over missing values:
   - Trajectory of the vehicle: Normal distribution over possible trajectories
   - Speed of the bicycle: Normal distribution with mean 1.5 m/s and standard deviation
   - Lane change behavior: Uniform distribution over available options
6. Based on the distributions, the appropriate distribution types supported in Scenic are Normal and Uniform.
7. Based on the scene description, the map "Town01" is the most suitable.
8. The behaviors needed for this scene are FollowTrajectoryBehavior for the vehicle and CrossingBehavior for the bicycle.
"""

---------------------------------------------------------------------------------------------------------------
# Expert 2:
"""
1. The main objects that need to be included in the scene are:
   - A self-driving vehicle modeled as a 2017 Lincoln MKZ
   - A bicycle
2. The spatial relationships between the objects are:
   - The vehicle is executing a prescribed trajectory along Maple Street.
   - The bicycle is positioned on Oak Lane, with a safety distance of 10 meters from the vehicle.
   - Both the vehicle and the bicycle are moving.
3. The events in the scene are:
   - The vehicle follows traffic rules and smoothly transitions between lanes.
   - It activates a braking action upon detecting the bicycle with a speed exceeding 1.5 m/s at a safety distance of 10 meters.
   - The scenario concludes as the vehicle moves beyond 50 meters from its initial position on Maple Street.
   The Linear Temporal Logic (LTL) formula capturing these events is:
   G(vehicle.follows_rules -> F(vehicle.brakes_at_bicycle -> G(vehicle.maintains_safety_distance -> F(vehicle.moves_beyond_50m)))
4. Details missing from the description:
   - Specific traffic rules followed by the vehicle
   - Transition details between lanes
   - Lane change behavior at intersections
   - Speed and direction of the bicycle
5. Probability distribution over missing values:
   - Traffic rules: Discrete distribution over common traffic rules with equal weights
   - Speed of the bicycle: Normal distribution with mean 1.5 m/s and standard deviation
   - Lane change behavior: Uniform distribution over available options
6. Based on the distributions, the appropriate distribution types supported in Scenic are Discrete and Normal.
7. Based on the scene description, the map "Town01" is the most suitable.
8. The behaviors needed for this scene are FollowTrajectoryBehavior for the vehicle and CrossingBehavior for the bicycle.
"""

---------------------------------------------------------------------------------------------------------------
# Expert 3:
"""
1. The main objects that need to be included in the scene are:
   - A self-driving vehicle (2017 Lincoln MKZ)
   - A bicycle
2. The spatial relationships between the objects are:
   - The vehicle is following a prescribed trajectory along Maple Street.
   - The bicycle is located on Oak Lane with a safety distance of 10 meters from the vehicle.
   - Both the vehicle and the bicycle are in motion.
3. The events in the scene are:
   - The vehicle adheres to traffic rules and smoothly transitions between lanes.
   - It activates a braking action upon detecting the bicycle with a speed exceeding 1.5 m/s at a safe distance of 10 meters.
   - The scenario concludes as the vehicle moves beyond 50 meters from its initial position on Maple Street.
   The Linear Temporal Logic (LTL) formula capturing these events is:
   G(vehicle.traffic_rules -> F(vehicle.brakes_at_bicycle -> G(vehicle.maintains_safety_distance -> F(vehicle.moves_beyond_50m)))
4. Details missing from the description:
   - Specific traffic rules followed by the vehicle
   - Lane transition details
   - Bicycle speed and direction
   - Lane change behavior at intersections
5. Probability distribution over missing values:
   - Traffic rules: Discrete distribution over common traffic rules with equal weights
   - Speed of the bicycle: Normal distribution with mean 1.5 m/s and standard deviation
   - Lane change behavior: Uniform distribution over available options
6. Based on the distributions, the appropriate distribution types supported in Scenic are Discrete and Normal.
7. Based on the scene description, the map "Town01" is the most suitable.
8. The behaviors needed for this scene are FollowTrajectoryBehavior for the vehicle and CrossingBehavior for the bicycle.
"""

---------------------------------------------------------------------------------------------------------------