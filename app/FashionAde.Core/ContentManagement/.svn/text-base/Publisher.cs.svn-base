using SharpArch.Core.DomainModel;
using System;

namespace FashionAde.Core.ContentManagement
{
    public class Publisher : Entity
    {
        private string firstName;
        private string lastName;
        private string email;        
        private PublishingRole role;

        public Publisher()
        {
            
        }

        public Publisher(int id)
        {
            this.Id = id;
        }


        public virtual string FirstName
        {
            get { return firstName; }
            set { firstName = value; }
        }

        public virtual string LastName
        {
            get { return lastName; }
            set { lastName = value; }
        }

        public virtual string Email
        {
            get { return email; }
            set { email = value; }
        }

        public virtual PublishingRole Role
        {
            get { return role; }
            set { role = value; }
        }

        public virtual bool CanCreate()
        {
            throw new NotImplementedException();
        }

        public virtual bool CanApprove()
        {
            throw new NotImplementedException();
        }

        public virtual bool CanEdit()
        {
            throw new NotImplementedException();
        }
    }
}