<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step" 
  xmlns:tr="http://transpect.io"
  version="1.0" 
  name="list-repos" 
  type="tr:list-repos">
  
  <p:documentation>
    This step provides all repositories either for 
    a certain username or organization on GitHub.
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
  
  <p:option name="username" select="'transpect'">
    <p:documentation>
      The GitHub name of the organization.
    </p:documentation>
  </p:option>

  <p:option name="group" select="'orgs'">
    <p:documentation>
      The type of the GitHub user. Must be either 'orgs' for
      organizations or 'users' for regular users.
    </p:documentation>
  </p:option>
  
  <p:choose>
    <p:when test="$group = ('orgs', 'users')">
  
      <p:template>
        <p:input port="source">
          <p:empty/>
        </p:input>
        <p:input port="template">
          <p:inline>
            <c:request href="https://api.github.com/{$group}/{$username}/repos?per_page=200"
              method="get"
              detailed="false">
              <c:header name="Authorization" value="token {$token}"/>
            </c:request>
          </p:inline>
        </p:input>
        <p:with-param name="token" select="$token"/>
        <p:with-param name="username" select="$username"/>
        <p:with-param name="group" select="$group"/>
      </p:template>
  
    </p:when>
    <p:otherwise>
      <p:error code="wrong-group-option-value">
        <p:input port="source">
          <p:inline>
            <c:error code="wrong-group-option-value">
              Only the values 'orgs' and 'users' are permitted values for the option 'group'.
            </c:error>
          </p:inline>
        </p:input>
      </p:error>
    </p:otherwise>
  </p:choose>
  
  
  
  <p:http-request/>
  
</p:declare-step>