<a href={"/sdk/tutorials/view/content_classes"|ezurl} target="_ezpublishmanual"><img src={"help.gif"|ezimage} align="right" alt="help" /></a>

<form action={concat($module.functions.edit.uri,"/",$class.id)|ezurl} method="post" name="ClassEdit">

<div class="maincontentheader">
<h1>{"Editing class - %1"|i18n("design/standard/class/edit",,array($class.name|wash))}</h1>
</div>

<div class="byline">
<p class="date">{"Last modified by"|i18n("design/standard/class/edit")} {content_view_gui view=text_linked content_object=$class.modifier.contentobject} {"on"|i18n("design/standard/class/edit")} {$class.modified|l10n(shortdatetime)}</p>
</div>

<table class="layout" width="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
  <td valign="top">
    <div class="block">
    <label>{"Name"|i18n("design/standard/class/edit")}</label><div class="labelbreak"></div>
    <input type="text" name="ContentClass_name" size="30" value="{$class.name|wash}" />
    </div>

    <div class="block">
    <label>{"Identifier"|i18n("design/standard/class/edit")}</label><div class="labelbreak"></div>
    <input type="text" name="ContentClass_identifier" size="30" value="{$class.identifier|wash}" />
    </div>

    <div class="block">
    <label>{"Object name pattern"|i18n("design/standard/class/edit")}</label><div class="labelbreak"></div>
    <input type="text" name="ContentClass_contentobject_name" size="30" value="{$class.contentobject_name|wash}" />
    </div>
  </td>

  <td valign="top">

<!-- Class group Start -->
<table class="list" width="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
    <th colspan="1">{"Member of groups"|i18n("design/standard/class/edit")}</th>
    <th colspan="1">{"Remove"|i18n("design/standard/class/edit")}</th>
</tr>
{section name=InGroups loop=$class.ingroup_list sequence=array(bglight,bgdark)}
<tr>
    <td class="{$InGroups:sequence}" width="99%">{$InGroups:item.group_name|wash}</td>
    <td class="{$InGroups:sequence}" width="1%" align="right"><input type="checkbox" name="group_id_checked[]" value="{$InGroups:item.group_id}" /></td>
</tr>
{/section}
<tr>
  <td>
    <div class="buttonblock">
    <select name="ContentClass_group">
    {section name=AllGroup loop=$class.group_list}
    <option value="{$AllGroup:item.id}/{$AllGroup:item.name}">{$AllGroup:item.name|wash}</option>
    {/section}
    </select>
    {include uri="design:gui/button.tpl" name=AddGroup id_name=AddGroupButton value="Add to group"|i18n("design/standard/class/edit")}
    </div>
  </td>
  <td align="right">
    <input type="image" name="RemoveGroupButton" value="{'Remove from groups'|i18n('design/standard/class/edit')}" src={"trash.png"|ezimage} />
  </td>
</tr>
</table>
<!-- Class group End -->

  </td>
</tr>

</table>


{section show=$validation.processed}

{section name=UnvalidatedAttributes loop=$validation.attributes show=$validation.attributes}
<div class="warning">
<h2>{"Input did not validate"|i18n("design/standard/class/edit")}</h2>
<ul>
    <li>{$UnvalidatedAttributes:item.identifier}: {$UnvalidatedAttributes:item.name|wash} ({$UnvalidatedAttributes:item.id})</li>
</ul>
</div>
{section-else}
<div class="feedback">
<h2>{"Input was stored successfully"|i18n("design/standard/class/edit")}</h2>
</div>
{/section}

{/section}

<h2>{"Attributes"|i18n("design/standard/class/edit")}</h2>
<table class="class_list" width="100%" cellpadding="0" cellspacing="0" border="0">
{section name=Attributes loop=$attributes sequence=array("bglight","bgdark")}

<tr>
  <td colspan="7"><b>{$:number}. {$:item.name|wash} ({$:item.data_type.information.name|wash})</b></td>
</tr>

<tr>

<!-- Attribute input Start -->

<td class="{$Attributes:sequence}">
<input type="hidden" name="ContentAttribute_id[]" value="{$Attributes:item.id}" />
<input type="hidden" name="ContentAttribute_position[]" value="{$Attributes:item.placement}" />

<div class="block">
<label>{"Name"|i18n("design/standard/class/edit")}</label><div class="labelbreak"></div>
{include uri="design:gui/lineedit.tpl" class="halfbox" name=FieldName id_name="ContentAttribute_name[]" value=$Attributes:item.name}
</div>
</td>

