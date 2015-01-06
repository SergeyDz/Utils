// --------------------------------------------------------------------------------------------------------------------
// <copyright file="DirectionExtension.cs" company="localhost">
//   Sergey Dzyuban. All rights reserved.
// </copyright>
// <author>Sergey Dzyuban</author>
// <date>2011-12-07</date>
// --------------------------------------------------------------------------------------------------------------------

namespace Freedman.CodeProblem.DomainModel.Coordinates
{
    using System;

    /// <summary>
    /// String extension for conversion ot enum
    /// </summary>
    public static class DirectionExtension
    {
        /// <summary>
        /// Convert to enum
        /// </summary>
        /// <typeparam name="T">Type of Enum</typeparam>
        /// <param name="value">String value</param>
        /// <returns>Returns enumeration</returns>
        public static T ConvertToEnum<T>(this string value)
        {
            if (typeof(T).BaseType != typeof(Enum))
            {
                throw new InvalidCastException();
            }

            return (T)Enum.Parse(typeof(T), value, true);
        }
    }
}
