// --------------------------------------------------------------------------------------------------------------------
// <copyright file="Polar.cs" company="localhost">
//   Sergey Dzyuban. All rights reserved.
// </copyright>
// <author>Sergey Dzyuban</author>
// <date>2011-12-07</date>
// --------------------------------------------------------------------------------------------------------------------

namespace Freedman.CodeProblem.DomainModel.Coordinates
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;

    /// <summary>
    /// Point in Polar coordinates system
    /// </summary>
    public class Polar
    {
        /// <summary>
        /// Initializes a new instance of the Freedman.CodeProblem.DomainModel.Coordinates.Polar class.
        /// </summary>
        public Polar()
        { 
        }

        /// <summary>
        /// Initializes a new instance of the Freedman.CodeProblem.DomainModel.Coordinates.Polar class.
        /// </summary>
        /// <param name="radius">Radius for vector movement</param>
        /// <param name="angle">Angle to show direction</param>
        public Polar(int radius, int angle)
        {
            this.Radius = radius;
            this.Angle = angle;
        }

        /// <summary>
        /// Gets or sets Radius of elemental movement
        /// </summary>
        public int Radius { get; set; }

        /// <summary>
        ///  Gets or sets Angle of point in degree
        /// </summary>
        public int Angle { get; set; }

        /// <summary>
        /// Convert Polar vector to Cartesian coordinates
        /// </summary>
        /// <param name="polar">Polar coordinate</param>
        /// <returns>return cartesian representation</returns>
        public static implicit operator Cartesian(Polar polar)
        {
            Cartesian cartesian = new Cartesian();
            cartesian.X = (int)(polar.Radius * Math.Cos(polar.Angle * (Math.PI / 180)));
            cartesian.Y = (int)(polar.Radius * Math.Sin(polar.Angle * (Math.PI / 180)));
            return cartesian;
        }

        /// <summary>
        /// Normalize angle to 0....360 format
        /// </summary>
        public void NormalizeAngle()
        {
            this.Angle = Math.Abs(360 + (this.Angle % 360)) % 360;
        }
    }
}