<td class="{$Attributes:sequence}">
<div class="block">
<label>{"Identifier"|i18n("design/standard/class/edit")}</label><div class="labelbreak"></div>
{include uri="design:gui/lineedit.tpl" class="halfbox" name=FieldID id_name="ContentAttribute_identifier[]" value=$Attributes:item.identifier}
</div>
</td>

<!-- Attribute input End -->

<!-- Attribute flags Start -->
<td class="{$Attributes:sequence}" rowspan="2" width="20%" valign="top">

{*
<div class="block">
<label>{"Type"|i18n("design/standard/class/edit")}</label><div class="labelbreak"></div>
<p class="box">{$Attributes:item.data_type.information.name|wash}</p>
</div>
*}

<div class="block">
<input type="checkbox" name="ContentAttribute_is_required_checked[]" value="{$Attributes:item.id}"  {section show=$Attributes:item.is_required}checked="checked"{/section} /><label>{"Required"|i18n("design/standard/class/edit")}</label>
</div>

{section show=$Attributes:item.data_type.is_indexable}
<div class="block">
<input type="checkbox" name="ContentAttribute_is_searchable_checked[]" value="{$Attributes:item.id}"  {section show=$Attributes:item.is_searchable}checked="checked"{/section} /><label>{"Searchable"|i18n("design/standard/class/edit")}</label>
</div>
{/section}

{section show=$Attributes:item.data_type.is_information_collector}
<div class="block">
<input type="checkbox" name="ContentAttribute_is_information_collector_checked[]" value="{$Attributes:item.id}"  {section show=$Attributes:item.is_information_collector}checked="checked"{/section} /><label>{"Information collector"|i18n("design/standard/class/edit")}</label>
</div>
{/section}
</td>
<!-- Attribute flags End -->

<!-- Attribute controls Start -->
  <td class="{$Attributes:sequence}" width="*" rowspan="2">&nbsp;</td>
  <td class="{$Attributes:sequence}" width="1%" rowspan="2"><div class="listbutton"><a href={concat($module.functions.down.uri,"/",$class.id,"/",$Attributes:item.id)|ezurl}><img class="button" src={"button-move_down.gif"|ezimage} height="16" width="16" alt="{'Down'|i18n('design/standard/class/edit')}" /></a></div></td>
  <td class="{$Attributes:sequence}" width="1%" rowspan="2"><div class="listbutton"><a href={concat($module.functions.up.uri,"/",$class.id,"/",$Attributes:item.id)|ezurl}> <img class="button" src={"button-move_up.gif"|ezimage} height="16" width="16" alt="{'Up'|i18n('design/standard/class/edit')}" /></a></div></td>
  <td class="{$Attributes:sequence}" width="1%" rowspan="2"><input type="checkbox" name="ContentAttribute_id_checked[]" value="{$Attributes:item.id}" /></td>
<!-- Attribute controls End -->

</tr>

<tr>
  <td class="{$Attributes:sequence}" colspan="2">
  {class_attribute_edit_gui class_attribute=$Attributes:item}
  </td>
</tr>
{/section}

<tr>
  <td colspan="7">&nbsp;</td>
</tr>

<tr>
  <td colspan="7"><hr/></td>
</tr>
<tr>
  <td colspan="3">
    <div class="buttonblock">
    <label>{"Datatypes"|i18n("design/standard/class/edit")}</label><div class="labelbreak"></div>
    {include uri="design:class/datatypes.tpl" name=DataTypes id_name=DataTypeString datatypes=$datatypes current=$datatype}
    {include uri="design:gui/button.tpl" name=New id_name=NewButton value="New"|i18n("design/standard/class/edit")}
    </div>
  </td>
  <td colspan="4" align="right">
  {section show=$attributes}
    {include uri="design:gui/button.tpl" name=Remove id_name=RemoveButton value="Remove"|i18n("design/standard/class/edit")}
  {section-else}&nbsp;{/section}
  </td>
</tr>
</table>

<div class="buttonblock">
{include uri="design:gui/defaultbutton.tpl" name=Store id_name=StoreButton value="Store"|i18n("design/standard/class/edit")}
{include uri="design:gui/button.tpl" name=Apply id_name=ApplyButton value="Apply"|i18n("design/standard/class/edit")}
{include uri="design:gui/button.tpl" name=Discard id_name=DiscardButton value="Discard Changes"|i18n("design/standard/class/edit")}
</div>

</form>
