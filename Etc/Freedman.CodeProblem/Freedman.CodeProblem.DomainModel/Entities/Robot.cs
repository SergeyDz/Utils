// --------------------------------------------------------------------------------------------------------------------
// <copyright file="Robot.cs" company="localhost">
//   Sergey Dzyuban. All rights reserved.
// </copyright>
// <author>Sergey Dzyuban</author>
// <date>2011-12-07</date>
// --------------------------------------------------------------------------------------------------------------------

namespace Freedman.CodeProblem.DomainModel.Entities
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using Freedman.CodeProblem.DomainModel.Coordinates;
    using Freedman.CodeProblem.Services.Contracts;

    /// <summary>
    /// Class for representing fight unit
    /// </summary>
    public class Robot : IMovingPoint
    {
        /// <summary>
        /// space limits
        /// </summary>
        private ILimitedSpace limitedSpace;

        /// <summary>
        /// Cartesian coordivate of robot
        /// </summary>
        private Cartesian coordinate;

        /// <summary>
        /// Polar coordinate of robot direction
        /// </summary>
        private Polar polar;

        /// <summary>
        /// Initializes a new instance of the Freedman.CodeProblem.DomainModel.Entities.Robot class.
        /// </summary>
        public Robot()
        { 
        }

        /// <summary>
        /// Initializes a new instance of the Freedman.CodeProblem.DomainModel.Entities.Robot class.
        /// </summary>
        /// <param name="space">Limited space params</param>
        /// <param name="initialCoordinate">X,Y representation </param>
        /// <param name="initialDirection">Direction representation</param>
        public Robot(ILimitedSpace space, Cartesian initialCoordinate, Polar initialDirection)
        {
            this.limitedSpace = space;
            this.coordinate = initialCoordinate;
            this.polar = initialDirection;
        }

        /// <summary>
        /// Command for robot t turn left
        /// </summary>
        public void TurnLeft()
        {
            this.polar.Angle = this.polar.Angle + 90;
        }

        /// <summary>
        /// Command for robot to turn right
        /// </summary>
        public void TurnRight()
        {
            this.polar.Angle = this.polar.Angle - 90;
        }

        /// <summary>
        /// Command to move
        /// </summary>
        /// <param name="logger">Logger to report about success movement or failture</param>
        public void Go(ILoggingService logger)
        {
            var result = this.coordinate + (Cartesian)this.polar;
            if (result < this.limitedSpace.BeginPoint)
            {
                logger.Warn("Can't move to this direction. Begin point reached.");
                return;
            }

            if (result > this.limitedSpace.EndPoint)
            {
                logger.Warn("Can't move to this direction. End point reached.");
                return;
            }

            this.coordinate = result;
        }

        /// <summary>
        /// Report string of current position
        /// </summary>
        /// <returns>String for be printed in screen</returns>
        public string ReportState()
        {
            this.polar.NormalizeAngle();
            string result = string.Format("{0} {1} {2}", this.coordinate.X, this.coordinate.Y, (Direction)this.polar.Angle);
            return result;
        }
    }
}
