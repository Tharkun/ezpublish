<?php
//
// Created on: <11-Aug-2003 18:12:39 amos>
//
// Copyright (C) 1999-2004 eZ systems as. All rights reserved.
//
// This source file is part of the eZ publish (tm) Open Source Content
// Management System.
//
// This file may be distributed and/or modified under the terms of the
// "GNU General Public License" version 2 as published by the Free
// Software Foundation and appearing in the file LICENSE included in
// the packaging of this file.
//
// Licencees holding a valid "eZ publish professional licence" version 2
// may use this file in accordance with the "eZ publish professional licence"
// version 2 Agreement provided with the Software.
//
// This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING
// THE WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE.
//
// The "eZ publish professional licence" version 2 is available at
// http://ez.no/ez_publish/licences/professional/ and in the file
// PROFESSIONAL_LICENCE included in the packaging of this file.
// For pricing of this licence please contact us via e-mail to licence@ez.no.
// Further contact information is available at http://ez.no/company/contact/.
//
// The "GNU General Public License" (GPL) is available at
// http://www.gnu.org/copyleft/gpl.html.
//
// Contact licence@ez.no if any conditions of this licencing isn't clear to
// you.

//

include_once( "kernel/common/template.php" );
include_once( "kernel/classes/ezpackage.php" );

$module =& $Params['Module'];
$viewMode = $Params['ViewMode'];
$packageName = $Params['PackageName'];
$repositoryID = false;
if ( isset( $Params['RepositoryID'] ) and $Params['RepositoryID'] )
    $repositoryID = $Params['RepositoryID'];

$package =& eZPackage::fetch( $packageName, false, $repositoryID );
if ( !is_object( $package ) )
    return $module->handleError( EZ_ERROR_KERNEL_NOT_AVAILABLE, 'kernel' );

if ( !$package->attribute( 'can_read' ) )
    return $module->handleError( EZ_ERROR_KERNEL_ACCESS_DENIED, 'kernel' );


if ( $module->isCurrentAction( 'Export' ) )
{
    return $module->run( 'export', array( $packageName ) );
}
else if ( $module->isCurrentAction( 'Install' ) )
{
    return $module->redirectToView( 'install', array( $packageName ) );
}
else if ( $module->isCurrentAction( 'Uninstall' ) )
{
    return $module->redirectToView( 'uninstall', array( $packageName ) );
}

$repositoryInformation = $package->currentRepositoryInformation();

$tpl =& templateInit();

$tpl->setVariable( 'package_name', $packageName );
$tpl->setVariable( 'repository_id', $repositoryID );

$Result = array();
$Result['content'] =& $tpl->fetch( "design:package/view/$viewMode.tpl" );
$path = array( array( 'url' => 'package/list',
                      'text' => ezi18n( 'kernel/package', 'Packages' ) ) );
if ( $repositoryInformation and $repositoryInformation['id'] != 'local' )
{
    $path[] = array( 'url' => 'package/list/' . $repositoryInformation['id'],
                     'text' => $repositoryInformation['name'] );
}
$path[] = array( 'url' => false,
                 'text' => $package->attribute( 'name' ) );
$Result['path'] = $path;

?>
