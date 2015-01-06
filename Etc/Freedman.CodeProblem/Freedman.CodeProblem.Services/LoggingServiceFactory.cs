// --------------------------------------------------------------------------------------------------------------------
// <copyright file="LoggingServiceFactory.cs" company="localhost">
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
    using Freedman.CodeProblem.Services.Contracts;

    /// <summary>
    /// Service Factory for return implementation of service
    /// </summary>
    public class LoggingServiceFactory : ILoggingServiceFactory
    {
        /// <summary>
        /// Get Logging Service instance
        /// </summary>
        /// <returns>Service implementation</returns>
        public ILoggingService GetService()
        {
            return new LoggingService();
        }

        /// <summary>
        /// Get Logging Service instance
        /// </summary>
        /// <param name="name">Named instance </param>
        /// <returns>Service implementation</returns>
        public ILoggingService GetService(string name)
        {
            return new LoggingService(name);
        }
    }
}
