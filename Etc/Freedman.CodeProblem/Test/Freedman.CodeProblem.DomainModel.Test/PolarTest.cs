// --------------------------------------------------------------------------------------------------------------------
// <copyright file="PolarTest.cs" company="localhost">
//   Sergey Dzyuban. All rights reserved.
// </copyright>
// <author>Sergey Dzyuban</author>
// <date>2011-12-07</date>
// --------------------------------------------------------------------------------------------------------------------

namespace Freedman.CodeProblem.DomainModel.Test
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using Freedman.CodeProblem.DomainModel.Coordinates;
    using NUnit.Framework;

    /// <summary>
    /// NUnit test for domain Model class: PolarTest
    /// </summary>
    [TestFixture]
    public class PolarTest
    {
        /// <summary>
        /// Tets for setter
        /// </summary>
        [Test]
        public void RadiusSetterTest()
        {
            Polar polar = new Polar();
            var r = 1;
            polar.Radius = r;
            Assert.AreEqual(r, polar.Radius);
        }

        /// <summary>
        /// Test for setter
        /// </summary>
        [Test]
        public void AngleSetterTest()
        {
            Polar polar = new Polar();
            var a = 1;
            polar.Angle = a;
            Assert.AreEqual(a, polar.Angle);
        }

        /// <summary>
        /// Test for different angles normalization
        /// </summary>
        [Test]
        public void NormalieTest()
        {
            Polar polar = new Polar();
            polar.Angle = 90;
            polar.NormalizeAngle();
            Assert.AreEqual(90, polar.Angle);

            polar.Angle = -90;
            polar.NormalizeAngle();
            Assert.AreEqual(270, polar.Angle);

            polar.Angle = -180;
            polar.NormalizeAngle();
            Assert.AreEqual(180, polar.Angle);

            polar.Angle = 0;
            polar.NormalizeAngle();
            Assert.AreEqual(0, polar.Angle);

            polar.Angle = 450;
            polar.NormalizeAngle();
            Assert.AreEqual(90, polar.Angle);

            polar.Angle = -450;
            polar.NormalizeAngle();
            Assert.AreEqual(270, polar.Angle);
        }

        /// <summary>
        /// Test conversion of Polar vector to Cartesian coordinate
        /// </summary>
        [Test]
        public void ConversationTest()
        {
            int radius = 1;
            int angle = 90;
            Polar polar = new Polar();

            polar.Radius = radius;
            polar.Angle = angle;
            Cartesian cartesian = (Cartesian)polar;
            Assert.IsNotNull(cartesian);
            Assert.AreEqual(1, cartesian.Y);
            Assert.AreEqual(0, cartesian.X);

            angle = 270;
            polar.Angle = angle;
            cartesian = (Cartesian)polar;
            Assert.IsNotNull(cartesian);
            Assert.AreEqual(-1, cartesian.Y);
            Assert.AreEqual(0, cartesian.X);

            angle = 180;
            polar.Angle = angle;
            cartesian = (Cartesian)polar;
            Assert.IsNotNull(cartesian);
            Assert.AreEqual(0, cartesian.Y);
            Assert.AreEqual(-1, cartesian.X);

            angle = 0;
            polar.Angle = angle;
            cartesian = (Cartesian)polar;
            Assert.IsNotNull(cartesian);
            Assert.AreEqual(0, cartesian.Y);
            Assert.AreEqual(1, cartesian.X);
        }
    }
}
