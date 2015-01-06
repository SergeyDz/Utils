// --------------------------------------------------------------------------------------------------------------------
// <copyright file="Direction.cs" company="localhost">
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
    /// Enum to show direction
    /// </summary>
    public enum Direction
    {
        /// <summary>
        /// North direction
        /// </summary>
        N = 90, 

        /// <summary>
        /// South direction
        /// </summary>
        S = 270,

        /// <summary>
        /// East direction
        /// </summary>
        E = 0, 

        /// <summary>
        /// West direction
        /// </summary>
        W = 180
    }
}
