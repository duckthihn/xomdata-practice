-- Xom Data · Delivery performance by size class
-- Problem: https://xomdata.com/practice/medium-case-160
-- Solved: 2026-08-25

with vehicle_stats as
(
    -- shipment_count + delivered
    select
        -- t.id as truck_id,
        -- s.id as shipment_id,
        t.vehicle_type,
        t.capacity_tons,
        count(s.id) as shipment_count,
        sum(
            case when results = 'success'
                then 1
                else 0
            end
        ) as delivered     
    from trucks t
    join shipments s on s.truck_id = t.id
    join deliveries d on d.shipment_id = s.id
    group by vehicle_type
),
vehicle_metrics as
(
    select
        *,
        case
            when capacity_tons >= 10 then 'Large Truck'
            when capacity_tons >= 5 then 'Medium Truck'
            else 'Small Truck'
        end as size_class,
        round(delivered * 100.0 / shipment_count, 2) as delivery_rate
    from vehicle_stats
),
vehicle_ranking as
(
    select
        vehicle_type,
        capacity_tons,
        shipment_count,
        size_class,
        delivered,
        delivery_rate,
        rank() over(partition by size_class order by delivery_rate desc) as rank_in_size
    from vehicle_metrics
)



select * from vehicle_ranking
