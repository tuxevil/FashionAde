using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using FashionAde.Core;
using FashionAde.Core.Accounts;
using FashionAde.Web.Common;
using FashionAde.Web.Controllers.Outfits.Views;
using FashionAde.Tracking;

namespace FashionAde.Web.Controllers
{
    [AttributeUsage(AttributeTargets.Class, AllowMultiple = false)]
    public class RegisterTrackingAttribute : ActionFilterAttribute
    {
        private const string ckChannel = "Channel";
        private const string qsChannel = "utm_campaign";

        #region OnActionExecuted

        /// <summary>
        /// Fired after executing any action.
        /// </summary>
        /// <param name="filterContext">ActionExecutedContext with info about the action executed.</param>
        public override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            string controllerName = filterContext.ActionDescriptor.ControllerDescriptor.ControllerName;
            string actionName = filterContext.ActionDescriptor.ActionName;
            string ipAdress = filterContext.HttpContext.Request.ServerVariables["REMOTE_ADDR"];
            string userId = (UserDataHelper.Data != null) ? UserDataHelper.Data.UserId.ToString() : null;
            string channel = GetChannel(filterContext);
            string trackingIdentifier = Guid.NewGuid().ToString();
            IEnumerable<TrackingData> lst = GetTrackingData(filterContext);
            
            //Track all info needed for this action
            foreach (TrackingData trackingData in lst)
                TrackingHelper.Save(controllerName, actionName, trackingIdentifier, ipAdress, userId, channel, trackingData.Id,
                                    trackingData.AdditionalData);
        }

        #endregion

        #region TrackingData

        /// <summary>
        /// Class used to serialize the Ids and AdditionalData we need to save in the tracking
        /// </summary>
        private class TrackingData
        {
            public TrackingData()
            {
            }
            public TrackingData(int? id)
            {
                Id = id;
            }
            public TrackingData(int? id, string additionalData)
            {
                Id = id;
                AdditionalData = additionalData;
            }

            public int? Id { get; private set; }
            public string AdditionalData { get; private set; }
        }

        #endregion

        #region Logic Methods

        /// <summary>
        /// Get the channel for wich the user accesed the site.
        /// </summary>
        /// <param name="filterContext"></param>
        /// <returns>The channel for wich the user accesed the site.</returns>
        private static string GetChannel(ControllerContext filterContext)
        {
            bool isLoggedIn = filterContext.HttpContext.User.Identity.IsAuthenticated;
            string channel = filterContext.HttpContext.Request.QueryString[qsChannel];

            if (!string.IsNullOrEmpty(channel) && !isLoggedIn)
                CookieManager.Set(ckChannel, channel);

            if (!isLoggedIn && CookieManager.Has(ckChannel))
            {
                channel = (string)CookieManager.Get(ckChannel);
            }
            else if (UserDataHelper.Data != null)
            {
               channel = UserDataHelper.Data.Channel;
            }

            return channel;
        }

        /// <summary>
        /// Get a list of TrackinData with the info to track for the current action. 
        /// </summary>
        /// <param name="filterContext">FilterContext of the executed action.</param>
        /// <remarks>We use the ViewData Model to get the info for some actions.</remarks>
        /// <returns>A list of TrackingData with the info to track.</returns>
        private static IEnumerable<TrackingData> GetTrackingData(ActionExecutedContext filterContext)
        {
            List<TrackingData> result = new List<TrackingData>();
            string actionName = filterContext.ActionDescriptor.ActionName;
            
            switch (actionName)
            {
                case "TrackOutfitUpdater":
                    OutfitUpdaterView ouv = filterContext.Controller.ViewData.Model as OutfitUpdaterView;
                    if (ouv != null)
                        result.Add(new TrackingData(int.Parse(ouv.OutifUpdaterId), ouv.OutfitId));
                    break;

                case "SelectFashionFlavor":
                    List<UserFlavor> lstFlavors = filterContext.Controller.ViewData.Model as List<UserFlavor>;
                    if (lstFlavors != null)
                        result.AddRange(lstFlavors.Select(userFlavor => new TrackingData(userFlavor.Flavor.Id)));
                    else
                        result.Add(new TrackingData());
                    break;

                case "SetWeight":
                    List<UserFlavor> lstUserFlavors = filterContext.Controller.ViewData.Model as List<UserFlavor>;
                    if (lstUserFlavors != null)
                        result.AddRange(
                            lstUserFlavors.Select(
                                userFlavor => new TrackingData(userFlavor.Flavor.Id, userFlavor.Weight.ToString())));
                    break;

                case "SelectEventType":
                    List<EventType> lstEventTypes = filterContext.Controller.ViewData.Model as List<EventType>;
                    if (lstEventTypes != null)
                        result.AddRange(lstEventTypes.Select(eventType => new TrackingData(eventType.Id)));
                    break;

                case "GetSilouhette":
                    int silouhetteId = Convert.ToInt32(filterContext.Controller.ViewData.Model);
                    result.Add(new TrackingData(silouhetteId));
                    break;

                case "TrackMyGarmentsItem":
                    int myGarmentsId = Convert.ToInt32(filterContext.Controller.ViewData.Model);
                    result.Add(new TrackingData(myGarmentsId));
                    break;

                case "TrackMyWishListItem":
                    int myWishListId = Convert.ToInt32(filterContext.Controller.ViewData.Model);
                    result.Add(new TrackingData(myWishListId));
                    break;

                case "TrackFabric":
                    int fabricId = Convert.ToInt32(((JsonResult) filterContext.Result).Data);
                    result.Add(new TrackingData(fabricId));
                    break;

                case "TrackPattern":
                    int patternId = Convert.ToInt32(((JsonResult)filterContext.Result).Data);
                    result.Add(new TrackingData(patternId));
                    break;

                case "TrackValidationError":
                    string error = (((JsonResult) filterContext.Result).Data).ToString();
                    result.Add(new TrackingData(null, error));
                    break;

                default:
                    result.Add(new TrackingData());
                    break;
            }
            
            return result;
        }

        #endregion
    }
}
