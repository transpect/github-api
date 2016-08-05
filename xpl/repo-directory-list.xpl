<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:cx="http://xmlcalabash.com/ns/extensions"
  xmlns:j="http://marklogic.com/json"
  xmlns:tr="http://transpect.io"
  name="repo-directory-list"
  type="tr:repo-directory-list"
  version="1.0">
  
  <p:documentation>
    This step takes a GitHub content URL and provides a recursive listing of 
    files and directories in transparent JSON notation.
  </p:documentation>
  
  <p:output port="result">
    <p:documentation>
      Provides a transparent JSON representation of the results.
    </p:documentation>
  </p:output>
  
  <p:option name="token" required="true">
    <p:documentation>
      Personal access tokens you have generated that can be 
      used to access the GitHub API.
    </p:documentation>
  </p:option>
  <p:option name="contents-url" required="true">
    <p:documentation>
      THe contents URL of the repo. You can get the contents URL 
      by a repository query.
    </p:documentation>
  </p:option>
  
  <p:import href="http://xmlcalabash.com/extension/steps/library-1.0.xpl"/>
  
  <cx:message>
    <p:input port="source">
      <p:empty/>
    </p:input>
    <p:with-option name="message" select="'[list] ', $contents-url"/>
  </cx:message>
  
  <p:template>
    <p:input port="template">
      <p:inline>
        <c:request href="{$contents-url}"
          method="get"
          detailed="false">
          <c:header name="Authorization" value="token {$token}"/>
        </c:request>
      </p:inline>
    </p:input>
    <p:with-param name="token" select="$token"/>
    <p:with-param name="contents-url" select="$contents-url"/>
  </p:template>
  
  <p:http-request name="http-request"/>
  
  <p:add-attribute attribute-name="xml:base" match="/j:json">
    <p:with-option name="attribute-value" select="$contents-url"/>
  </p:add-attribute>
  
  <p:viewport match="/j:json/j:item[j:type eq 'dir']" name="viewport">
    
    <tr:repo-directory-list name="recursive-repo-listing2">
      <p:with-option name="token" select="$token"/>
      <p:with-option name="contents-url" select="concat($contents-url, '/', j:item/j:name)"/>      
    </tr:repo-directory-list>
    
    <p:insert cx:depends-on="recursive-repo-listing2" match="j:item" position="last-child">
      <p:input port="source">
        <p:pipe port="current" step="viewport"/>
      </p:input>
      <p:input port="insertion">
        <p:pipe port="result" step="recursive-repo-listing2"/>
      </p:input>
    </p:insert>
    
  </p:viewport>
  
</p:declare-step>
