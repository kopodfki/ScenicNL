# Expert 1:
"""
1. The main objects that need to be included in the scene are a Cruise autonomous vehicle ("AV"), a blue Model 3 Tesla, a parking garage, and the damaged areas on the AV (front bumper fascia and front passenger side wheel opening molding).
2. The AV is traveling northbound on 2nd Street between Stillman Street and Bryant Street. The Model 3 Tesla exits out of a parking garage into the AV's lane. The AV brakes and makes contact with the Model 3 Tesla, damaging the AV's front bumper fascia and front passenger side wheel opening molding. The driver of the Model 3 Tesla leaves the scene. There are no reported injuries.
3. Events: AV traveled northbound, encountered the Model 3 Tesla, braked, made contact with the Model 3 Tesla, damage occurred, driver of the Model 3 Tesla left the scene, no reported injuries.
   LTL formula: G( AV.northbound -> F(Model3Tesla.contact) -> F(damage) -> F(Model3Tesla.driverLeft))
4. Details missing: Color of the AV, color of the Model 3 Tesla, time of day, weather conditions, speed of the AV, distance between AV and the Model 3 Tesla.
5. Probability distributions:
   - Color of AV: Uniform distribution over common car colors
   - Color of Model 3 Tesla: Uniform distribution over common car colors
   - Time of day: Normal distribution with mean = 12pm, std = 3 hours
   - Weather conditions: Discrete distribution over [sunny: 0.6, cloudy: 0.3, rainy: 0.1]
   - Speed of AV: Normal distribution with mean around reasonable speed limit for the area
   - Distance between AV and Model 3 Tesla: Normal distribution with mean and std based on typical following distance
6. Distributions:
   - Color: Uniform distribution
   - Time of day: Normal distribution
   - Weather: Discrete distribution
   - Speed: Normal distribution
   - Distance: Normal distribution
7. Map: Town01
8. Behaviors needed: FollowLaneBehavior, SetBrakeAction, LaneChangeBehavior, CrossingBehavior
"""

-----------------------------------------------------------------------------------------------------------------------

# Expert 2:
"""
# My Scenic Program:

param map = localPath('../../../assets/maps/CARLA/Town01.xodr')
param carla_map = 'Town01'
model scenic.simulators.carla.model

--------------------------------------------------------------------------------
# Scene setup and geometry

AV_MODEL = "vehicle.cruise.autonomous"
TESLA_MODEL = "vehicle.tesla.model3.blue"

# Define behaviors
behavior AVBehavior(speed):
    do FollowLaneBehavior(speed)

behavior TeslaBehavior(speed):
    do FollowLaneBehavior(speed)

# Define initial positions
startPointAV = new OrientedPoint at 2nd Street between Stillman Street and Bryant Street
startPointTesla = new OrientedPoint out of a parking garage into AV lane

# Define damaged areas
damagedAreas = ["front bumper fascia", "front passenger side wheel opening molding"]

--------------------------------------------------------------------------------
# Scenario dynamics

# Events
AV_braked = AV detected Tesla and initiated braking action
Contact_occurred = AV made contact with Tesla
Driver_left = Driver of the Tesla left the scene

# LTL formula
G(AV_braked -> F(Contact_occurred) -> F(Driver_left))

--------------------------------------------------------------------------------
# Placement and spatial relationships

AV = new Car at startPointAV, with blueprint AV_MODEL, with behavior AVBehavior(10)
Tesla = new Car at startPointTesla, with blueprint TESLA_MODEL, with behavior TeslaBehavior(10)

--------------------------------------------------------------------------------
# Last require and terminate statements

require AV.direction == "north" and AV.location == "2nd Street"
require AV.distanceTo(Tesla) < 30
terminate when AV.speed < 0.1 and AV.distanceTo(Tesla) < 30

"""

"""
The program uses the correct file path for the map and selects Town01 from the list of maps. The Scenic syntax is proper, with strings enclosed in double quotes. The program uses the correct behaviors defined in Scenic and sets the parameters appropriately. It uses distribution types supported in Scenic with correct parameters. The code reflects the natural language description by including the main objects, spatial relationships, events, and necessary details to create the scene.
"""

-----------------------------------------------------------------------------------------------------------------------

# Expert 3:
"""
1. Main objects: Cruise autonomous vehicle, blue Model 3 Tesla, damaged areas on the AV (front bumper fascia, front passenger side wheel opening molding).
2. Spatial relationships: AV traveling northbound on 2nd Street between Stillman Street and Bryant Street. Tesla exiting a parking garage into AV's lane, causing contact. AV braking upon detecting Tesla. Driver of Tesla leaving the scene.
3. Events: AV traveling northbound, encountering Tesla, braking, contact with Tesla, damage to AV, driver of Tesla leaving the scene, no reported injuries.
   LTL formula: G(AV.northbound -> F(Tesla.contact) -> F(damage) -> F(Tesla.driverLeft))
4. Missing details: Color of vehicles, time of day, weather conditions, speed of AV, distance between AV and Tesla.
5. Probability distributions:
   - Color: Uniform distribution over common car colors
   - Time of day: Normal distribution around midday
   - Weather: Discrete distribution over [sunny: 0.6, cloudy: 0.3, rainy: 0.1]
   - Speed: Normal distribution with mean speed limit
   - Distance: Normal distribution based on typical following distance
6. Distributions:
   - Color: Uniform distribution
   - Time of day: Normal distribution
   - Weather: Discrete distribution
   - Speed: Normal distribution
   - Distance: Normal distribution
7. Map: Town01
8. Behaviors: FollowLaneBehavior, SetBrakeAction
"""

-----------------------------------------------------------------------------------------------------------------------