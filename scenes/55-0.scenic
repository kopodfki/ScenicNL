# Expert 1:
"""
1. The main objects that need to be included in the scene are a self-driving car (modeled as a Lincoln MKZ), a lead car, an obstacle (trash), and the road.
2. The self-driving car is following behind the lead car, maintaining a safe distance. The obstacle is randomly placed on the lane of the self-driving car. The lead car is following the road ahead.
3. Events: The self-driving car maintains its speed until it detects the obstacle and initiates a braking action. The lead car follows the lane and brakes upon nearing an obstacle. The self-driving car's speed drops to almost zero as it approaches the obstacle.
   LTL formula: G((ego.speed < 0.1) -> (distance to obstacle < 30))
4. Missing details: The color of the vehicles, specific dimensions of the road, the weather conditions, and the exact behavior of the lead car.
5. Probability distributions:
   - Vehicle color: Uniform distribution over common car colors
   - Vehicle speed: Normal distribution around 10 mph with a standard deviation of 1 mph
   - Distance to obstacle: Normal distribution with mean 25 meters and standard deviation of 5 meters
6. Distributions:
   - Vehicle color: Discrete distribution
   - Vehicle speed: Normal distribution
   - Distance to obstacle: Normal distribution
7. Map selection: Town01
8. Behaviors needed: FollowLaneBehavior, SetBrakeAction

-------------------------------------------------------------------------------------------------------
# My Scenic Program:

param map = localPath('../../../assets/maps/CARLA/Town01.xodr')
param carla_map = 'Town01'
model scenic.simulators.carla.model

EGO_MODEL = "vehicle.lincoln.mkz_2017"
EGO_SPEED = Normal(10, 1)
EGO_BRAKING_THRESHOLD = 12

LEAD_CAR_SPEED = Normal(10, 1)
LEADCAR_BRAKING_THRESHOLD = 10

BRAKE_ACTION = 1.0

behavior EgoBehavior(speed=10):
    try:
        do FollowLaneBehavior(speed)

    interrupt when withinDistanceToAnyCars(self, EGO_BRAKING_THRESHOLD):
        take SetBrakeAction(BRAKE_ACTION)

behavior LeadingCarBehavior(speed=10):
    try: 
        do FollowLaneBehavior(speed)

    interrupt when withinDistanceToAnyObjs(self, LEADCAR_BRAKING_THRESHOLD):
        take SetBrakeAction(BRAKE_ACTION)

lane = Uniform(*network.lanes)
obstacle = new Trash on lane.centerline

leadCar = new Car following roadDirection from obstacle for Range(-50, -30),
        with behavior LeadingCarBehavior(LEAD_CAR_SPEED)

ego = new Car following roadDirection from leadCar for Range(-15, -10),
        with blueprint EGO_MODEL,
        with behavior EgoBehavior(EGO_SPEED)

require (distance to intersection) > 80
terminate when ego.speed < 0.1 and (distance to obstacle) < 30
-------------------------------------------------------------------------------------------------------
"""

# Expert 2:
"""
1. The main objects are a self-driving car (2017 Lincoln MKZ), a lead car, an obstacle (trash), and the road infrastructure.
2. The self-driving car follows the lead car at a safe distance and detects the trash obstacle on its lane. The lead car follows the road and brakes near an obstacle.
3. Events: The self-driving car maintains speed, detects obstacle, initiates braking, lead car follows road, brakes near obstacle, self-driving car slows down near obstacle.
   LTL formula: G((ego.speed < 0.1) -> (distance to obstacle < 30))
4. Missing details: Lane markings, specific obstacle placement, lead car's exact braking behavior.
5. Probability distributions:
   - Lane markings color: Uniform distribution over common road colors
   - Obstacle placement: Normal distribution around lane centerline
   - Lead car braking threshold: Normal distribution around 10 meters with a standard deviation of 1 meter
6. Distributions:
   - Lane markings color: Discrete distribution
   - Obstacle placement: Normal distribution
   - Lead car braking threshold: Normal distribution
7. Map selection: Town01
8. Behaviors needed: FollowLaneBehavior, SetBrakeAction

-------------------------------------------------------------------------------------------------------
# My Scenic Program:

param map = localPath('../../../assets/maps/CARLA/Town01.xodr')
param carla_map = 'Town01'
model scenic.simulators.carla.model

EGO_MODEL = "vehicle.lincoln.mkz_2017"
EGO_SPEED = 10
EGO_BRAKING_THRESHOLD = Normal(12, 1)

LEAD_CAR_SPEED = 10
LEADCAR_BRAKING_THRESHOLD = Normal(10, 1)

BRAKE_ACTION = 1.0

behavior EgoBehavior(speed=10):
    try:
        do FollowLaneBehavior(speed)

    interrupt when withinDistanceToAnyCars(self, EGO_BRAKING_THRESHOLD):
        take SetBrakeAction(BRAKE_ACTION)

behavior LeadingCarBehavior(speed=10):
    try: 
        do FollowLaneBehavior(speed)

    interrupt when withinDistanceToAnyObjs(self, LEADCAR_BRAKING_THRESHOLD):
        take SetBrakeAction(BRAKE_ACTION)

lane = Uniform(*network.lanes)
obstacle = new Trash on lane.centerline

leadCar = new Car following roadDirection from obstacle for Range(-50, -30),
        with behavior LeadingCarBehavior(LEAD_CAR_SPEED)

ego = new Car following roadDirection from leadCar for Range(-15, -10),
        with blueprint EGO_MODEL,
        with behavior EgoBehavior(EGO_SPEED)

require (distance to intersection) > 80
terminate when ego.speed < 0.1 and (distance to obstacle) < 30
-------------------------------------------------------------------------------------------------------
"""

