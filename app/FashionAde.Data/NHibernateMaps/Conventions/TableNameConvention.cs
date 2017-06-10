using FluentNHibernate.Conventions;
using FluentNHibernate.Mapping;
using FashionAde.Core;

namespace FashionAde.Data.NHibernateMaps.Conventions
{
    public class TableNameConvention : IClassConvention
    {
        public void Apply(FluentNHibernate.Conventions.Instances.IClassInstance instance)
        {
            instance.Table(Inflector.Net.Inflector.Pluralize(instance.EntityType.Name));

            if (!typeof(Closet).IsAssignableFrom(instance.EntityType))
            {
                instance.Cache.Region("Entities");
                instance.Cache.NonStrictReadWrite();
            }
        }
    }
}
