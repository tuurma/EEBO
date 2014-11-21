<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:n="www.example.com"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!--
This software is dual-licensed:

1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
Unported License http://creativecommons.org/licenses/by-sa/3.0/ 

2. http://www.opensource.org/licenses/BSD-2-Clause
		
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.

This software is provided by the copyright holders and contributors
"as is" and any express or implied warranties, including, but not
limited to, the implied warranties of merchantability and fitness for
a particular purpose are disclaimed. In no event shall the copyright
holder or contributors be liable for any direct, indirect, incidental,
special, exemplary, or consequential damages (including, but not
limited to, procurement of substitute goods or services; loss of use,
data, or profits; or business interruption) however caused and on any
theory of liability, whether in contract, strict liability, or tort
(including negligence or otherwise) arising in any way out of the use
of this software, even if advised of the possibility of such damage.

$Id$

20014, TEI Consortium
-->
    <!-- 
Read TEI P5 document and construct markdown readme file with summary of the file textual content and tag usage
-->
    <xsl:output method="text"/>
    
    <!-- turn on debug messages -->
    <xsl:param name="debug">true</xsl:param>
    <!-- turn on messages -->
    <xsl:param name="prefix"/>
    <xsl:param name="verbose">true</xsl:param>
    
    <xsl:key name="Atts" match="@*" use="local-name(parent::*)"/>
    <xsl:key name="attVals" match="@*" use="concat(local-name(parent::*),local-name())"/>
    <xsl:key name="IDENTS" use="@ident" match="*[@ident]"/>
    <xsl:key name="All" match="*" use="'1'"/>
    <xsl:key name="AllTEI" match="tei:*" use="t"/>
    <xsl:key name="E" match="*" use="local-name()"/>
    <xsl:key name="Elements" match="*" use="'1'"/>
    
    
    <xsl:template name="main" match="/">
  
        <xsl:if test="$debug='true'">
            <xsl:message>Process </xsl:message>
        </xsl:if>
   
        
        <xsl:variable name="all">
           <xsl:if test="$verbose='true'">
                        <xsl:message>processing <xsl:value-of
                            select="base-uri(.)"/>, root element is <xsl:value-of select="name(.)"/>        </xsl:message>
          </xsl:if>
            
            <xsl:text>#</xsl:text><xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title"/><xsl:text>#&#xa;</xsl:text>
            <xsl:for-each select="/TEI/teiHeader/fileDesc/titleStmt/author">
                <xsl:text>##</xsl:text><xsl:value-of select="."/><xsl:text>##&#xa;</xsl:text>
            </xsl:for-each>

            <xsl:for-each select="/TEI/teiHeader/fileDesc/titleStmt/*[not(author) and not(title)]">
                <xsl:text></xsl:text><xsl:value-of select="."/><xsl:text>&#xa;</xsl:text>
            </xsl:for-each>
            
            <xsl:text>##Header Summary##&#xa;</xsl:text>
            <xsl:for-each select="/TEI/teiHeader/*[not(fileDesc)]">
                <xsl:apply-templates mode="header"/>
            </xsl:for-each>
            
            <xsl:text>##Content Summary##&#xa;</xsl:text>
            
            
 
            <xsl:text>##Tag Usage Summary##&#xa;</xsl:text>
           
            <xsl:call-template name="tagUsage">
                <xsl:with-param name="set">
                    <xsl:copy-of select="/TEI/teiHeader//*"/>
                </xsl:with-param>
                <xsl:with-param name="label">Header Tag Usage</xsl:with-param>
            </xsl:call-template>
            
            <xsl:call-template name="tagUsage">
                <xsl:with-param name="set">
                    <xsl:copy-of select="/TEI/text//*"/>
                </xsl:with-param>
                <xsl:with-param name="label">Text Tag Usage</xsl:with-param>
            </xsl:call-template>
            
        </xsl:variable>
        
        <xsl:copy-of select="$all"/>
    </xsl:template>

    <xsl:template match="note | title | projectDesc" mode="header">
        <xsl:text>*</xsl:text><xsl:value-of select="name()"/><xsl:text>*</xsl:text><xsl:apply-templates mode="header"/><xsl:text>&#xa;</xsl:text>   
    </xsl:template>

    <xsl:template name="tagUsage">
        <xsl:param name="set"/>
        <xsl:param name="label"/>
        <xsl:text>###</xsl:text>
        <xsl:value-of select="$label"/>
        <xsl:text>###</xsl:text>
        <xsl:text>&#xa;</xsl:text>

        <xsl:for-each-group select="$set/*" group-by="local-name()">
            <xsl:sort select="local-name()"/>
            
            <xsl:text>1.  __</xsl:text><xsl:value-of select="current-grouping-key()"/> <xsl:text>__: </xsl:text><xsl:value-of select="count(current-group())"/>
            <xsl:text>&#xa;</xsl:text>    
            <xsl:variable name="eName" select="current-grouping-key()"/>
            <xsl:for-each-group select="$set//*[local-name()=$eName]/@*" group-by="name()">
                
                <xsl:text>  * @_</xsl:text><xsl:value-of select="current-grouping-key()"/><xsl:text>_: </xsl:text>
                <xsl:value-of select="count(current-group())"/><xsl:text> _</xsl:text><xsl:value-of select="distinct-values(current-group())"/><xsl:text>_</xsl:text>
                <xsl:text>&#xa;</xsl:text>    
            </xsl:for-each-group>
            
        </xsl:for-each-group>
        <xsl:text>&#xa;</xsl:text>
        
    </xsl:template>
    
    
    
    
    
</xsl:stylesheet>