# Expert 3:
"""
1. Main objects: self-driving car (Lincoln MKZ), lead car, obstacle (trash), road infrastructure.
2. Spatial relationships: Self-driving car follows lead car at a safe distance, obstacle placed on self-driving car's lane, lead car follows road and brakes near obstacle.
3. Events: Self-driving car maintains speed, detects obstacle, initiates braking, lead car follows road, brakes near obstacle, self-driving car slows down near obstacle.
   LTL formula: G((ego.speed < 0.1) -> (distance to obstacle < 30))
4. Details missing: Lane markings, exact obstacle position, lead car's braking strategy.
5. Probability distributions:
   - Lane markings color: Uniform distribution over common road colors
   - Obstacle position: Normal distribution around lane centerline
   - Lead car braking threshold: Normal distribution around 10 meters with a standard deviation of 1 meter
6. Distributions:
   - Lane markings color: Discrete distribution
   - Obstacle position: Normal distribution
   - Lead car braking threshold: Normal distribution
7. Map choice: Town01
8. Behaviors needed: FollowLaneBehavior, SetBrakeAction

-------------------------------------------------------------------------------------------------------
# My Scenic Program:

param map = localPath('../../../assets/maps/CARLA/Town01.xodr')
param carla_map = 'Town01'
model scenic.simulators.carla.model

EGO_MODEL = "vehicle.lincoln.mkz_2017"
EGO_SPEED = 10
EGO_BRAKING_THRESHOLD = Normal(12, 1)

LEAD_CAR_SPEED = 10
LEADCAR_BRAKING_THRESHOLD = Normal(10, 1)

BRAKE_ACTION = 1.0

behavior EgoBehavior(speed=10):
    try:
        do FollowLaneBehavior(speed)

    interrupt when withinDistanceToAnyCars(self, EGO_BRAKING_THRESHOLD):
        take SetBrakeAction(BRAKE_ACTION)

behavior LeadingCarBehavior(speed=10):
    try: 
        do FollowLaneBehavior(speed)

    interrupt when withinDistanceToAnyObjs(self, LEADCAR_BRAKING_THRESHOLD):
        take SetBrakeAction(BRAKE_ACTION)

lane = Uniform(*network.lanes)
obstacle = new Trash on lane.centerline

leadCar = new Car following roadDirection from obstacle for Range(-50, -30),
        with behavior LeadingCarBehavior(LEAD_CAR_SPEED)

ego = new Car following roadDirection from leadCar for Range(-15, -10),
        with blueprint EGO_MODEL,
        with behavior EgoBehavior(EGO_SPEED)

require (distance to intersection) > 80
terminate when ego.speed < 0.1 and (distance to obstacle) < 30
-------------------------------------------------------------------------------------------------------
"""

# Final Consensus:
"""
The program uses the correct file path for the map and selects Town01. It follows proper Scenic syntax with strings enclosed in double quotes. The behaviors used are defined and appropriate parameters are utilized. The distributions types and parameters align with the requirements. The code reflects the natural language description accurately.
"""