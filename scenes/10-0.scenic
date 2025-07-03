# Expert 1:

#-------------------------------------------------------------------------------
# Based on the description, what are the main objects that need to be included in the scene?
# - self-driving car (2017 Lincoln MKZ)
# - bicycle
# - intersection (Elmwood Avenue and Oak Lane)
# - lanes (Maple Street, Elmwood Avenue, Oak Lane)
# - distance measurement points
# - safety distance (10 meters)
# - braking action
# - speed threshold for the bicycle (1.5 m/s)
# - distance threshold (10 meters from the bicycle)
# - initial and final positions of the self-driving car
# - trajectory path of the self-driving car
# - vigilant behavior of the self-driving car
# - braking action upon detecting the bicycle

# The objects like buildings, trees, etc., mentioned in the natural language description are not relevant for this scenario.

#-------------------------------------------------------------------------------
# What are the spacial relationships between the objects?
# - The self-driving car is approaching the intersection of Elmwood Avenue and Oak Lane.
# - The bicycle is positioned on Oak Lane.
# - The self-driving car maintains a safety distance of 10 meters from the bicycle.
# - The scenario starts on Maple Street and concludes beyond 50 meters from the initial position on Maple Street.

# The self-driving car and bicycle are moving.
# The self-driving car is visible to detect the bicycle.

#-------------------------------------------------------------------------------
# What are the events that happened in the scene?
# - Self-driving car executed a prescribed trajectory on Maple Street.
# - Approached the junction of Elmwood Avenue and Oak Lane.
# - Detected a bicycle with a speed exceeding 1.5 m/s on Oak Lane.
# - Activated braking action to ensure a safety distance of 10 meters from the bicycle.
# - Moved beyond 50 meters from the initial position on Maple Street.

# Linear Temporal Logic (LTL) formula:
# G(self-driving car.braking -> F(bicycle visible && self-driving car.distanceTo(bicycle) < 10))

#-------------------------------------------------------------------------------
# What details are missing from the description that you would need to ask the author about in order to create a more accurate scene?
# - Initial speed of the self-driving car
# - Specific lane changes or turns
# - Lane widths and markings
# - Traffic light status at the intersection
# - Specific trajectory path
# - Bicycle color and type
# - Weather conditions

# I would need to ask about the specific lane and intersection details to accurately place the objects in the scene.

#-------------------------------------------------------------------------------
# For your answers to question 4, provide a reasonable probability distribution over the missing values.
# - Initial speed of the self-driving car: Normal distribution with mean 10 m/s and std dev 1 m/s
# - Specific lane changes or turns: Discrete choice between left turn, right turn, or straight
# - Bicycle color: Uniform distribution over common bicycle colors (e.g., red, blue, black, white)
# - Weather conditions: Discrete choice between sunny, cloudy, rainy

# These distributions will add variability to the scenario while remaining realistic.

#-------------------------------------------------------------------------------
# Based on your answers to question 5, pick from the list of distributions supported in Scenic:
# - Normal(mean, std) - Normal distribution with mean and standard deviation

#-------------------------------------------------------------------------------
# Based on the scene description, pick a map from the list provided:
# Town01 - a small town with numerous T-junctions and a variety of buildings, surrounded by coniferous trees and small bridges spanning a river.

# Town01 seems to fit the urban setting described in the scenario.

#-------------------------------------------------------------------------------
# Based on your answer to question 3, which behaviors do you think you will need to use in your Scenic program?
# - FollowTrajectoryBehavior for the self-driving car
# - CrossingBehavior for the bicycle
# - SetBrakeAction for the self-driving car when detecting the bicycle

# These behaviors will help simulate the prescribed trajectory and vigilant braking behavior.

#-------------------------------------------------------------------------------
# My Scenic Program:
# Define the parameters and imports here

# ----------------------------------------------------------------------------------
# Scene Setup and Geometry

# Define the scene setup and geometry here

# ----------------------------------------------------------------------------------
# Scenario Dynamics

# Define the scenario dynamics here

# ----------------------------------------------------------------------------------
# Placement and Spatial Relationships

# Define the placement and spatial relationships of agents here

# ----------------------------------------------------------------------------------
# Last require and terminate statements

# Define the last require and terminate statements here

