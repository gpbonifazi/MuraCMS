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

<cfsilent>
<cfset rsData=application.dataCollectionManager.read(attributes.responseid)/>
</cfsilent>
<cfoutput>
<form novalidate="novalidate" name="form1" action="index.cfm" method="post">
<dl class="oneColumn">
<cfsilent><cfwddx action="wddx2cfml" input="#rsdata.data#" output="info"></cfsilent>
<dt>Date/Time Entered</dt>
<dd>#rsdata.entered#</dd>
<cfloop list="#attributes.fieldnames#" index="f">
	<cftry><cfset fValue=info['#f#']><cfcatch><cfset fValue=""></cfcatch></cftry>
	<cfif findNoCase('attachment',f) and isValid("UUID",fvalue)>
	<input type="hidden" name="#f#" value="#fvalue#">
	<cfelse>
	<dt>#f#</dt><dd><cfif len(fValue) gt 100><textarea name="#f#">#HTMLEditFormat(fvalue)#</textarea><cfelse><input type="text" name="#f#" value="#HTMLEditFormat(fvalue)#"></cfif></dd>
	</cfif>
</cfloop>
</dl>
<a class="submit" href="javascript:;" onclick="return submitForm(document.forms.form1,'update');"><span>#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.fields.update')#</span></a><a class="submit" href="javascript:;" onclick="return submitForm(document.forms.form1,'delete','This');"><span>#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.fields.deleteresponse')#</span></a>
<input type="hidden" name="formid" value="#HTMLEditFormat(attributes.contentid)#">
<input type="hidden" name="contentid" value="#HTMLEditFormat(attributes.contentid)#">
<input type="hidden" name="siteid" value="#HTMLEditFormat(attributes.siteid)#">
<input type="hidden" name="fuseaction" value="cArch.datamanager">
<input type="hidden" name="responseID" value="#rsdata.responseID#">
<input type="hidden" name="hour1" value="#attributes.hour1#">
<input type="hidden" name="hour2" value="#attributes.hour2#">
<input type="hidden" name="minute1" value="#attributes.minute1#">
<input type="hidden" name="minute2" value="#attributes.minute2#">
<input type="hidden" name="date1" value="#attributes.date1#">
<input type="hidden" name="date2" value="#attributes.date2#">
<input type="hidden" name="fieldlist" value="#attributes.fieldnames#">
<input type="hidden" name="sortBy" value="#attributes.sortBy#">
<input type="hidden" name="sortDirection" value="#attributes.sortDirection#">
<input type="hidden" name="filterBy" value="#attributes.filterBy#">
<input type="hidden" name="keywords" value="#HTMLEditFormat(attributes.keywords)#">
<input type="hidden" name="entered" value="#rsData.entered#">
<input type="hidden" name="moduleid" value="#attributes.moduleid#">
<input type="hidden" name="action" value="update">
</form>
</cfoutput>