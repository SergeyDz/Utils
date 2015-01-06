// --------------------------------------------------------------------------------------------------------------------
// <copyright file="Cartesian.cs" company="localhost">
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
    /// Point on Cartesian coordinates system
    /// </summary>
    public class Cartesian : IComparable<Cartesian>
    {
        /// <summary>
        /// Initializes a new instance of the Freedman.CodeProblem.DomainModel.Coordinates.Cartesian class.
        /// </summary>
        public Cartesian()
        {
            this.X = 0;
            this.Y = 0;
        }

        /// <summary>
        /// Initializes a new instance of the Freedman.CodeProblem.DomainModel.Coordinates.Cartesian class.
        /// </summary>
        /// <param name="x">X coordinate</param>
        /// <param name="y">Y coordinate</param>
        public Cartesian(int x, int y)
        {
            this.X = x;
            this.Y = y;
        }

        /// <summary>
        /// Gets or sets X coordinate
        /// </summary>
        public int X { get; set; }

        /// <summary>
        /// Gets or sets Y
        /// </summary>
        public int Y { get; set; }

        /// <summary>
        /// Overloading + operator
        /// </summary>
        /// <param name="a">First point</param>
        /// <param name="b">Second point</param>
        /// <returns>Point addition result</returns>
        public static Cartesian operator +(Cartesian a, Cartesian b)
        {
            return new Cartesian(a.X + b.X, a.Y + b.Y);
        }

        /// <summary>
        /// Overloading - operator
        /// </summary>
        /// <param name="a">First point</param>
        /// <param name="b">Second point</param>
        /// <returns>Point addition result</returns>
        public static Cartesian operator -(Cartesian a, Cartesian b)
        {
            return new Cartesian(a.X - b.X, a.Y - b.Y);
        }

        /// <summary>
        /// Comparison operator overload
        /// </summary>
        /// <param name="point1">Furst point</param>
        /// <param name="point2">Second point</param>
        /// <returns>Coparison result</returns>
        public static bool operator <(Cartesian point1, Cartesian point2)
        {
            IComparable<Cartesian> tmp = (IComparable<Cartesian>)point1;
            return tmp.CompareTo(point2) < 0;
        }

        /// <summary>
        /// Comparison operator overload
        /// </summary>
        /// <param name="point1">Furst point</param>
        /// <param name="point2">Second point</param>
        /// <returns>Coparison result</returns>
        public static bool operator ==(Cartesian point1, Cartesian point2)
        {
            IComparable<Cartesian> tmp = (IComparable<Cartesian>)point1;
            return tmp.CompareTo(point2) == 0;
        }

        /// <summary>
        /// Comparison operator overload
        /// </summary>
        /// <param name="point1">Furst point</param>
        /// <param name="point2">Second point</param>
        /// <returns>Coparison result</returns>
        public static bool operator !=(Cartesian point1, Cartesian point2)
        {
            IComparable<Cartesian> tmp = (IComparable<Cartesian>)point1;
            return tmp.CompareTo(point2) != 0;
        }

        /// <summary>
        /// Comparison operator overload
        /// </summary>
        /// <param name="point1">Furst point</param>
        /// <param name="point2">Second point</param>
        /// <returns>Coparison result</returns>
        public static bool operator >(Cartesian point1, Cartesian point2)
        {
            IComparable<Cartesian> tmp = (IComparable<Cartesian>)point1;
            return tmp.CompareTo(point2) > 0;
        }

        /// <summary>
        /// Comparison operator overload
        /// </summary>
        /// <param name="point1">Furst point</param>
        /// <param name="point2">Second point</param>
        /// <returns>Coparison result</returns>
        public static bool operator <=(Cartesian point1, Cartesian point2)
        {
            IComparable<Cartesian> tmp = (IComparable<Cartesian>)point1;
            return tmp.CompareTo(point2) <= 0;
        }

        /// <summary>
        /// Comparison operator overload
        /// </summary>
        /// <param name="point1">Furst point</param>
        /// <param name="point2">Second point</param>
        /// <returns>Coparison result</returns>
        public static bool operator >=(Cartesian point1, Cartesian point2)
        {
            IComparable<Cartesian> tmp = (IComparable<Cartesian>)point1;
            return tmp.CompareTo(point2) >= 0;
        }

        /// <summary>
        /// Compare one point with another
        /// </summary>
        /// <param name="other">Other point</param>
        /// <returns>itteger resut</returns>
        public int CompareTo(Cartesian other)
        {
            if (this.X > other.X || this.Y > other.Y)
            {
                return 1;
            }
            else if (this.X < other.X || this.Y < other.Y)
            {
                return -1;
            }
            else
            {
                return 0;
            }
        }
    }
}