#-------------------------------------------------------------------------------
# Review:
# - The program uses the correct file path for the map.
# - It uses one of the maps listed (Town01).
# - The syntax follows Scenic conventions.
# - Strings are enclosed in double quotes.
# - The program uses the correct behaviors defined for vehicles.
# - The parameters for the behaviors are appropriate.
# - It uses the supported distribution types in Scenic.
# - The distribution parameters are reasonable.
# - The code reflects the natural language description accurately. 

#-------------------------------------------------------------------------------

# Expert 2:

#-------------------------------------------------------------------------------
# Based on the description, what are the main objects that need to be included in the scene?
# - self-driving car (2017 Lincoln MKZ)
# - bicycle
# - intersection of Elmwood Avenue and Oak Lane
# - lanes (Maple Street, Elmwood Avenue, Oak Lane)
# - safety distance (10 meters)
# - braking action
# - speed threshold for the bicycle (1.5 m/s)
# - vigilant behavior of the self-driving car
# - trajectory path of the self-driving car

# The scene involves dynamic objects like the self-driving car and the bicycle.

#-------------------------------------------------------------------------------
# What are the spacial relationships between the objects?
# - The self-driving car is moving along Maple Street.
# - The bicycle is on Oak Lane.
# - The self-driving car activates braking upon detecting the bicycle.
# - The self-driving car maintains a safety distance of 10 meters from the bicycle.
# - The scenario concludes beyond 50 meters from the initial position on Maple Street.

# The self-driving car and bicycle are moving.
# The self-driving car's behavior is vigilant near the intersection.

#-------------------------------------------------------------------------------
# What are the events that happened in the scene?
# - Self-driving car executes a trajectory on Maple Street.
# - Approaches the Elmwood Avenue and Oak Lane intersection.
# - Activates braking action upon detecting the bicycle.
# - Maintains a safety distance of 10 meters from the bicycle.
# - Scenario concludes after moving beyond 50 meters from the initial position.

# LTL formula: G(self-driving car.braking -> F(bicycle.visible && self-driving car.distanceTo(bicycle) < 10))

#-------------------------------------------------------------------------------
# What details are missing from the description that you would need to ask the author about in order to create a more accurate scene?
# - Initial speed of the self-driving car
# - Specific trajectory path
# - Lane markings and widths
# - Traffic light status at the intersection
# - Bicycle color and type
# - Weather conditions

# These details would enhance the realism and accuracy of the simulation.

#-------------------------------------------------------------------------------
# For your answers to question 4, provide a reasonable probability distribution over the missing values.
# - Initial speed of the self-driving car: Normal distribution with mean 10 m/s and std dev 1 m/s
# - Specific trajectory path: Discrete choice between different lane maneuvers
# - Bicycle color: Uniform distribution over common bicycle colors (e.g., red, blue, black, white)
# - Weather conditions: Discrete choice between sunny, cloudy, rainy

# These distributions introduce variability while staying within realistic bounds.

#-------------------------------------------------------------------------------
# Based on your answers to question 5, pick from the list of distributions supported in Scenic:
# - Normal(mean, std) - Normal distribution with mean and standard deviation

#-------------------------------------------------------------------------------
# Based on the scene description, pick a map from the list provided:
# Town01 - a small town with numerous T-junctions and a variety of buildings, surrounded by coniferous trees and small bridges.

# Town01 aligns with the urban setting described in the scenario.

#-------------------------------------------------------------------------------
# Based on your answer to question 3, which behaviors do you think you will need to use in your Scenic program?
# - FollowTrajectoryBehavior for the self-driving car
# - CrossingBehavior for the bicycle
# - SetBrakeAction for the self-driving car when detecting the bicycle

# These behaviors will simulate the trajectory execution, bicycle detection, and vigilant braking.

#-------------------------------------------------------------------------------
# My Scenic Program:
# Define the parameters and imports here

# ----------------------------------------------------------------------------------
# Scene Setup and Geometry

# Define the scene setup and geometry here

# ----------------------------------------------------------------------------------
# Scenario Dynamics

# Define the scenario dynamics here

# ----------------------------------------------------------------------------------
# Placement and Spatial Relationships

# Define the placement and spatial relationships of agents here

# ----------------------------------------------------------------------------------
# Last require and terminate statements

# Define the last require and terminate statements here

#-------------------------------------------------------------------------------
# Review:
# - The program uses the correct file path for the map.
# - It uses one of the maps listed (Town01).
# - The syntax follows Scenic conventions.
# - Strings are enclosed in double quotes.
# - The program uses the correct behaviors defined for vehicles.
# - The parameters for the behaviors are appropriate.
# - It uses the supported distribution types in Scenic.
# - The distribution parameters are reasonable.
# - The code accurately reflects the natural language description. 

