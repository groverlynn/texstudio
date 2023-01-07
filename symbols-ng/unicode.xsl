<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="charlist">
<html>
	<head>
		<title>unicode.xml</title>
		<style>
		div.tableContainer {
			width: 95%;		/* table width will be 99% of this*/
			height: 600px; 	/* must be greater than tbody*/
			overflow: auto;
			margin: 0 auto;
			}
		
		table {
			width: 99%;		/*100% of container produces horiz. scroll in Mozilla*/
			border: none;
			background-color: #f7f7f7;
			}
		
		table>tbody {  /* child selector syntax which IE6 and older do not support*/
			overflow: auto;
			height: 570px;
			overflow-x: hidden;
			}
			
		thead tr {
			position: sticky;
			top: 0px;
			background: white;
			}
			
		thead td, thead th {
			text-align: center;
			font-size: 14px;
			background-color: oldlace;
			color: steelblue;
			font-weight: bold;
			border-top: solid 1px #d8d8d8;
				}
			
		td {
			color: #000;
			padding-right: 2px;
			font-size: 12px;
			text-align: left;
			border-bottom: solid 1px #d8d8d8;
			border-left: solid 1px #d8d8d8;
			}
		
		tfoot td {
			text-align: center;
			font-size: 11px;
			font-weight: bold;
			background-color: papayawhip;
			color: steelblue;
			border-top: solid 2px slategray;
			}
		
		td:last-child {padding-right: 20px;} /*prevent Mozilla scrollbar from hiding cell content*/
		
		</style>
	</head>
	<body>
		<div class="tableContainer">
			<table>
				<thead>
					<tr class="head">
						<td>ID</td><td>Glyphs</td>
						<td>UNICODE DESCRIPTION</td><td>Entity</td><td>mode</td><td>type</td><td>latex</td>
						<td>category</td>
						<td>op dict</td>
					</tr>
				</thead>
				<tbody>
					<xsl:apply-templates select="character"/>
				</tbody>
			</table>
		</div>
	</body>
</html>
</xsl:template>

<xsl:template match="character">
<tr>
	<td><xsl:value-of select="@id"/></td>
	<td><xsl:text disable-output-escaping="yes">&amp;&#35;</xsl:text>
		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="@dec" />
			<xsl:with-param name="replace" select="'&#45;'" />
			<xsl:with-param name="by" select="'&#59;&amp;&#35;'" />
		</xsl:call-template>
		<xsl:text disable-output-escaping="yes">&#59;</xsl:text>
	</td>
	<td><xsl:value-of select="description"/></td>
	<td><xsl:if test="not(entity)">&#160;</xsl:if>
		<xsl:for-each select="entity/@id[not(.=../preceding-sibling::entity/@id)]">
		<xsl:value-of select="."/>
		<xsl:text> </xsl:text>
	</xsl:for-each></td>
	<td><xsl:if test="not(@mode)">&#160;</xsl:if><xsl:value-of select="@mode"/></td>
	<td><xsl:if test="not(@type)">&#160;</xsl:if><xsl:value-of select="@type"/></td>
	<td><xsl:if test="not(latex)">&#160;</xsl:if><xsl:value-of select="latex"/></td>
	<td><xsl:if test="not(unicodedata/@category)">&#160;</xsl:if><xsl:value-of select="unicodedata/@category"/></td>
	<td><xsl:if test="not(operator-dictionary)">&#160;</xsl:if>
		<xsl:for-each select="operator-dictionary/@form">
			<xsl:value-of select="."/>
			<xsl:text> </xsl:text>
		</xsl:for-each>
		<xsl:for-each select="operator-dictionary/@*[.='true']">
			<xsl:value-of select="name()"/>
			<xsl:text> </xsl:text>
		</xsl:for-each>
	</td>
</tr>
</xsl:template>

<xsl:template name="string-replace-all">
	<xsl:param name="text" />
	<xsl:param name="replace" />
	<xsl:param name="by" />
	<xsl:choose>
		<xsl:when test="$text = '' or $replace = '' or not($replace)" >
			<!-- Prevent this routine from hanging -->
			<xsl:value-of select="$text" disable-output-escaping="yes" />
		</xsl:when>
		<xsl:when test="contains($text, $replace)">
			<xsl:value-of select="substring-before($text,$replace)" disable-output-escaping="yes" />
			<xsl:value-of select="$by" disable-output-escaping="yes" />
			<xsl:call-template name="string-replace-all">
				<xsl:with-param name="text" select="substring-after($text,$replace)" />
				<xsl:with-param name="replace" select="$replace" />
				<xsl:with-param name="by" select="$by" />
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$text" disable-output-escaping="yes" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>