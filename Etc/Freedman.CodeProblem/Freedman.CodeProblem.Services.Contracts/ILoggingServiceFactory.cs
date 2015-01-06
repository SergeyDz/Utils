// --------------------------------------------------------------------------------------------------------------------
// <copyright file="ILoggingServiceFactory.cs" company="localhost">
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
    /// Contract for Service Factory for return implementation of service
    /// </summary>
    public interface ILoggingServiceFactory
    {
        /// <summary>
        /// Get Logging Service instance
        /// </summary>
        /// <returns>Service implementation</returns>
        ILoggingService GetService();

        /// <summary>
        /// Get Logging Service instance
        /// </summary>
        /// <param name="name">Named instance </param>
        /// <returns>Service implementation</returns>
        ILoggingService GetService(string name);
    }
}
