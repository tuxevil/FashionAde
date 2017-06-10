using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.ApplicationServices.Outfit;
using SharpArch.Data.NHibernate;
using SharpArch.Wcf.NHibernate;
using FashionAde.Data.NHibernateMaps;
using Castle.Windsor;
using Castle.MicroKernel.Registration;
using FashionAde.Services;
using FashionAde.ApplicationServices;
using FashionAde.Utils;
using System.ServiceModel.Dispatcher;
using SharpArch.Wcf;
using System.Collections.ObjectModel;
using Microsoft.Practices.ServiceLocation;

namespace TestConsole
{
    class Program
    {
        private static WcfSessionStorage storage = new WcfSessionStorage();

        static void Main(string[] args)
        {
            try
            {
                log4net.Config.XmlConfigurator.Configure();

                // Create container
                IWindsorContainer container = new WindsorContainer();

                // Add Engine for the Host Service
                container.AddComponent("outfitEngineService", typeof(OutfitEngineService));
                container.AddComponent("outfitUpdaterService", typeof(OutfitUpdaterService));

                // Add the Services to the Container
                ComponentRegistrar.AddServicesTo(container);
                ComponentRegistrar.AddApplicationServicesTo(container);

                // Create the container
                ServiceLocatorInitializer.Init(container);

                // Initialize NHibernate
                NHibernateInitializer.Instance().InitializeNHibernateOnce(
                    () => InitializeNHibernateSession());

                System.ServiceModel.ServiceHost host = new System.ServiceModel.ServiceHost(typeof(OutfitEngineService));
                host.Description.Behaviors.Add(new PerCallServiceBehavior());
                host.Open();

                ServiceHost host2 = new ServiceHost(typeof(OutfitUpdaterService));
                host2.Open();

                Console.WriteLine("Service started...");
                Console.ReadLine();

                host.Close();
                host2.Close();

                Console.WriteLine("Service stopped...");
                Console.ReadLine();
            }
            catch(Exception ex) {
                Console.WriteLine(ex.ToString());
            }
        }

        private static void InitializeNHibernateSession()
        {
            NHibernateSession.Init(
                storage,
                new string[] { "FashionAde.Data.dll" },
                new AutoPersistenceModelGenerator().Generate(),
                "NHibernate.config");
        }



    }
}
