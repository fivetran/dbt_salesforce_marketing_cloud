-- aggregates at the email grain.
with emails as (
  select *
  from {{ ref('stg_salesforce_marketing_cloud__email') }}
  where coalesce(_fivetran_active, true)

), sends as (
  select *
  from {{ ref('stg_salesforce_marketing_cloud__send') }}
  where not _fivetran_deleted 

), sends_stats as (
  select 
    emails.email_id,
    emails.source_relation,
    count(distinct sends.send_id) as total_unique_sends,
    coalesce(sum(sends.number_sent), 0) as total_emails_sent,
    coalesce(sum(sends.unique_opens), 0) as total_unique_opens,
    coalesce(sum(sends.unique_clicks), 0) as total_unique_clicks,
    coalesce(sum(sends.unsubscribes), 0) as total_unsubscribes,
    coalesce(sum(sends.forwarded_emails), 0) as total_forwards,
    coalesce(sum(sends.number_delivered), 0) as total_deliveries,
    coalesce(sum(sends.number_targeted), 0) as total_targets,
    coalesce(sum(sends.hard_bounces + sends.soft_bounces + sends.other_bounces), 0) as total_bounces
  from emails
  left join sends
    on sends.email_id = emails.email_id
    and sends.source_relation = emails.source_relation
  group by 1,2

), sends_aggs as (
  select
    sends_stats.*,
    coalesce(total_unique_opens / nullif(total_emails_sent, 0), 0) as open_rate, --use safe divide in dbt 
    coalesce(total_unique_clicks / nullif(total_emails_sent, 0), 0) as click_through_rate, --use safe divide in dbt 
    coalesce(total_unsubscribes / nullif(total_emails_sent, 0), 0) as unsubscribe_rate --use safe divide in dbt 
  from sends_stats

), events_enhanced as ( 
  select *
  from {{ ref('salesforce_marketing_cloud__events_enhanced') }}

), events_stats as (
  select 
    emails.email_id,
    emails.source_relation,
    sum(case when events_enhanced.is_sent then 1 else 0 end) as total_send_events,
    sum(case when events_enhanced.is_open then 1 else 0 end) as total_open_events,
    sum(case when events_enhanced.is_click then 1 else 0 end) as total_click_events,
    sum(case when events_enhanced.is_bounce then 1 else 0 end) as total_bounce_events,
    sum(case when events_enhanced.is_forward then 1 else 0 end) as total_forward_events,
    sum(case when events_enhanced.is_unsubscribe then 1 else 0 end) as total_unsubscribe_events,
    sum(case when events_enhanced.is_survey_response then 1 else 0 end) as total_survey_response_events
  from emails
  left join sends
    on sends.email_id = emails.email_id
    and sends.source_relation = emails.source_relation
  left join events_enhanced
    on events_enhanced.send_id = sends.send_id
    and events_enhanced.source_relation = sends.source_relation
  group by 1,2

), joined as (
  select
    emails.*,
    sends_aggs.total_unique_sends,
    sends_aggs.total_emails_sent,
    sends_aggs.total_unique_opens,
    sends_aggs.total_unique_clicks,
    sends_aggs.total_unsubscribes,
    sends_aggs.total_forwards,
    sends_aggs.total_deliveries,
    sends_aggs.total_targets,
    sends_aggs.total_bounces,
    sends_aggs.open_rate, --use safe divide in dbt 
    sends_aggs.click_through_rate, --use safe divide in dbt 
    sends_aggs.unsubscribe_rate,
    events_stats.total_send_events,
    events_stats.total_open_events,
    events_stats.total_click_events,
    events_stats.total_bounce_events,
    events_stats.total_forward_events,
    events_stats.total_unsubscribe_events,
    events_stats.total_survey_response_events
  from emails
  left join sends_aggs
    on sends_aggs.email_id = emails.email_id
    and sends_aggs.source_relation = emails.source_relation
  left join events_stats
    on events_stats.email_id = emails.email_id
    and events_stats.source_relation = emails.source_relation
)

select * 
from joined