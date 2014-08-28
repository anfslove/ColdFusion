<!--------------------------------------------------------------------------
  -- Purpose: Logging the event from SendGrid
  -- Input:
        JSON array from SendGrid
  -- Output:
        Each event detail information
  -- Create Date:May 30, 2014
  -- Create By:anfslove
  -- Copyright:anfslove
  -- Modify By:
--------------------------------------------------------------------------->
<cftry>
	<cfset requestBody = toString(getHttpRequestData().content) />
	<cfif trim(requestBody) NEQ "">
		<cfset arrayOfStructs = DeserializeJSON(requestBody) />
		<cfif arrayLen(arrayOfStructs)>
			<cfloop from="1" index="i" to="#arrayLen(arrayOfStructs)#">
				<cfset notitem = arrayOfStructs[i]>
				<cfif StructKeyExists(notitem, "email")>
					<cfparam name="promo" default="">
					<cfparam name="event"  default="">
					<cfparam name="reason" default="">
					<cfparam name="status" default="">
					<cfparam name="type" default="">
					<cfif StructKeyExists(notitem, "promo")>
						<cfset promo = notitem.promo>
					</cfif>
					<cfif StructKeyExists(notitem, "event")>
						<cfset event = notitem.event>
					</cfif>
					<cfif StructKeyExists(notitem, "reason")>
						<cfset reason = notitem.reason>
					</cfif>
					<cfif StructKeyExists(notitem, "status")>
						<cfset status = notitem.status>
					</cfif>
					<cfif StructKeyExists(notitem, "type")>
						<cfset type = notitem.type>
					</cfif>
					<cfquery name="qry" datasource="QuizJinni">
						INSERT INTO	table_name(
							sb_email,sb_promo,sb_event,sb_reason,sb_status,sb_type,sb_created_date
						)VALUES(
							<cfqueryparam value="#notitem.email#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#promo#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#event#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#reason#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#status#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#type#" cfsqltype="cf_sql_varchar">,
							getDate()
						)
					</cfquery>
				</cfif>
			</cfloop>
            
		</cfif>
	</cfif>

	<cfcatch>
		<cfset errorMsg = cfcatch.message & "<br />" & cfcatch.detail>
        <cffile action = "write"  
            file = "#ExpandPath('./')#sendgrid_webhook.log"  
            output = "#errorMsg#">
	</cfcatch>
</cftry>

<cfabort>
*********************************************************************************
JSON array from SendGrid like this:
[
    {
        "email": "john.doe@sendgrid.com",
        "sg_event_id": "VzcPxPv7SdWvUugt-xKymw",
        "sg_message_id": "142d9f3f351.7618.254f56.filter-147.22649.52A663508.0",
        "timestamp": 1386636112,
        "smtp-id": "<142d9f3f351.7618.254f56@sendgrid.com>",
        "event": "processed",
        "category":["category1","category2","category3"],
        "id": "001",
        "purchase":"PO1452297845",
        "uid": "123456"
    },
    {
        "email": "not an email address",
        "smtp-id": "<4FB29F5D.5080404@sendgrid.com>",
        "timestamp": 1386636115,
        "reason": "Invalid",
        "event": "dropped",
        "category":["category1","category2","category3"],
        "id": "001",
        "purchase":"PO1452297845",
        "uid": "123456"
    },
    {
        "email": "john.doe@sendgrid.com",
        "sg_event_id": "vZL1Dhx34srS-HkO-gTXBLg",
        "sg_message_id": "142d9f3f351.7618.254f56.filter-147.22649.52A663508.0",
        "timestamp": 1386636113,
        "smtp-id": "<142d9f3f351.7618.254f56@sendgrid.com>",
        "event": "delivered",
        "category":["category1","category2","category3"],
        "id": "001",
        "purchase":"PO1452297845",
        "uid": "123456"
    },
    {
        "email": "john.smith@sendgrid.com",
        "timestamp": 1386636127,
        "uid": "123456",
        "ip": "174.127.33.234",
        "purchase": "PO1452297845",
        "useragent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36",
        "id": "001",
        "category": ["category1","category2","category3"],
        "event": "open"
    },
    {
        "uid": "123456",
        "ip": "174.56.33.234",
        "purchase":"PO1452297845",
        "useragent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36",
        "event":"click",
        "email": "john.doe@sendgrid.com",
        "timestamp":1386637216,
        "url":"http://www.google.com/",
        "category":["category1","category2","category3"],
        "id":"001"
    },
    {
        "uid": "123456",
        "status": "5.1.1",
        "sg_event_id": "X_C_clhwSIi4EStEpol-SQ",
        "reason": "550 5.1.1 The email account that you tried to reach does not exist. Please try double-checking the recipient's email address for typos or unnecessary spaces. Learn more at http: //support.google.com/mail/bin/answer.py?answer=6596 do3si8775385pbc.262 - gsmtp ",
        "purchase": "PO1452297845",
        "event": "bounce",
        "email": "asdfasdflksjfe@sendgrid.com",
        "timestamp": 1386637483,
        "smtp-id": "<142da08cd6e.5e4a.310b89@localhost.localdomain>",
        "type": "bounce",
        "category": ["category1","category2","category3"],
        "id": "001"
    },
    {
        "email":"john.doe@gmail.com",
        "timestamp":1386638248,
        "uid":"123456",
        "purchase":"PO1452297845",
        "id":"001",
        "category":["category1","category2","category3"],
        "event":"unsubscribe"
    }
]