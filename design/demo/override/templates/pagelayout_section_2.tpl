{*?template charset=utf8?*}
{let gallery_limit=8
     gallery_pre_items=2
     gallery_post_items=2}

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="no" lang="no">

<head>
    <link rel="stylesheet" type="text/css" href={"stylesheets/core.css"|ezdesign} />
    <link rel="stylesheet" type="text/css" href={"stylesheets/gallery.css"|ezdesign} />

{include uri="design:page_head.tpl" enable_glossary=false() enable_help=false()}

{* Javascript START *}

<script language="JavaScript">
<!--
{literal}
function OpenWindow ( URL, WinName, Features ) {
	popup = window.open ( URL, WinName, Features );
	if ( popup.opener == null ) {
		remote.opener = window;
	}
	popup.focus();
}
{/literal}

// -->
</script>

{* Javascript END *}

</head>

<body>

<!-- Top box START -->

<img src={"topmenu.gif"|ezimage} alt="" border="0" usemap="#map" />

<map name="map">
<area shape="rect" coords="1,1,71,25" href={"content/view/full/26/"|ezurl}>
<area shape="rect" coords="73,0,156,24" href={"content/view/full/159/"|ezurl}>
<area shape="rect" coords="157,0,228,23" href={"content/view/full/62/"|ezurl}>
<area shape="rect" coords="229,0,299,24" href={"content/view/full/200/"|ezurl}>
<area shape="rect" coords="300,0,372,24" href={"content/view/full/32/"|ezurl}>
<area shape="rect" coords="374,1,448,24" href={"content/view/full/211/"|ezurl}>
<area shape="rect" coords="450,1,523,24" href={"content/view/full/82/"|ezurl}>
<area shape="rect" coords="450,1,523,24" target="_blank" href={"content/view/full/82/"|ezurl}>
</map>

<br />

<img src={"images/whiteboxlogo.png"|ezdesign} alt="White box - contemporary art gallery" />

<!-- Top box END -->
{let gallery_list=fetch(content,list,hash(parent_node_id,16,class_filter_type,include,class_filter_array,array(1)))}
<table class="layout" width="700" cellpadding="1" cellspacing="0" border="0">
<tr>
    <td bgcolor="#cccccc">
    &nbsp;&nbsp;:: <a class="small" href={"content/view/full/82"|ezurl}>About</a><br /> 
    &nbsp;&nbsp;:: <a class="small" href={"content/view/full/82"|ezurl}>Links</a><br /> 
    &nbsp;&nbsp;:: <a class="small" href={"content/view/full/82"|ezurl}>About</a><br /> 
    </td>
    <td bgcolor="#e8e8e8">
    {section name=Gallery loop=$gallery_list}
  {section show=and(eq($DesignKeys:used.node,$Gallery:item.node_id),eq($DesignKeys:used.viewmode,'slideshow'))}
{*  &nbsp;<a href={concat("/content/view/thumbnail/",$Gallery:item.node_id)|ezurl}>{$Gallery:item.name|wash}</a>*}
  <strong class="small">&nbsp;&nbsp;{$Gallery:item.name|wash}</strong>
  {/section}
{/section}
   &nbsp;
    </td>
</tr>
<tr>
    <td class="mainarea" width="99%" valign="top">
<table width="100%" cellspacing="0" cellpadding="10">
<tr>
<td>
<!-- Main area START -->

{$module_result.content}

<!-- Main area END -->
</td>
</tr>
</table>
    </td>
<td width="20%" valign="top" bgcolor="#cccccc" class="links">
            <div align="right">
              <table width="142" border="0" cellpadding="4" cellspacing="1">
{section name=Gallery loop=$gallery_list}
{section show=and(eq($DesignKeys:used.node,$Gallery:item.node_id),eq($DesignKeys:used.viewmode,'slideshow'))}
<tr>
  <td bgcolor="#e2e2e2" class="links"><center>
    <table cellpadding="4" cellspacing="0" border="0">
    <tr>
    {let gallery_page=int(div($DesignKeys:used.view_offset,$gallery_limit))
         gallery_page_offset=mul($Gallery:gallery_page,$gallery_limit)
         gallery_req_offset=max(0,sub($Gallery:gallery_page_offset,$gallery_pre_items))
         gallery_req_limit=sum($gallery_limit,$gallery_post_items,sub($Gallery:gallery_page_offset,$Gallery:gallery_req_offset))
         gallery_item_list=fetch(content,list,hash(parent_node_id,$Gallery:item.node_id,offset,$Gallery:gallery_req_offset,limit,$Gallery:gallery_req_limit))}
    {section name=Item loop=$Gallery:gallery_item_list}

      {* Check for current image *}
{*      {section show=eq($module_result.view_parameters,$Gallery:Item:index)}
      <td>
      {section-else} *}
      <td valign="top" align="left">
{*      {/section} *}

      <a href={concat('content/view/slideshow/',$Gallery:item.node_id,'/offset/',sum($Gallery:Item:index,$Gallery:gallery_req_offset))|ezurl})>{node_view_gui view=small content_node=$Gallery:Item:item}</a>
      </td>
    {delimiter modulo=2}
    </tr>
    <tr>
    {/delimiter}
    {/section}

    {section loop=mod($Gallery:gallery_item_list,2)}
    <td>&nbsp;</td>
    {/section}

    {/let}
    </tr>
    </table></center>
  </td>
</tr>
{section-else}
                <tr>
                  <td bgcolor="#e2e2e2" class="small">&nbsp;<a href={concat("/content/view/thumbnail/",$Gallery:item.node_id)|ezurl}>{$Gallery:item.name|wash}</a></td>
                </tr>
{/section}

{/section}
              </table>
            </div>
	    <br />
	    <center><a href="http://ez.no/developer"><img src={"powered-by-ezpublish-100x35-trans-lgrey.gif"|ezimage} alt="eZ publish" border="0" width="100" height="35" /></a></center>
            </td>
{*
    <td bgcolor="#cccccc" valign="top" width="150">
    <form action={"content/search/"|ezurl} method="get">
    <label class="topline" for="Search">Search:</label><a class="topline" href={"/content/advancedsearch/"|ezurl}><span class="small">Advanced search</span></a><div class="labelbreak"></div>
    <input type="text" size="10" name="SearchText" id="Search" value="" />
    <input class="button" name="SearchButton" type="submit" value="Search" />
    </form>
    </td>
*}
</tr>
<tr>
    <td bgcolor="#e2e2e2" colspan="2">
    <div align="left" style="padding: 0.5em;">
    <p class="small"><a href="http://ez.no/developer">eZ publish&trade;</a> copyright &copy; 1999-2003 <a href="http://ez.no">eZ systems as</a></p>
    </div>
    </td>
</tr>
</table>
{/let}

<div align="center" class="small">
Copyright &copy; <a href="http://ez.no">eZ systems as</a> 1999-2003.
</div>

</body>
</html>
{/let}