#-------------------------------------------------------------------------------

# Expert 3:

#-------------------------------------------------------------------------------
# Based on the description, what are the main objects that need to be included in the scene?
# - self-driving car (2017 Lincoln MKZ)
# - bicycle
# - intersection of Elmwood Avenue and Oak Lane
# - lanes (Maple Street, Elmwood Avenue, Oak Lane)
# - safety distance (10 meters)
# - braking action
# - speed threshold for the bicycle (1.5 m/s)
# - vigilant behavior of the self-driving car
# - trajectory path of the self-driving car

# The relevant objects in the scene involve dynamic entities like the self-driving car and the bicycle.

#-------------------------------------------------------------------------------
# What are the spacial relationships between the objects?
# - The self-driving car moves along Maple Street.
# - The bicycle is located on Oak Lane.
# - The self-driving car activates braking upon detecting the bicycle.
# - A safety distance of 10 meters is maintained from the bicycle.
# - The scenario concludes after moving beyond 50 meters from the initial position on Maple Street.

# Both the self-driving car and bicycle are in motion.
# The self-driving car exhibits vigilant behavior near the intersection.

#-------------------------------------------------------------------------------
# What are the events that happened in the scene?
# - Self-driving car executes a trajectory on Maple Street.
# - Approaches the Elmwood Avenue and Oak Lane intersection.
# - Activates braking action upon detecting the bicycle.
# - Maintains a safety distance of 10 meters from the bicycle.
# - Scenario concludes after moving beyond 50 meters from the initial position.

# LTL formula: G(self-driving car.braking -> F(bicycle.visible && self-driving car.distanceTo(bicycle) < 10))

#-------------------------------------------------------------------------------
# What details are missing from the description that you would need to ask the author about in order to create a more accurate scene?
# - Initial speed of the self-driving car
# - Specific trajectory path
# - Lane markings and widths
# - Traffic light status at the intersection
# - Bicycle color and type
# - Weather conditions

# These details would enhance the realism and accuracy of the simulation.

#-------------------------------------------------------------------------------
# For your answers to question 4, provide a reasonable probability distribution over the missing values.
# - Initial speed of the self-driving car: Normal distribution with mean 10 m/s and std dev 1 m/s
# - Specific trajectory path: Discrete choice between different lane maneuvers
# - Bicycle color: Uniform distribution over common bicycle colors (e.g., red, blue, black, white)
# - Weather conditions: Discrete choice between sunny, cloudy, rainy

# These distributions introduce variability while remaining within realistic bounds.

#-------------------------------------------------------------------------------
# Based on your answers to question 5, pick from the list of distributions supported in Scenic:
# - Normal(mean, std) - Normal distribution with mean and standard deviation

#-------------------------------------------------------------------------------
# Based on the scene description, pick a map from the list provided:
# Town01 - a small town with numerous T-junctions and a variety of buildings, surrounded by coniferous trees and small bridges.

# Town01 fits the urban setting described in the scenario.

#-------------------------------------------------------------------------------
# Based on your answer to question 3, which behaviors do you think you will need to use in your Scenic program?
# - FollowTrajectoryBehavior for the self-driving car
# - CrossingBehavior for the bicycle
# - SetBrakeAction for the self-driving car when detecting the bicycle

# These behaviors will help simulate the trajectory execution, bicycle detection, and vigilant braking.

#-------------------------------------------------------------------------------
# My Scenic Program:
# Define the parameters and imports here

# ----------------------------------------------------------------------------------
# Scene Setup and Geometry

# Define the scene setup and geometry here

# ----------------------------------------------------------------------------------
# Scenario Dynamics

# Define the scenario dynamics here

# ----------------------------------------------------------------------------------
# Placement and Spatial Relationships

# Define the placement and spatial relationships of agents here

# ----------------------------------------------------------------------------------
# Last require and terminate statements

# Define the last require and terminate statements here

#-------------------------------------------------------------------------------
# Review:
# - The program uses the correct file path for the map.
# - It uses one of the maps listed (Town01).
# - The syntax follows Scenic conventions.
# - Strings are enclosed in double quotes.
# - The program uses the correct behaviors defined for vehicles.
# - The parameters for the behaviors are appropriate.
# - It uses the supported distribution types in Scenic.
# - The distribution parameters are reasonable.
# - The code accurately reflects the natural language description.

#-------------------------------------------------------------------------------