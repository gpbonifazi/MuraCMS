<!--- This file is part of Mura CMS.

Mura CMS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, Version 2 of the License.

Mura CMS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. �See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Mura CMS. �If not, see <http://www.gnu.org/licenses/>.

Linking Mura CMS statically or dynamically with other modules constitutes
the preparation of a derivative work based on Mura CMS. Thus, the terms and 	
conditions of the GNU General Public License version 2 (�GPL�) cover the entire combined work.

However, as a special exception, the copyright holders of Mura CMS grant you permission
to combine Mura CMS with programs or libraries that are released under the GNU Lesser General Public License version 2.1.

In addition, as a special exception, �the copyright holders of Mura CMS grant you permission
to combine Mura CMS �with independent software modules that communicate with Mura CMS solely
through modules packaged as Mura CMS plugins and deployed through the Mura CMS plugin installation API,
provided that these modules (a) may only modify the �/trunk/www/plugins/ directory through the Mura CMS
plugin installation API, (b) must not alter any default objects in the Mura CMS database
and (c) must not alter any files in the following directories except in cases where the code contains
a separately distributed license.

/trunk/www/admin/
/trunk/www/tasks/
/trunk/www/config/
/trunk/www/requirements/mura/

You may copy and distribute such a combined work under the terms of GPL for Mura CMS, provided that you include
the source code of that other code when and as the GNU GPL requires distribution of source code.

For clarity, if you create a modified version of Mura CMS, you are not obligated to grant this special exception
for your modified version; it is your choice whether to do so, or to make such modified version available under
the GNU General Public License version 2 �without this exception. �You may, if you choose, apply this exception
to your own modified versions of Mura CMS.
--->
<cfcomponent output="false" extends="mura.cfobject">

<cffunction name="init" returntype="any" access="public" output="false">
	
	
	<cfscript>
	if (NOT IsDefined("request"))
	    request=structNew();
	StructAppend(request, url, "no");
	StructAppend(request, form, "no");
	
	if (IsDefined("request.muraGlobalEvent")){
		StructAppend(request, request.muraGlobalEvent.getAllValues(), "no");
		StructDelete(request,"muraGlobalEvent");	
	}
	</cfscript>
	
	<cfparam name="request.doaction" default=""/>
	<cfparam name="request.month" default="#month(now())#"/>
	<cfparam name="request.year" default="#year(now())#"/>
	<cfparam name="request.display" default=""/>
	<cfparam name="request.startrow" default="1"/>
	<cfparam name="request.pageNum" default="1"/>
	<cfparam name="request.keywords" default=""/>
	<cfparam name="request.tag" default=""/>
	<cfparam name="request.mlid" default=""/>
	<cfparam name="request.noCache" default="0"/>
	<cfparam name="request.categoryID" default=""/>
	<cfparam name="request.relatedID" default=""/>
	<cfparam name="request.linkServID" default=""/>
	<cfparam name="request.track" default="1"/>
	<cfparam name="request.exportHTMLSite" default="0"/>
	<cfparam name="request.returnURL" default=""/>
	<cfparam name="request.showMeta" default="0"/>
		
	<cfset setValue('ValidatorFactory',application.pluginManager.getEventManager(getValue('siteid')).getFactory("Validator"))>
	<cfset setValue('HandlerFactory',application.pluginManager.getEventManager(getValue('siteid')).getFactory("Handler"))>
	<cfset setValue('TranslatorFactory',application.pluginManager.getEventManager(getValue('siteid')).getFactory("Translator"))>
	<cfset setValue("MuraScope",createObject("component","mura.MuraScope"))>
	<cfset getValue('MuraScope').setEvent(this)>
	<cfreturn this />
</cffunction>

<cffunction name="setValue" returntype="any" access="public" output="false">
<cfargument name="property"  type="string" required="true">
<cfargument name="propertyValue" default="" >
<cfargument name="scope" default="request" required="true">
	
	<cfset var theScope=getScope(arguments.scope) />

	<cfset theScope["#arguments.property#"]=arguments.propertyValue />
	<cfreturn this>
</cffunction>

