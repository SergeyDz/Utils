Used additional components:
- nUnit 2.5.2 for testin
- log4net for log application errors/activities/tracing
- StyleCop 4.4


Projects List:
- Freedman.CodeProblem.DomainModel
	Domain Model including classes for business instances

- Freedman.CodeProblem.Services
	Services for business logic activity. 

- Freedman.CodeProblem.Services.Contracts
	Services contracts.

- Freedman.CodeProblem.Host
	Host for running application, user input and user output.

- Freedman.CodeProblem.DomainModel.Test
	Test of domain model.

- Freedman.CodeProblem.Services.Test
	Test of services.

Bin Output folder contains project binaries. 
Host application was excluded from output. 


--------------------------------------------------------------------------------------------------------
Project description:
Problem Robot Wars 


Your are employed by Robots R Us Ltd, and have been asked to deploy a

squad of Robots on to a battle arena that will be later televised around the 

globe. This arena is currently rectangular in shape and must be navigated 

by the Robots. 


A robot's position and location is represented by a combination of x and y

co-ordinates and a letter representing one of the four cardinal compass

points. The arena is divided up into a grid to simplify navigation. An

example position might be 0, 0, N, which means the robot is in the bottom

left corner and facing North. 


In order to control a robot, Robots R Us Ltd sends a simple string of letters. 

The possible letters are 'L', 'R' and 'M'. 'L' and 'R' makes the robot spin 90

degrees left or right respectively, without moving from its current spot.

'M' means move forward one grid point, and maintain the same heading. 


Assume that the square directly North from (x, y) is (x, y+1). 


INPUT:

The first line of input is the upper-right coordinates of the arena, the

lower-left coordinates are assumed to be 0,0. 


The rest of the input is information pertaining to the robots that have

been deployed. Each robot has two lines of input. The first line gives the

robot's initial deployed position, and the second line is a series of 

instructions telling the robot how to explore the arena. 


The position is made up of two integers and a letter separated by spaces,

corresponding to the x and y co-ordinates and the robot's orientation. 


Each robot will be finished sequentially, which means that the second robot

won't start to move until the first one has finished moving. 
 


OUTPUT

The output for each robot should be its final co-ordinates and heading. 


INPUT AND OUTPUT 


Test Input:

7 6

2 4 E

MMRMMRMRRM

3 4 N

LMLMLMLMM 


Expected Output:

4 2 E

3 5 N
