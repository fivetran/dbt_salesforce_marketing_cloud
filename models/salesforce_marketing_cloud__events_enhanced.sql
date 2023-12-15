-- events grain with sends and email information added.
with events as( 
  select
    *,
    -- the below list comes from: https://developer.salesforce.com/docs/marketing/marketing-cloud/guide/eventtype.html
    lower(event_type) = 'click' as is_click,
    lower(event_type) = 'deliveredevent' as is_delivered_event,
    lower(event_type) = 'forwardedemail' as is_forward,
    lower(event_type) = 'forwardedemailoptin' as is_opt_in,
    lower(event_type) in ('hardbounce', 'otherbounce', 'softbounce') as is_bounce,
    lower(event_type) = 'open' as is_open,
    lower(event_type) = 'notsent' as is_not_sent, 
    lower(event_type) = 'sent' as is_sent,
    lower(event_type) = 'survey' as is_survey_response,
    lower(event_type) = 'unsubscribe' as is_unsubscribe
  from ref('stg_salesforce_marketing_cloud__event')
  where not _fivetran_deleted

), sends as (
  select *
  from ref('stg_salesforce_marketing_cloud__send')

), emails as (
  select *
  from ref('stg_salesforce_marketing_cloud__email')

), joined as (
  select
    events.*,
    sends.created_date as send_created_date,
    sends.bcc_email,
    sends.from_address,
    sends.from_name,
    sends.preview_url,
    sends.subject,
    email.name,
    email.subject,
    email.created_date as email_created_date
  from events
  left join sends
    on sends.id = events.send_id
  left join emails
    on emails.id = sends.email_id
)
select *
from joined