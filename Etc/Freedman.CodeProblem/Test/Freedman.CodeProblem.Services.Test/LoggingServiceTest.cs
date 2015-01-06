// --------------------------------------------------------------------------------------------------------------------
// <copyright file="LoggingServiceTest.cs" company="localhost">
//   Sergey Dzyuban. All rights reserved.
// </copyright>
// <author>Sergey Dzyuban</author>
// <date>2011-12-07</date>
// --------------------------------------------------------------------------------------------------------------------

namespace Freedman.CodeProblem.Services.Test
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using Freedman.CodeProblem.Services;
    using Freedman.CodeProblem.Services.Contracts;
    using NUnit.Framework;

    /// <summary>
    /// Logging Service avaliability test
    /// </summary>
    [TestFixture]
    public class LoggingServiceTest
    {
        /// <summary>
        /// Test if factory can be created
        /// </summary>
        [Test]
        public void TestLoggingServiceFactoryCreation()
        {
            ILoggingServiceFactory factory = null;
            factory = new LoggingServiceFactory();
            Assert.IsNotNull(factory);
        }

        /// <summary>
        /// Test if logger can be created
        /// </summary>
        [Test]
        public void TestLoggingServiceCreation()
        {
            ILoggingServiceFactory factory = null;
            factory = new LoggingServiceFactory();
            Assert.IsNotNull(factory);
            ILoggingService logger = factory.GetService();
            Assert.IsNotNull(logger);
            Assert.IsInstanceOf<ILoggingService>(logger);
        }

        /// <summary>
        /// Test if named logger can be created
        /// </summary>
        [Test]
        public void TestNamedLoggingServiceCreation()
        {
            ILoggingServiceFactory factory = null;
            factory = new LoggingServiceFactory();
            Assert.IsNotNull(factory);
            ILoggingService logger = factory.GetService("Test name");
            Assert.IsNotNull(logger);
            Assert.IsInstanceOf<ILoggingService>(logger);
        }

        /// <summary>
        /// Test if logger method calls have not faults
        /// </summary>
        [Test]
        public void TestLoggingServiceOperations()
        {
            ILoggingServiceFactory factory = null;
            factory = new LoggingServiceFactory();
            Assert.IsNotNull(factory);
            ILoggingService logger = factory.GetService();
            Assert.IsNotNull(logger);
            string message = "message for test";
            logger.Info(message);
            logger.Warn(message);
            logger.Error(message, new Exception(message));
        }

        /// <summary>
        /// Test if nemed logger method calls have not faults
        /// </summary>
        [Test]
        public void TestNamedLoggingServiceOperations()
        {
            ILoggingServiceFactory factory = null;
            factory = new LoggingServiceFactory();
            Assert.IsNotNull(factory);
            ILoggingService logger = factory.GetService("Test name");
            Assert.IsNotNull(logger);
            string message = "message for test";
            logger.Info(message);
            logger.Warn(message);
            logger.Error(message, new Exception(message));
        }
    }
}
