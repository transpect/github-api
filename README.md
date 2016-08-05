# github-api
XProc steps that implement the GitHub API

## Description

Currently there exist two XProc steps for requesting the GitHub API. They use primarily XProc's `p:http-request` and rely on the capability of the XProc processor to expose JSON as XML internally. 

## Dependencies

The GitHub API responds to HTTP requests with JSON messages. In order, the XProc steps rely on an XProc processor which is able to automatically convert the JSON provided by the API to an XML representation. [XML Calabash](http://xmlcalabash.com/) use a proprietary extension named [transparentJSON](xmlcalabash.com/docs/reference/langext.html#ext.transparent-json) for this purpose. [MorganaXProc](http://www.xml-project.com/) is currently not capable of exposing JSON as XML so we suggest to use XML Calabash. 

## Authentification

The GitHub API limits the number of requests to 60 requests per day. To bypass this limit, you have to generate an access token in your GitHub settings. You can pass this token with the equally named option `token`.

## Steps

### tr:list-repos

#### options 

`token`: GitHub access token

`username`: name of the user or organization

`group`: Belongs the username to a regular user or to an organization? The following values are permitted: `users` and `orgs`

### tr:repo-directory-list

#### options 

`token`: GitHub access token

`contents-url`: GitHub contents URL. If you request a repository, this information is shipped within `j:contents_005furl`. Here is an example for a contents URL: `https://api.github.com/repos/transpect/github-api/contents`