<cffunction name="getValue" returntype="any" access="public" output="false">
<cfargument name="property"  type="string" required="true">
<cfargument name="defaultValue">
<cfargument name="scope" default="request" required="true">
	<cfset var theScope=getScope(arguments.scope)>
	
	<cfif structKeyExists(theScope,"#arguments.property#")>
		<cfreturn theScope["#arguments.property#"] />
	<cfelseif structKeyExists(arguments,"defaultValue")>
		<cfset theScope["#arguments.property#"]=arguments.defaultValue />
		<cfreturn theScope["#arguments.property#"] />
	<cfelse>
		<cfreturn "" />
	</cfif>

</cffunction>

<cffunction name="getAllValues" returntype="any" access="public" output="false">
<cfargument name="scope" default="request" required="true">
		<cfreturn getScope(arguments.scope)  />
</cffunction>

<cffunction name="getScope" returntype="struct" access="public" output="false">
<cfargument name="scope" default="request" required="true">
		
		<cfswitch expression="#arguments.scope#">
		<cfcase value="request">
			<cfreturn request />
		</cfcase>
		<cfcase value="form">
			<cfreturn form />
		</cfcase>
		<cfcase value="url">
			<cfreturn url />
		</cfcase>
		<cfcase value="session">
			<cfreturn session />
		</cfcase>
		<cfcase value="server">
			<cfreturn server />
		</cfcase>
		<cfcase value="application">
			<cfreturn application />
		</cfcase>
		<cfcase value="attributes">
			<cfreturn attributes />
		</cfcase>
		<cfcase value="cluster">
			<cfreturn cluster />
		</cfcase>
		</cfswitch>
		
</cffunction>

<cffunction name="valueExists" returntype="any" access="public" output="false">
	<cfargument name="property" type="string" required="true">
	<cfargument name="scope" default="request" required="true">
		<cfset var theScope=getScope(arguments.scope) />
		<cfreturn structKeyExists(theScope,arguments.property) />
</cffunction>

<cffunction name="removeValue" access="public" output="false">
	<cfargument name="property" type="string" required="true"/>
	<cfargument name="scope" default="request" required="true">
		<cfset var theScope=getScope(arguments.scope) />
		<cfset structDelete(theScope,arguments.property) />
	 returntype="void"
</cffunction>

<cffunction name="getHandler" returntype="any" access="public" output="false">
	<cfargument name="handler">
	<cfargument name="persist" default="true" required="true">
	<cfreturn getValue('HandlerFactory').get(arguments.handler,getValue("localHandler"),arguments.persist) />	
</cffunction>

<cffunction name="getValidator" returntype="any" access="public" output="false">
	<cfargument name="validation">
	<cfargument name="persist" default="true" required="true">
	<cfreturn getValue('ValidatorFactory').get(arguments.validation,getValue("localHandler"),arguments.persist) />	
</cffunction>

<cffunction name="getTranslator" returntype="any" access="public" output="false">
	<cfargument name="translator">
	<cfargument name="persist" default="true" required="true">
	<cfreturn getValue('TranslatorFactory').get(arguments.translator,getValue("localHandler"),arguments.persist) />	
</cffunction>

<cffunction name="getContentRenderer" returntype="any" access="public" output="false">
	<cfreturn getValue('contentRenderer') />	
</cffunction>

<cffunction name="getThemeRenderer" returntype="any" access="public" output="false">
	<cfreturn getValue('themeRenderer') />	
</cffunction>

<cffunction name="getContentBean" returntype="any" access="public" output="false">
	<cfreturn getValue('contentBean') />	
</cffunction>

<cffunction name="getCrumbData" returntype="any" access="public" output="false">
	<cfreturn getValue('crumbdata') />	
</cffunction>

<cffunction name="getSite" returntype="any" access="public" output="false">
	<cfreturn application.settingsManager.getSite(getValue('siteid')) />	
</cffunction>

<cffunction name="getMuraScope" returntype="any" access="public" output="false">
	<cfreturn getValue("MuraScope") />	
</cffunction>

<cffunction name="getBean" returntype="any" access="public" output="false">
	<cfargument name="beanName">
	<cfargument name="siteID" required="false">
	
	<cfif structKeyExists(arguments,"siteid")>
		<cfreturn super.getBean(arguments.beanName,arguments.siteID)>
	<cfelse>
		<cfreturn super.getBean(arguments.beanName,getValue('siteid'))>
	</cfif>
</cffunction>

</cfcomponent>

