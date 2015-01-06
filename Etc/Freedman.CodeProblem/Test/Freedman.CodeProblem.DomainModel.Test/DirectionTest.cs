// --------------------------------------------------------------------------------------------------------------------
// <copyright file="DirectionTest.cs" company="localhost">
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
    /// NUnit test for domain Model Enim: Direction
    /// </summary>
    [TestFixture]
    public class DirectionTest
    {
        /// <summary>
        /// Test to convert direction into angle and vice versa
        /// </summary>
        [Test]
        public void FromDirectionConversionTest()
        {
            var direction = Direction.S;
            Assert.AreEqual(270, (int)direction);

            direction = Direction.N;
            Assert.AreEqual(90, (int)direction);

            direction = Direction.E;
            Assert.AreEqual(0, (int)direction);

            direction = Direction.W;
            Assert.AreEqual(180, (int)direction);
        }

        /// <summary>
        /// Test to convert direction into angle and vice versa
        /// </summary>
        [Test]
        public void ToDirectionConversionTest()
        {
            Assert.AreEqual(Direction.E, Enum.Parse(typeof(Direction), "e", true));

            Assert.AreEqual(Direction.N, Enum.Parse(typeof(Direction), "n", true));

            Assert.AreEqual(Direction.S, Enum.Parse(typeof(Direction), "s", true));

            Assert.AreEqual(Direction.W, Enum.Parse(typeof(Direction), "w", true));
        }

        /// <summary>
        /// Test to convert direction into angle and vice versa
        /// </summary>
        [Test]
        public void ToDirectionExtensionConversionTest()
        {
            Assert.AreEqual(Direction.E, "e".ConvertToEnum<Direction>());

            Assert.AreEqual(Direction.N, "N".ConvertToEnum<Direction>());

            Assert.AreEqual(Direction.S, "s".ConvertToEnum<Direction>());

            Assert.AreEqual(Direction.W, "w".ConvertToEnum<Direction>());
        }
    }
}
