<cfset myStruct = structNew()>
<cfset myStruct.firstName = "Pengcheng">
<cfset myStruct.lastName = "Sun">
<cfset myStruct["enName"] = "Rain">
<cfdump var="#myStruct#" />