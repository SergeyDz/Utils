// --------------------------------------------------------------------------------------------------------------------
// <copyright file="CartesianTest.cs" company="localhost">
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
    /// NUnit test for domain Model class: Cartesian
    /// </summary>
    [TestFixture]
    public class CartesianTest
    {
        /// <summary>
        /// Tets for setter
        /// </summary>
        [Test]
        public void XSetterTest()
        {
            Cartesian point = new Cartesian();
            var coordinate = 5;
            point.X = coordinate;
            point.Y = 7;
            Assert.AreEqual(point.X, coordinate);
        }

        /// <summary>
        /// Test for setter
        /// </summary>
        [Test]
        public void YSetterTest()
        {
            Cartesian point = new Cartesian();
            var coordinate = 5;
            point.X = 3;
            point.Y = coordinate;
            Assert.AreEqual(point.Y, coordinate);
        }

        /// <summary>
        /// Test for constructor
        /// </summary>
        [Test]
        public void ConstructorTest()
        {
            int x = 6;
            int y = 4;
            Cartesian point = new Cartesian(x, y);
            Assert.AreEqual(point.X, x);
            Assert.AreEqual(point.Y, y);
        }

        /// <summary>
        /// Test for overload + operator
        /// </summary>
        [Test]
        public void OverloadOperatorTest()
        {
            Cartesian a = new Cartesian(1, 1);
            Cartesian b = new Cartesian(0, 1);
            var result = a + b;
            Assert.AreEqual(1, result.X);
            Assert.AreEqual(2, result.Y);

            a = new Cartesian(1, 1);
            b = new Cartesian(0, -1);
            result = a + b;
            Assert.AreEqual(1, result.X);
            Assert.AreEqual(0, result.Y);

            a = new Cartesian(1, 1);
            b = new Cartesian(1, 0);
            result = a + b;
            Assert.AreEqual(2, result.X);
            Assert.AreEqual(1, result.Y);

            a = new Cartesian(1, 1);
            b = new Cartesian(-1, 0);
            result = a + b;
            Assert.AreEqual(0, result.X);
            Assert.AreEqual(1, result.Y);
        }

        /// <summary>
        /// Test for overload + operator
        /// </summary>
        [Test]
        public void OverloadComparisonTest()
        {
            Cartesian a = new Cartesian(1, 1);
            Cartesian b = new Cartesian(0, 1);
            var result = a > b;
            Assert.IsTrue(result); 

            a = new Cartesian(1, 1);
            b = new Cartesian(1, 1);
            result = a >= b;
            Assert.IsTrue(result);

            a = new Cartesian(1, 1);
            b = new Cartesian(1, 1);
            result = a <= b;
            Assert.IsTrue(result);

            a = new Cartesian(1, 0);
            b = new Cartesian(1, 1);
            result = a < b;
            Assert.IsTrue(result);

            a = new Cartesian(0, 0);
            b = new Cartesian(1, 1);
            result = a < b;
            Assert.IsTrue(result);

            a = new Cartesian(1, -1);
            b = new Cartesian(1, 1);
            result = a < b;
            Assert.IsTrue(result);

            a = new Cartesian(1, 1);
            b = new Cartesian(1, 1);
            result = a == b;
            Assert.IsTrue(result);

            a = new Cartesian(0, 1);
            b = new Cartesian(1, 1);
            result = a != b;
            Assert.IsTrue(result); 
        }

        /// <summary>
        /// Test for  +  and - action
        /// </summary>
        [Test]
        public void RollbackTest()
        {
            Cartesian a = new Cartesian(1, 1);
            Cartesian b = new Cartesian(0, 1);
            var result = a + b - b;
            Assert.IsTrue(result == a);

            a = new Cartesian(1, 1);
            b = new Cartesian(0, -1);
            result = a + b - b;
            Assert.IsTrue(result == a);

            a = new Cartesian(1, 1);
            b = new Cartesian(1, 0);
            result = a + b - b;
            Assert.IsTrue(result == a);

            a = new Cartesian(1, 1);
            b = new Cartesian(-1, 0);
            result = a + b - b;
            Assert.IsTrue(result == a);
        }
    }
}
