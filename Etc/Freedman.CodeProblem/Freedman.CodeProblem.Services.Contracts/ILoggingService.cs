// --------------------------------------------------------------------------------------------------------------------
// <copyright file="ILoggingService.cs" company="localhost">
//   Sergey Dzyuban. All rights reserved.
// </copyright>
// <author>Sergey Dzyuban</author>
// <date>2011-12-07</date>
// --------------------------------------------------------------------------------------------------------------------

namespace Freedman.CodeProblem.Services.Contracts
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;

    /// <summary>
    /// Interface for implement logging logic
    /// </summary>
    public interface ILoggingService
    {
        /// <summary>
        /// Write log of inofrmation level
        /// </summary>
        /// <param name="message">Message to be logged</param>
        void Info(string message);

        /// <summary>
        /// Write log of warning level
        /// </summary>
        /// <param name="message">Message to be logged</param>
        void Warn(string message);

        /// <summary>
        /// Write log of exception level
        /// </summary>
        /// <param name="message">Message to be logged</param>
        /// <param name="exception">Exception to be logged</param>
        void Error(string message, Exception exception);
    }
}
