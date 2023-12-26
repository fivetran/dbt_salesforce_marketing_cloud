-- aggregates at the send grain.
with sends as (
  select *
  from from {{ ref('stg_salesforce_marketing_cloud__send') }}
  where not _fivetran_deleted

), sends_aggs as (
  select
    sends.*,
    coalesce(unique_opens / nullif(number_sent, 0), 0) as open_rate, --use safe divide in dbt
    coalesce(unique_clicks / nullif(number_sent, 0), 0) as click_through_rate, --use safe divide in dbt
    coalesce(unsubscribes / nullif(number_sent, 0), 0) as unsubscribe_rate --use safe divide in dbt
  from sends

), events_enhanced as ( 
  select *
  from from {{ ref('int_salesforce_marketing_cloud__events_enhanced') }}

), events_stats as (
  select 
    sends.send_id,
    sum(case when events_enhanced.is_sent then 1 else 0 end) as total_send_events,
    sum(case when events_enhanced.is_open then 1 else 0 end) as total_open_events,
    sum(case when events_enhanced.is_click then 1 else 0 end) as total_click_events,
    sum(case when events_enhanced.is_bounce then 1 else 0 end) as total_bounce_events,
    sum(case when events_enhanced.is_forward then 1 else 0 end) as total_forward_events,
    sum(case when events_enhanced.is_unsubscribe then 1 else 0 end) as total_unsubscribe_events,
    sum(case when events_enhanced.is_survey_response then 1 else 0 end) as total_survey_response_events
  from sends
  left join events_enhanced
    on events_enhanced.send_id = sends.send_id
  group by 1

), joined as (
  select
    sends_aggs.*,
    events_stats.total_send_events,
    events_stats.total_open_events,
    events_stats.total_click_events,
    events_stats.total_bounce_events,
    events_stats.total_forward_events,
    events_stats.total_unsubscribe_events,
    events_stats.total_survey_response_events
  from sends_aggs
  left join events_stats
    on events_stats.send_id = sends_aggs.send_id
)
select * 
from joined