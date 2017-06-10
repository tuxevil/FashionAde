using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SharpArch.Core.DomainModel;

namespace FashionAde.Core.Accounts
{
    public class UserPicture : Entity
    {
        private string description;
        private string pictureUri;
        private RegisteredUser user;
        private UserPictureStatus status;

        public virtual string Description
        {
            get { return description; }
            set { description = value; }
        }

        public virtual string PictureUri
        {
            get { return pictureUri; }
            set { pictureUri = value; }
        }

        public virtual RegisteredUser User
        {
            get { return user; }
            set { user = value; }
        }

        public virtual UserPictureStatus Status
        {
            get { return status; }
            set { status = value; }
        }
    }
}
