// --------------------------------------------------------------------------------------------------------------------
// <copyright file="Program.cs" company="localhost">
//   Sergey Dzyuban. All rights reserved.
// </copyright>
// <author>Sergey Dzyuban</author>
// <date>2011-12-07</date>
// --------------------------------------------------------------------------------------------------------------------

namespace Freedman.CodeProblem.Host
{
    using System;
    using System.Collections.Generic;
    using System.Configuration;
    using System.Linq;
    using System.Text;
    using Freedman.CodeProblem.DomainModel.Coordinates;
    using Freedman.CodeProblem.DomainModel.Entities;
    using Freedman.CodeProblem.Services;
    using Freedman.CodeProblem.Services.Contracts;
    using log4net;
    using log4net.Config;
    
    /// <summary>
    /// Host Console for application business logic.
    /// </summary>
    public class Program
    {
        /// <summary>
        /// Logger service instance
        /// </summary>
        private static ILoggingService logger; 

        /// <summary>
        /// Entry point
        /// </summary>
        /// <param name="args">Console params. Leaved blank in current implementation.</param>
        private static void Main(string[] args)
        {
            Initialize();
            logger.Info("Freedman.CodeProblem.Host.Program started.");

            int players = int.Parse(ConfigurationManager.AppSettings["Players"]);
            string radius = ConfigurationManager.AppSettings["Radius"];
            string beginOfCoordinates = ConfigurationManager.AppSettings["InitialCoordinates"];

            try
            {
                RobotsService service = new RobotsService(logger);
                service.InitializeBattlefield(beginOfCoordinates, Console.ReadLine());

                for (int i = 0; i < players; i++)
                {
                    service.PlaceBobotOnBattlefield(Console.ReadLine(), radius);
                    service.MoveRobot(i, Console.ReadLine());
                }

                for (int i = 0; i < players; i++)
                {
                    Console.WriteLine(service.RequestRobotReport(i));
                }
            }
            catch (Exception ex)
            {
                logger.Error("Program.Main execution fail", ex);
            }
  
            logger.Info("Freedman.CodeProblem.Host.Program stopped.");
            Console.ReadKey();
        }

        /// <summary>
        /// Initialize internal application state on console start
        /// </summary>
        private static void Initialize()
        {
            XmlConfigurator.Configure();
            ILoggingServiceFactory factory = new LoggingServiceFactory();
            logger = factory.GetService("Program");
        }
    }
}
