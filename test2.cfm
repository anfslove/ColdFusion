<cfscript>
	util = createObject("component","Utilities");

	originalString1 = "HWTL华威天立Webtribe";
	cleanedString1 = util.makeCleanString(originalString1);

	originalString2 = "Can you feel my world";
	cleanedString2 = util.makeCleanString(originalString2);

</cfscript>
<cfoutput>
	Original String 1 : #originalString1#
	<br />
	Cleaned String 1 : #cleanedString1#
	<br />
	<br />
	Original String 2 : #originalString2#
	<br />
	Cleaned String 2 : #cleanedString2#
</cfoutput>