// --------------------------------------------------------------------------------------------------------------------
// <copyright file="Battlefield.cs" company="localhost">
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
    
    /// <summary>
    /// Class for representing fight arena
    /// </summary>
    public class Battlefield : ILimitedSpace
    {
        /// <summary>
        /// Initializes a new instance of the Freedman.CodeProblem.DomainModel.Entities.Battlefield class.
        /// </summary>
        public Battlefield()
        {
            this.Robots = new List<Robot>();
        }

        /// <summary>
        /// Initializes a new instance of the Freedman.CodeProblem.DomainModel.Entities.Battlefield class.
        /// </summary>
        /// <param name="begin">Start point of square</param>
        /// <param name="end">End point of square </param>
        public Battlefield(Cartesian begin, Cartesian end) : this()
        {
            this.BeginPoint = begin;
            this.EndPoint = end;
        }

        /// <summary>
        /// Gets or sets Start point of the battle field
        /// </summary>
        public Cartesian BeginPoint { get; set; }

        /// <summary>
        /// Gets or sets End point of the battlefield
        /// </summary>
        public Cartesian EndPoint { get; set; }

        /// <summary>
        /// Gets or sets list of units
        /// </summary>
        public List<Robot> Robots { get; set; }

        /// <summary>
        /// Add new robot to army
        /// </summary>
        /// <param name="initialPoint">Initial start point of robot</param>
        /// <param name="initialDirection">Initial direction of robot</param>
        public void AddRobot(Cartesian initialPoint, Polar initialDirection)
        {
            this.Robots.Add(new Robot(this, initialPoint, initialDirection));
        }
    }
}
