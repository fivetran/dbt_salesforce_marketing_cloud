-- aggregates at the send grain.
with sends as (
  select *
  from {{ ref('stg_salesforce_marketing_cloud__send') }}

), sends_aggs as (
  select
    sends.*,
    coalesce({{ dbt_utils.safe_divide('unique_opens', 'number_sent') }}, 0) as open_rate,
    coalesce({{ dbt_utils.safe_divide('unique_clicks', 'number_sent') }}, 0) as click_through_rate,
    coalesce({{ dbt_utils.safe_divide('unsubscribes', 'number_sent') }}, 0) as unsubscribe_rate
  from sends

), events_enhanced as ( 
  select *
  from {{ ref('salesforce_marketing_cloud__events_enhanced') }}

), events_stats as (
  select 
    sends.source_relation,
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
    and events_enhanced.source_relation = sends.source_relation
  group by 1,2

), joined as (
  select
    sends_aggs.source_relation,
    sends_aggs.bcc_email,
    sends_aggs.created_date,
    sends_aggs.duplicates,
    sends_aggs.email_id,
    sends_aggs.email_name,
    sends_aggs.existing_undeliverables,
    sends_aggs.existing_unsubscribes,
    sends_aggs.forwarded_emails,
    sends_aggs.from_address,
    sends_aggs.from_name,
    sends_aggs.hard_bounces,
    sends_aggs.send_id,
    sends_aggs.invalid_addresses,
    sends_aggs.is_always_on,
    sends_aggs.is_multipart,
    sends_aggs.missing_addresses,
    sends_aggs.modified_date,
    sends_aggs.number_delivered,
    sends_aggs.number_errored,
    sends_aggs.number_excluded,
    sends_aggs.number_sent,
    sends_aggs.number_targeted,
    sends_aggs.other_bounces,
    sends_aggs.preview_url,
    sends_aggs.send_date,
    sends_aggs.soft_bounces,
    sends_aggs.send_status,
    sends_aggs.subject,
    sends_aggs.unique_clicks,
    sends_aggs.unique_opens,
    sends_aggs.unsubscribes,
    sends_aggs.open_rate,
    sends_aggs.click_through_rate,
    sends_aggs.unsubscribe_rate,
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
    and events_stats.source_relation = sends_aggs.source_relation
)

select * 
from joined