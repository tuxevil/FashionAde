using System.Collections.Generic;
using FashionAde.Core.Clothing;
using SharpArch.Core.DomainModel;
using System.Collections.ObjectModel;

namespace FashionAde.Core.OutfitCombination
{
    public class Combination : Entity
    {
        private CombinationStatus status;
        private CombinationVisibility visibility;

        [DomainSignature]
        public virtual Garment GarmentA { get; set; }
        [DomainSignature]
        public virtual Garment GarmentB { get; set; }
        [DomainSignature]
        public virtual Garment GarmentC { get; set; }
        [DomainSignature]
        public virtual Garment GarmentD { get; set; }
        [DomainSignature]
        public virtual Garment GarmentE { get; set; }

        private IList<Garment> _components = new List<Garment>();
        private IList<Garment> components
        {
            get { return _components; }
            set { _components = value; } 
        }

        private ReadOnlyCollection<Garment> componentsView;
        public virtual ReadOnlyCollection<Garment> Components
        {
            get
            {
                if (this.componentsView == null)
                    componentsView = new ReadOnlyCollection<Garment>(components);
                return this.componentsView;
            }
        }
        

        private IList<Season> _seasons = new List<Season>();
        private IList<Season> seasons
        {
            get { return _seasons; }
            set { _seasons = value; }
        }

        private ReadOnlyCollection<Season> seasonsView;
        public virtual ReadOnlyCollection<Season> Seasons
        {
            get
            {
                if (this.seasonsView == null)
                    seasonsView = new ReadOnlyCollection<Season>(seasons);
                return this.seasonsView;
            }
        }

        private IList<FashionFlavor> _fashionFlavors = new List<FashionFlavor>();
        private IList<FashionFlavor> fashionFlavors
        {
            get { return _fashionFlavors; }
            set { _fashionFlavors = value; }
        }

        private ReadOnlyCollection<FashionFlavor> flavorsView;
        public virtual ReadOnlyCollection<FashionFlavor> FashionFlavors
        {
            get
            {
                if (this.flavorsView == null)
                    flavorsView = new ReadOnlyCollection<FashionFlavor>(fashionFlavors);
                return this.flavorsView;
            }
        }

        private IList<EventType> _eventTypes = new List<EventType>();
        private IList<EventType> eventTypes
        {
            get { return _eventTypes; }
            set { _eventTypes = value; }
        }

        private ReadOnlyCollection<EventType> eventTypesView;
        public virtual ReadOnlyCollection<EventType> EventTypes
        {
            get
            {
                if (this.eventTypesView == null)
                    eventTypesView = new ReadOnlyCollection<EventType>(eventTypes);
                return this.eventTypesView;
            }
        }


        public virtual CombinationStatus Status
        {
            get { return status; }
            protected set { status = value; }

        }

        public virtual CombinationVisibility Visibility
        {
            get { return visibility; }
            set { visibility = value; }

        }

        public virtual void AddFashionFlavor(FashionFlavor g)
        {
            if (!fashionFlavors.Contains(g))
                this.fashionFlavors.Add(g);
        }

        public virtual void AddComponent(Garment g)
        {
            if (g != null && !components.Contains(g))
                this.components.Add(g);
        }

        public virtual void AddSeason(Season s)
        {
            if (!seasons.Contains(s))
                this.seasons.Add(s);
        }

        public virtual void AddEventType(EventType et)
        {
            if (!eventTypes.Contains(et))
                this.eventTypes.Add(et);
        }

        public virtual void MoveToDeadCloset()
        {
            
        }

        public virtual void MoveToColdStorage()
        {

        }


    }
}