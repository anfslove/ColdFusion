<cfcomponent output="false">
  <cffunction name="getPerson" access="remote" returnFormat="json" output="false">

    <cfset var person = structNew()>
    <cfset person["name"] = "Tom">
    <cfset person["email"] = "tom@163.com">
    <cfset person["gender"] = "m">

    <cfreturn person>
  </cffunction>
</cfcomponent>