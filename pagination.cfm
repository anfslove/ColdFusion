<!--------------------------------------------------------------------------
  -- 目的:分页页码显示
  -- 输入:
		iRowsCount:		记录总个数		[必须输入参数]
		iCurrPageNo:	当前页码		[必须输入参数]
		iPerPageRows:	每页记录个数	[必须输入参数]
		iPageNoNum:		显示页码个数	[非必须 默认3]
		CGI.SCRIPT_NAME
  -- 返回:
		iCurrPageNo:	当前页码
		iPagesCount：	总页码
  -- 日期:2013-01-23
  -- 编码:anfslove
  -- 版权:anfslove
  -- 修改:
--------------------------------------------------------------------------->

<cfif not isDefined("Attributes.iRowsCount")>
	没有定义记录个数<cfabort>
<cfelse>
	<cfset iRowsCount = Attributes.iRowsCount>
</cfif>

<cfif not isDefined("Attributes.iCurrPageNo")>
	没有定义当前页码<cfabort>
<cfelse>
	<cfset iCurrPageNo = Attributes.iCurrPageNo>
</cfif>

<cfif not isDefined("Attributes.iPerPageRows")>
	未定义每页记录个数<cfabort>
<cfelse>
	<cfset iPerPageRows = Attributes.iPerPageRows>
</cfif>

<cfset iPagesCount =  iRowsCount\iPerPageRows>
<cfif iRowsCount Mod iPerPageRows GT 0>
	<cfset iPagesCount = iPagesCount + 1>
</cfif>

<cfparam name="Attributes.iPageNoNum" default="3" type="numeric">
<cfset iPageNoNum = Attributes.iPageNoNum>

<cfif iPageNoNum GT iPagesCount>
	<cfset iPageNoNum = iPagesCount>
</cfif>

<cfset iStartPageNo = 1>
<cfset iEndPageNo = iPageNoNum>

<cfif iPageNoNum Mod 2 GT 0>
	<cfset i = 0>
<cfelse>
	<cfset i = 1>
</cfif>

<cfif iCurrPageNo GT iPageNoNum\2 AND iCurrPageNo LE iPagesCount-iPageNoNum\2 + i>
	<cfset iStartPageNo = iCurrPageNo-iPageNoNum\2>
	<cfset iEndPageNo = iCurrPageNo+iPageNoNum\2 - i>
<cfelseif iCurrPageNo GT iPagesCount-iPageNoNum\2 + i>
	<cfset iStartPageNo = iPagesCount-iPageNoNum + 1>
	<cfset iEndPageNo = iPagesCount>
<cfelse>
	<cfset iStartPageNo = 1>
	<cfset iEndPageNo = iPageNoNum>
</cfif>

<cfoutput>
<div class="ChangePage">
    <span><cfif iCurrPageNo neq "1"><a href="#CGI.SCRIPT_NAME#?iCurrPageNo=#iCurrPageNo-1#"></cfif>上一页<cfif iCurrPageNo neq "1"></a></cfif></span>
    <cfloop index="i" from="#iStartPageNo#" to="#iEndPageNo#" step="1">
    	<a href="#CGI.SCRIPT_NAME#?iCurrPageNo=#i#" <cfif i EQ iCurrPageNo>class="page_active"</cfif> >#i#</a>
    </cfloop>
    <span><cfif iCurrPageNo neq iPagesCount><a href="#CGI.SCRIPT_NAME#?iCurrPageNo=#iCurrPageNo+1#"></cfif>下一页<cfif iCurrPageNo neq iPagesCount></a></cfif></span>
</div>
</cfoutput>