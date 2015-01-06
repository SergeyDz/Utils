// --------------------------------------------------------------------------------------------------------------------
// <copyright file="RobotsServiceTest.cs" company="localhost">
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
    /// Square Service avaliability test
    /// </summary>
    [TestFixture]
    public class RobotsServiceTest
    {
        /// <summary>
        /// Verify program result
        /// </summary>
        [Test]
        public void RunTestScenario()
        {
            int players = 2;
            string radius = "1";
            string beginOfCoordinates = "0 0";
            string endOfCoordinates = "7 6";
            List<string> robotInit = new List<string>();
            robotInit.Add("2 4 E");
            robotInit.Add("3 4 N");
            List<string> robotMovement = new List<string>();
            robotMovement.Add("MMRMMRMRRM");
            robotMovement.Add("LMLMLMLMM ");
            List<string> robotVerifyResult = new List<string>();
            robotVerifyResult.Add("4 2 E");
            robotVerifyResult.Add("3 5 N");

            ILoggingServiceFactory factory = new LoggingServiceFactory();
            var logger = factory.GetService("Program");

            RobotsService service = new RobotsService(logger);
            service.InitializeBattlefield(beginOfCoordinates, endOfCoordinates);
            
            for (int i = 0; i < players; i++)
            {
                service.PlaceBobotOnBattlefield(robotInit[i], radius);
                service.MoveRobot(i, robotMovement[i]);
            }

            for (int i = 0; i < players; i++)
            {
                Assert.AreEqual(robotVerifyResult[i], service.RequestRobotReport(i));
                Console.WriteLine(service.RequestRobotReport(i));
            }
        }
    }
}
