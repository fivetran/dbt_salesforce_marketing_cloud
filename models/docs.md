{% docs _fivetran_deleted %} Indicates if the record was soft-deleted by Fivetran. {% enddocs %}

{% docs _fivetran_synced %} Timestamp the record was synced by Fivetran. {% enddocs %}

{% docs _fivetran_start %} Timestamp when the record was first created or modified in the source. {% enddocs %}

{% docs _fivetran_end %} Timestamp marking the end of a record being active. {% enddocs %}

{% docs _fivetran_active %} TRUE if it is the currently active record. FALSE if it is a historical version of the record. Only one version of the record can be TRUE. {% enddocs %}

{% docs alias %} Name of link contained in message. {% enddocs %}

{% docs asset_id %} Unique identifier of an asset. {% enddocs %}

{% docs asset_type_id %} Unique identifier of the event. {% enddocs %}

{% docs auto_add_subscribers %} Indicates whether a triggered send recipient is added to a subscriber list. {% enddocs %}

{% docs auto_update_subscribers %} Indicates if any subscriber information is updated as part of a triggered send. {% enddocs %}

{% docs batch_id %} Ties triggered send sent events to other events (like clicks and opens that occur at a later date and time) {% enddocs %}

{% docs bcc_email %} Indicates email addresses to receive blind carbon copy of a message. {% enddocs %}

{% docs bounce_category %} Defines category for bounce associated with a bounced email. {% enddocs %}

{% docs bounce_type %} Defines type of bounce associated with a bounced email. {% enddocs %}

{% docs character_set %} Indicates encoding used in an email message. {% enddocs %}

{% docs click_through_rate %} Percentage of unique clicks out of total emails sent. {% enddocs %}

{% docs created_date %} Indicates the time the object was created. {% enddocs %}

{% docs days_subscribed %} Number of days a subscriber is or was subscribed. {% enddocs %}

{% docs description %} Describes and provides information regarding the object. {% enddocs %}

{% docs duplicates %} Represent the number of duplicate email addresses associated with a send (exists only when a send occurs to multiple lists). {% enddocs %}

{% docs dynamic_email_subject %} Contains content to be used in a dynamic subject line. {% enddocs %}

{% docs email %} Each record represents an email. {% enddocs %}

{% docs email_address %} Contains the email address for a subscriber. Indicates the data extension field contains email address data. {% enddocs %}

{% docs email_id %} Unique identifier of the email. {% enddocs %}

{% docs email_name %} Specifies the name of an email message associated with a send. {% enddocs %}

{% docs email_type_preference %} The format to use when sending an email to a subscriber. Valid values include (HTML, Text). {% enddocs %}

{% docs event %} Each record represents an event. {% enddocs %}

{% docs event_date %} Date when a tracking event occurred. {% enddocs %}

{% docs event_id %} Unique identifier of the event. {% enddocs %}

{% docs event_type %} The type of tracking event. {% enddocs %}

{% docs existing_undeliverables %} Indicates whether bounces occurred on previous send. {% enddocs %}

{% docs existing_unsubscribes %} Indicates whether unsubscriptions occurred on previous send. {% enddocs %}

{% docs forwarded_emails %} Number of emails forwarded for a send. {% enddocs %}

{% docs from_address %} Indicates From address associated with a object. Deprecated for email send definitions and triggered send definitions. {% enddocs %}

{% docs from_name %} Specifies the default email message From Name. Deprecated for email send definitions and triggered send definitions. {% enddocs %}

{% docs hard_bounces %} Indicates number of hard bounces associated with a send. {% enddocs %}

{% docs invalid_addresses %} Specifies the number of invalid addresses associated with a send. {% enddocs %}

{% docs is_active %} Indicates if a subscriber has a status of active. {% enddocs %}

{% docs is_always_on %} Indicates whether the request can be performed while the system is is maintenance mode. A value of true indicates that the system processes the request. {% enddocs %}

{% docs is_multipart %} Indicates whether the email is sent with Multipart/MIME enabled. {% enddocs %}

{% docs is_wrapped %} Indicates whether an email send contains the links necessary to process tracking information for clicks. {% enddocs %}

{% docs last_clicked %} Indicates last time a link included in a message was clicked. {% enddocs %}

{% docs link %} Each record represents a link. {% enddocs %}

{% docs link_id %} Unique identifier of the link. {% enddocs %}

{% docs link_send %} Each record represents the relationship between a link and a send record. {% enddocs %}

{% docs list %} Each record represents a list. {% enddocs %}

{% docs list_id %} Unique identifier of the list. {% enddocs %}

{% docs list_name %} Name of a specific list. {% enddocs %}

{% docs list_subscriber %} Each record represents a relationship between a list and a subscriber record. {% enddocs %}

{% docs list_subscriber_id %} Unique identifier of the list_subscriber record. {% enddocs %}

{% docs list_type %} Indicates type of specific list. Valid values include Public, Private, Salesforce, GlobalUnsubscribe, and Master. {% enddocs %}

{% docs missing_addresses %} Specifies number of missing addresses encountered within a send. {% enddocs %}

{% docs modified_date %} Indicates the last time object information was modified. {% enddocs %}

{% docs most_recent_bounce %} Subscriber's most recent bounce. {% enddocs %}

{% docs most_recent_click %} Subscriber's most recent click. {% enddocs %}

{% docs most_recent_forward %} Subscriber's most recent forward. {% enddocs %}

{% docs most_recent_open %} Subscriber's most recent open. {% enddocs %}

{% docs most_recent_send %} Subscriber's most recent send. {% enddocs %}

{% docs most_recent_survey_response %} Subscriber's most recent survey response. {% enddocs %}

