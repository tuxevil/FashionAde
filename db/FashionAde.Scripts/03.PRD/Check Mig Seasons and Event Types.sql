 
SELECT generic from 
(select generic from mig_events
union
select cotton from mig_events
union
select linen from mig_events
union
select wool from mig_events
union
select twill from mig_events
union
select jersey from mig_events
union
select silk from mig_events
union
select satin from mig_events
union
select lace from mig_events
union
select brocade from mig_events
union
select leather from mig_events
union
select suede from mig_events
union
select tweed from mig_events
union
select corduroy from mig_events
union
select sweatshirt from mig_events
union
select velvet from mig_events
union
select patent from mig_events
union
select rubber from mig_events
union
select elastic from mig_events
union
select sequin from mig_events
union
select velour from mig_events
union
select fleece from mig_events
union
select knit from mig_events
union
select fur from mig_events
union
select denim from mig_events
union
select boucle from mig_events
union
select metallic from mig_events) TMP
where tmp.generic not in (select migration_eventtypes.eventcode from migration_eventtypes);
