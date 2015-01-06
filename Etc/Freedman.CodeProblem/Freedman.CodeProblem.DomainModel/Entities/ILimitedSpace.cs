// --------------------------------------------------------------------------------------------------------------------
// <copyright file="ILimitedSpace.cs" company="localhost">
//   Sergey Dzyuban. All rights reserved.
// </copyright>
// <author>Sergey Dzyuban</author>
// <date>2011-12-07</date>
// --------------------------------------------------------------------------------------------------------------------/
namespace Freedman.CodeProblem.DomainModel.Entities
{
    using Freedman.CodeProblem.DomainModel.Coordinates;

    /// <summary>
    /// Interface for limited space square
    /// </summary>
    public interface ILimitedSpace
    {
        /// <summary>
        /// Gets or sets Start point of the battle field
        /// </summary>
        Cartesian BeginPoint { get; set; }

        /// <summary>
        /// Gets or sets End point of the battlefield
        /// </summary>
        Cartesian EndPoint { get; set; }
    }
}