{% docs name %} Name of the object. {% enddocs %}

{% docs number_delivered %} Number of sent emails that did not bounce. {% enddocs %}

{% docs number_errored %} Number of emails not sent as part of a send because an error occurred while trying to build the email. {% enddocs %}

{% docs number_excluded %} Indicates the number recipients excluded from an email send because of a held, unsubscribed, master unsubscribed, or global unsubscribed status. {% enddocs %}

{% docs number_of_bounces %} Subscriber's number of bounces. {% enddocs %}

{% docs number_of_clicks %} Subscriber's number of clicks. {% enddocs %}

{% docs number_of_forwards %} Subscriber's number of forwards. {% enddocs %}

{% docs number_of_opens %} Subscriber's number of opens. {% enddocs %}

{% docs number_of_sends %} Subscriber's number of sends. {% enddocs %}

{% docs number_of_survey_responses %} Subscriber's number of survey responses. {% enddocs %}

{% docs number_sent %} Number of emails actually sent as part of an email send. This number reflects all of the sent messages and may include bounced messages. {% enddocs %}

{% docs number_targeted %} Indicates the number of possible recipients for an email send. This number does not include unsubscribed or excluded subscribers for a given list or data extension. {% enddocs %}

{% docs open_rate %} Percentage of unique opens out of total emails sent. {% enddocs %}

{% docs opt_in_subscriber_key %} Specifies the subscriber of a subscriber opted in via forwarded email. {% enddocs %}

{% docs other_bounces %} Specifies number of Other-type bounces in a send. {% enddocs %}

{% docs pre_header %} Contains text used in preheader of email message on mobile devices. {% enddocs %}

{% docs preview_url %} Indicates URL used to preview the message associated with a send. {% enddocs %}

{% docs priority %} Defines the priority for a triggered send. Valid values include Low, Medium, and High. {% enddocs %}

{% docs question %} Specifies question associated with a survey event. {% enddocs %}

{% docs send %} Each record represents a send. {% enddocs %}

{% docs send_date %} Indicates the date on which a send occurred. Set this value to have a CST (Central Standard Time) value. {% enddocs %}

{% docs send_id %} Unique identifier of the send. {% enddocs %}

{% docs send_limit %} Indicates limit of messages to send as part of a send definition within a predefined send window. {% enddocs %}

{% docs send_status %} Defines status of an address. {% enddocs %}

{% docs send_window_close %} Defines the end of a send window for a send definition. {% enddocs %}

{% docs send_window_open %} Defines the beginning of a send window for a send definition. {% enddocs %}

{% docs smtp_code %} Contains SMTP code related to a bounced email. {% enddocs %}

{% docs smtp_reason %} Contains SMTP reason associated with a bounced email {% enddocs %}

{% docs soft_bounces %} Indicates number of soft bounces associated with a specific send. {% enddocs %}

{% docs source_relation %} The record's source if the unioning functionality is used. Otherwise this field will be empty. {% enddocs %}

{% docs subject %} Contains subject area information for a message. {% enddocs %}

{% docs subscriber %} Each record represents a subscriber. {% enddocs %}

{% docs subscriber_id %} Unique identifier of the subscriber. {% enddocs %}

{% docs subscriber_key %} Salesforce identification of a specific subscriber. {% enddocs %}

{% docs subscriber_status %} Status of the subscriber. {% enddocs %}

{% docs text_body %} Contains raw text body of a message. {% enddocs %}

{% docs total_clicks %} Indicates total number of clicks on link in message. {% enddocs %}

{% docs total_bounces %} Total bounces from the sends source. {% enddocs %}

{% docs total_bounce_events %} Total bounce events. {% enddocs %}

{% docs total_click_events %} Total bounce events. {% enddocs %}

{% docs total_deliveries %} Total deliveries from the sends source. {% enddocs %}

{% docs total_emails_sent %} Total sent emails. {% enddocs %}

{% docs total_forwards %} Total forwards from the sends source. {% enddocs %}

{% docs total_forward_events %} Total forward events. {% enddocs %}

{% docs total_open_events %} Total open events. {% enddocs %}

{% docs total_send_events %} Total send events. {% enddocs %}

{% docs total_survey_response_events %} Total survey response events. {% enddocs %}

{% docs total_targets %} Total tarets from the sends source. {% enddocs %}

{% docs total_unique_clicks %} Total unique clicks from the sends source. {% enddocs %}

{% docs total_unique_opens %} Total unique opens from the sends source. {% enddocs %}

{% docs total_unique_sends %} Total unique sends from the sends source. {% enddocs %}

{% docs total_unsubscribe_events %} Total unsubscribe events. {% enddocs %}

{% docs total_unsubscribes %} Total unsubscribes from the sends source. {% enddocs %}

{% docs triggered_send %} Each record represents a triggered send. {% enddocs %}

{% docs triggered_send_id %} Unique identifier of the triggered send. {% enddocs %}

{% docs triggered_send_status %} Status of the triggered send. {% enddocs %}

{% docs unique_clicks %} Indicates number of unique clicks. {% enddocs %}

{% docs unique_opens %} Indicates number of unique opens resulting from a triggered send. {% enddocs %}

{% docs unsubscribe_rate %} Percentage of unsubscribes out of total emails sent. {% enddocs %}

{% docs unsubscribed_date %} Represents date subscriber unsubscribed from a list. {% enddocs %}

{% docs unsubscribed_list_id %} Indicates the list involved in an unsubscribe event. {% enddocs %}

{% docs unsubscribes %} Indicates the number of unsubscribe events associated with a send. {% enddocs %}

{% docs url %} Indicates URL included in an event or configuration. {% enddocs %}