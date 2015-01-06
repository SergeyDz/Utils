// --------------------------------------------------------------------------------------------------------------------
// <copyright file="LoggingService.cs" company="localhost">
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
    using log4net;

    /// <summary>
    /// Implementation of Logging Service
    /// </summary>
    public class LoggingService : ILoggingService 
    {
        /// <summary>
        /// Saved inside class instance of ILog 
        /// </summary>
        private ILog logger; 

        /// <summary>
        /// Initializes a new instance of the Freedman.CodeProblem.Services.LoggingService class.
        /// </summary>
        public LoggingService()
        {
            this.logger = LogManager.GetLogger("Freedman.CodeProblem");
        }

        /// <summary>
        /// Initializes a new instance of the Freedman.CodeProblem.Services.LoggingService class.
        /// </summary>
        /// <param name="name">Neme of created this.logger</param>
        public LoggingService(string name)
        {
            this.logger = LogManager.GetLogger(name);
        }

        /// <summary>
        /// Write log of inofrmation level
        /// </summary>
        /// <param name="message">Message to be logged</param>
        public void Info(string message)
        {
            if (this.logger != null && this.logger.IsInfoEnabled)
            {
                this.logger.Info(message);
            }
        }

        /// <summary>
        /// Write log of warning level
        /// </summary>
        /// <param name="message">Message to be logged</param>
        public void Warn(string message)
        {
            if (this.logger != null && this.logger.IsWarnEnabled)
            {
                this.logger.Warn(message);
            }
        }

        /// <summary>
        /// Write log of exception level
        /// </summary>
        /// <param name="message">Message to be logged</param>
        /// <param name="exception">Exception to be logged</param>
        public void Error(string message, Exception exception)
        {
            if (this.logger != null && this.logger.IsErrorEnabled)
            {
                this.logger.Error(message, exception);
            }
        }
    }
}
