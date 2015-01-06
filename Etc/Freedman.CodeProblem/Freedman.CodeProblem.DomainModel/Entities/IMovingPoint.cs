// --------------------------------------------------------------------------------------------------------------------
// <copyright file="IMovingPoint.cs" company="localhost">
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
    using Freedman.CodeProblem.Services.Contracts;

    /// <summary>
    /// Interface for object that can be moved into the square
    /// </summary>
    public interface IMovingPoint
    {
        /// <summary>
        /// Command for robot t turn left
        /// </summary>
        void TurnLeft();

        /// <summary>
        /// Command for robot to turn right
        /// </summary>
        void TurnRight();

        /// <summary>
        /// Command to move
        /// </summary>
        /// <param name="logger">Logger to report about success movement or failture</param>
        void Go(ILoggingService logger);
    }
}
