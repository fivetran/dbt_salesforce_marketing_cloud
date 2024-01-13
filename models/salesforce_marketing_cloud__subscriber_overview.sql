-- aggregates at the subscriber grain
with subscribers as ( 
  select *
  from {{ ref('salesforce_marketing_cloud__subscribers_enhanced') }}

), events_enhanced as ( 
  select *
  from {{ ref('salesforce_marketing_cloud__events_enhanced') }}

), aggs as (
    select 
      subscribers.source_relation,
      subscribers.subscriber_id,
      subscribers.subscriber_key,
      subscribers.created_date,
      subscribers.email_address,
      subscribers.email_type_preference,
      subscribers.subscriber_status,
      subscribers.is_active,
      subscribers.unsubscribed_date,
      case when subscribers.unsubscribed_date is not null 
        then {{ dbt.datediff("subscribers.created_date", "subscribers.unsubscribed_date", "day") }} 
        else {{ dbt.datediff("subscribers.created_date", "current_date", "day") }} 
        end as days_subscribed,
      sum(case when events_enhanced.is_sent then 1 else 0 end) as number_of_sends,
      max(case when events_enhanced.is_sent then events_enhanced.event_date end) as most_recent_send,
      sum(case when events_enhanced.is_open then 1 else 0 end) as number_of_opens,
      max(case when events_enhanced.is_open then events_enhanced.event_date end) as most_recent_open,
      sum(case when events_enhanced.is_click then 1 else 0 end) as number_of_clicks,
      max(case when events_enhanced.is_click then events_enhanced.event_date end) as most_recent_click,
      sum(case when events_enhanced.is_bounce then 1 else 0 end) as number_of_bounces,
      max(case when events_enhanced.is_bounce then events_enhanced.event_date end) as most_recent_bounce,
      sum(case when events_enhanced.is_forward then 1 else 0 end) as number_of_forwards,
      max(case when events_enhanced.is_forward then events_enhanced.event_date end) as most_recent_forward,
      sum(case when events_enhanced.is_survey_response then 1 else 0 end) as number_of_survey_responses,
      max(case when events_enhanced.is_survey_response then events_enhanced.event_date else null end) as most_recent_survey_response
    from subscribers
    left join events_enhanced
        on events_enhanced.subscriber_key = subscribers.subscriber_key
        and events_enhanced.source_relation = subscribers.source_relation
    {{ dbt_utils.group_by(10) }}
)

select * 
from aggs
