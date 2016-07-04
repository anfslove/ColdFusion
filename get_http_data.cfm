<cfset requestBody = GetHttpRequestData()>
<cfset cont = requestBody.content>
<cfoutput>#cont#</cfoutput>
<cfif IsJSON(cont)>
	Yes
<cfelse>
	No
</cfif>