using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SD.XXX.DomainModel.Metadata
{
    [AttributeUsage(AttributeTargets.Property)]
    public class ReadonlyAttribute : Attribute
    {
        public ReadonlyAttribute()
            : base()
        { 
        }
    }
}
