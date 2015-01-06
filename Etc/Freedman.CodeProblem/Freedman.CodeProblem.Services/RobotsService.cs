// --------------------------------------------------------------------------------------------------------------------
// <copyright file="RobotsService.cs" company="localhost">
//   Sergey Dzyuban. All rights reserved.
// </copyright>
// <author>Sergey Dzyuban</author>
// <date>2011-12-07</date>
// --------------------------------------------------------------------------------------------------------------------

namespace Freedman.CodeProblem.Services
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;    
    using Freedman.CodeProblem.DomainModel.Coordinates;
    using Freedman.CodeProblem.DomainModel.Entities;
    using Freedman.CodeProblem.Services.Contracts;

    /// <summary>
    /// Class for manipulation with RoBo Wars
    /// </summary>
    public class RobotsService
    {
        /// <summary>
        /// logger for catch log data
        /// </summary>
        private readonly ILoggingService logger;

        /// <summary>
        /// Internal square instance
        /// </summary>
        private Battlefield battlefield;

        /// <summary>
        ///  Initializes a new instance of the Freedman.CodeProblem.Services.RobotsService class.
        /// </summary>
        /// <param name="initialLogger">Logger for class</param>
        public RobotsService(ILoggingService initialLogger)
        {
            this.logger = initialLogger;
        }

        /// <summary>
        /// Initialize Battlefield call
        /// </summary>
        /// <param name="begin">Begin point string</param>
        /// <param name="end">End point string</param>
        public void InitializeBattlefield(string begin, string end)
        {
            Cartesian beginPoint = this.ConvertStringToPoint(begin);
            Cartesian endPoint = this.ConvertStringToPoint(end);
            this.battlefield = new Battlefield(beginPoint, endPoint);
        }

        /// <summary>
        /// Add robot to Battlefield
        /// </summary>
        /// <param name="robot">Add robot to the battlefield</param>
        /// <param name="radius">Set default movement radius</param>
        public void PlaceBobotOnBattlefield(string robot, string radius)
        {
            Cartesian placementPoint = this.ConvertStringToPoint(robot);
            Polar placementDirection = this.ConvertStringToDirection(radius, robot);
            this.battlefield.AddRobot(placementPoint, placementDirection);
        }

        /// <summary>
        /// Move robot accross the arena
        /// </summary>
        /// <param name="index">Robot index for movement</param>
        /// <param name="instructions">Command for robot</param>
        public void MoveRobot(int index, string instructions)
        {
            char[] commands = instructions.ToUpper().ToCharArray();
            IMovingPoint point = (IMovingPoint)this.battlefield.Robots[index];
            foreach (var command in commands)
            {
                switch (command)
                {
                    case 'M':
                        {
                            point.Go(this.logger);
                            break;
                        }

                    case 'L':
                        {
                            point.TurnLeft();
                            break;
                        }

                    case 'R':
                        {
                            point.TurnRight();
                            break;
                        }

                    default:
                        {
                            this.logger.Warn(string.Format("Command '{0}' was not recognized", command));
                            break;
                        }
                }
            }
        }

        /// <summary>
        /// Request rport from robot about his position
        /// </summary>
        /// <param name="index">Robot index in collection</param>
        /// <returns>String to show on screen</returns>
        public string RequestRobotReport(int index)
        {
            return this.battlefield.Robots[index].ReportState();
        }

        /// <summary>
        /// Convert string to Cartesian point
        /// </summary>
        /// <param name="data">Data string containing x y data</param>
        /// <returns>Coordinate of point</returns>
        private Cartesian ConvertStringToPoint(string data)
        { 
            string[] coordinates = data.Trim().Split(' ');
            return new Cartesian(int.Parse(coordinates[0]), int.Parse(coordinates[1]));
        }

        /// <summary>
        /// Convert strings to Polar coordinate
        /// </summary>
        /// <param name="radius">Default radius</param>
        /// <param name="robot">Direction character</param>
        /// <returns>Polar coordinate of point with direction</returns>
        private Polar ConvertStringToDirection(string radius, string robot)
        {
            string direction = robot.Trim().Split(' ').Last();
            return new Polar(int.Parse(radius), (int)((string)direction).ConvertToEnum<Direction>());
        }
    }
}
