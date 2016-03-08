<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step" 
  xmlns:tr="http://transpect.io"
  version="1.0" 
  name="get-repos-from-org" 
  type="tr:get-repos-from-org">
  
  <p:documentation>
    This step provides for all repositories for 
    a given organization on GitHub.
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
  
  <p:option name="org" select="'transpect'">
    <p:documentation>
      The GitHub name of the organization.
    </p:documentation>
  </p:option>
  
  <p:template>
    <p:input port="source">
      <p:empty/>
    </p:input>
    <p:input port="template">
      <p:inline>
        <c:request href="https://api.github.com/orgs/{$org}/repos?per_page=200"
          method="get"
          detailed="false">
          <c:header name="Authorization" value="token {$token}"/>
        </c:request>
      </p:inline>
    </p:input>
    <p:with-param name="token" select="$token"/>
    <p:with-param name="org" select="$org"/>
  </p:template>
  
  <p:http-request/>
  
</p:declare-step>