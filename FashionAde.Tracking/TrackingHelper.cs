using System;
using System.Configuration;
using System.Data;
using MySql.Data.MySqlClient;

namespace FashionAde.Tracking
{
    public class TrackingHelper
    {
        static readonly string ConnectionString = ConfigurationManager.ConnectionStrings["TrackingMySqlServer"].ConnectionString;
        
        public static void Save(string controllerName, string actionName, string trackingIdentifier, string ipAdress, string userId, string channel, int? additionalDataId, string additionalData)
        {
            MySqlConnection connection = new MySqlConnection(ConnectionString);
            
            try
            {
                connection.Open();
                MySqlCommand command = new MySqlCommand("uspInsertTrackingInfo", connection)
                                           {CommandType = CommandType.StoredProcedure};

                command.Parameters.Add(new MySqlParameter("Controller", controllerName));
                command.Parameters.Add(new MySqlParameter("Action", actionName));
                command.Parameters.Add(new MySqlParameter("TrackingIdentifier", trackingIdentifier));
                command.Parameters.Add(new MySqlParameter("IP", ipAdress));
                command.Parameters.Add(new MySqlParameter("UserId", userId));
                command.Parameters.Add(new MySqlParameter("Channel", channel));
                command.Parameters.Add(new MySqlParameter("AdditionalDataId", additionalDataId));
                command.Parameters.Add(new MySqlParameter("AdditionalData", additionalData));

                command.ExecuteNonQuery();
                connection.Close();
            }
            catch (Exception)
            {
                if (connection.State == ConnectionState.Open)
                    connection.Close();
            }
        }


        public static void SaveOutfitUpdaterInfo(string outfitUpdaterId, string closetOutfitId)
        {
            MySqlConnection connection = new MySqlConnection(ConnectionString);
            try
            {
                connection.Open();
                MySqlCommand command = new MySqlCommand("uspInsertTrackingUpdatersInfo", connection)
                                           {CommandType = CommandType.StoredProcedure};

                command.Parameters.Add(new MySqlParameter("OutfitUpdaterId", outfitUpdaterId));
                command.Parameters.Add(new MySqlParameter("ClosetOutfitId", closetOutfitId));

                command.ExecuteNonQuery();
                connection.Close();
            }
            catch (Exception)
            {
                if (connection.State == ConnectionState.Open)
                    connection.Close();
            }
        }
    }
}
