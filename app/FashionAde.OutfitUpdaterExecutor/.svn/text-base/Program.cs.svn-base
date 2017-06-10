using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.IO;
using System.IO.Compression;
using System.Configuration;
using Castle.Windsor;
using FashionAde.ApplicationServices;
using FashionAde.ApplicationServices.SearchEngine;
using FashionAde.Data.NHibernateMaps;
using FashionAde.Data.Repository;
using FashionAde.Utils;
using log4net;
using Microsoft.Practices.ServiceLocation;
using SharpArch.Data.NHibernate;
using SharpArch.Wcf.NHibernate;

namespace FashionAde.OutfitUpdaterExecutor
{
    class Program
    {
        private const string Download = "/download";
        private const string Execute = "/execute";
        private const string CreateIndexes = "/createindexes";

        /// <summary>
        /// Updates all feeds.
        /// Normally executed on weekends.
        /// </summary>
        /// <remarks>
        /// Example of usage:
        /// FashionAde.OutfitUpdaterExecutor.exe host username password file1 file2 ...  fileN
        /// FashionAde.OutfitUpdaterExecutor.exe /download aftp.linksynergy.com jfennell2753 KftEapMS 24895_2389515_mp.txt.gz 13816_2389515_mp.txt.gz
        /// FashionAde.OutfitUpdaterExecutor.exe /download datatransfer.cj.com 2805067 CyWm5fUc /outgoing/productcatalog/52470/Zappos_com-Product_Catalog_1.txt.gz
        /// FashionAde.OutfitUpdaterExecutor.exe /execute
        /// </remarks>
        /// <param name="args"></param>
        static void Main(string[] args)
        {
            log4net.Config.XmlConfigurator.Configure();

            // Create container
            IWindsorContainer container = new WindsorContainer();

            // Add the Services to the Container
            ComponentRegistrar.AddApplicationServicesTo(container);

            // Create the container
            ServiceLocatorInitializer.Init(container);

            // Initialize NHibernate
            NHibernateInitializer.Instance().InitializeNHibernateOnce(
                InitializeNHibernateSession);

            try {
                if (args.Length > 4 && args[0].ToLower() == Download)
                {
                    // Download Files From Ftp
                    string host = args[1];        // "aftp.linksynergy.com";
                    string userName = args[2];    // "jfennell2753";
                    string password = args[3];    // "KftEapMS";

                    for (var i=4; i<args.Length; i++)
                    {
                        string sourceFile = args[i];
                        DownloadFile(host, userName, password, sourceFile);
                    }
                }
                else if (args.Length == 1 && args[0].ToLower() == Execute)
                {
                    // Start executing the updater
                    new OutfitUpdaterReference.OutfitUpdaterServiceClient().UpdateFeeds();
                }
                else if (args.Length == 1 && args[0].ToLower() == CreateIndexes)
                {
                    IIndexCreationService ics = ServiceLocator.Current.GetInstance<IIndexCreationService>();
                    ics.CreateIndexes();
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);
            }
        }

        private static ILog _logger;
        public static ILog Log
        {
            get { return _logger ?? (_logger = LogManager.GetLogger("FashionAde.OutfitUpdaterExecutor")); }
        }

        private static SimpleSessionStorage storage = new SimpleSessionStorage();

        private static void InitializeNHibernateSession()
        {
            NHibernateSession.Init(
                storage,
                new string[] { "FashionAde.Data.dll" },
                new AutoPersistenceModelGenerator().Generate(),
                "NHibernate.config");
        }

        #region File Download

        private static void DownloadFile(string host, string userName, string password, string sourceFile)
        {
            string destFile = Path.Combine(ConfigurationManager.AppSettings["OUImportation_Path"], Path.GetFileName(sourceFile));
            string backupDestFile = Path.Combine(ConfigurationManager.AppSettings["OUImportation_Path"], "bak_" + DateTime.Now.ToString("yyyyMMdd_hhmmss") + "_" + Path.GetFileName(sourceFile));

            Log.DebugFormat("Download File {0} ...", sourceFile);

            Process p = new Process();
            p.StartInfo.FileName = "sendftp.bat";
            p.StartInfo.Arguments =
              string.Format("{0} {1} {2} {3} {4}", host, userName, password, sourceFile, destFile);
            p.StartInfo.CreateNoWindow = false;
            p.Start();
            p.WaitForExit();

            Log.Debug("Decompress File...");
            // Is compressed?
            if (destFile.Contains(".gz"))
            {
                // Delete decompressed file if exists
                if (File.Exists(destFile.Replace(".gz", "")))
                    File.Delete(destFile.Replace(".gz", ""));

                // Decompress file
                DecompressFile(destFile);
            }

            Log.Debug("Backup file...");
            // Backup file if exists
            if (File.Exists(destFile))
                File.Move(destFile, backupDestFile);
        }

        private static void DecompressFile(string file)
        {
            FileStream fs = new FileStream(file, FileMode.Open);
            FileStream fsOutput = new FileStream(file.Replace(".gz",""),
                                                 FileMode.Create,
                                                 FileAccess.Write);
            GZipStream zip = new GZipStream(fs, CompressionMode.Decompress, true);

            byte[] buffer = new byte[4096];
            int bytesRead;
            bool continueLoop = true;
            while (continueLoop)
            {
                bytesRead = zip.Read(buffer, 0, buffer.Length);
                if (bytesRead == 0)
                    break;
                fsOutput.Write(buffer, 0, bytesRead);
            }
            zip.Close();
            fsOutput.Close();
            fs.Close();
        }

        #endregion
    }

}
