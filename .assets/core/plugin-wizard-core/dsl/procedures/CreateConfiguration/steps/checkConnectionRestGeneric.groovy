// === check_connection template ===
import groovy.json.JsonSlurper
import com.electriccloud.client.groovy.ElectricFlow
import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.Method.GET
import static groovyx.net.http.ContentType.TEXT
import static groovyx.net.http.ContentType.JSON
import org.apache.http.auth.*

{% if oauth1 %}
@Grab(group='com.google.gdata', module='core', version='1.47.1')
@Grab(group='org.bouncycastle', module='bcprov-jdk16', version = '1.45')
import java.security.KeyFactory
import java.security.PrivateKey
import java.security.spec.PKCS8EncodedKeySpec
import com.google.gdata.client.authn.oauth.OAuthParameters
import com.google.gdata.client.authn.oauth.OAuthRsaSha1Signer
import com.google.gdata.client.authn.oauth.OAuthUtil
import com.google.gdata.client.authn.oauth.RsaSha1PrivateKeyHelper
{% endif %}

def checkConnectionMetaString = '''
{{ checkConnectionMeta }}
'''

def checkConnectionMeta = new JsonSlurper().parseText(checkConnectionMetaString)
println "Check Connection Metadata: $checkConnectionMeta"

ElectricFlow ef = new ElectricFlow()
def formalParameters = ef.getFormalParameters(
    projectName: '$[/myProject/name]',
    procedureName: '$[/myProcedure/name]'
)?.formalParameter

println "Formal parameters: $formalParameters"

def endpoint = ef.getProperty(propertyName: "endpoint")?.property?.value
println "Endpoint: $endpoint"
if (!endpoint) {
    handleError("Endpoint is not found (endpoint field does not exist?)")
}
def authType
try {
    authType = ef.getProperty(propertyName: "authScheme")?.property?.value
} catch (Throwable e) {
    // Deduce auth type
    // If we don't have a parameter for auth type, then we have only one auth type and it should be declared in meta
    authType = checkConnectionMeta?.authSchemes?.keySet().first()
    if (!authType) {
        handleError("Cannot deduce auth type: unclear metadata $checkConnectionMetaString")
    }
    println "Deduced Auth Scheme: $authType"
}
println "Auth Scheme: $authType"

def http = new HTTPBuilder(endpoint)

def proxyUrlFormalParameter = formalParameters.find { it.formalParameterName == 'httpProxyUrl'}
if (proxyUrlFormalParameter) {
  def proxyUrl
  try {
    proxyUrl = ef.getProperty(propertyName: "/myCall/httpProxyUrl")?.property?.value
  } catch  (Throwable e) {
  }
  // Need to split into scheme, host and port
  if (proxyUrl) {
    URL url = new URL(proxyUrl)
    http.setProxy(url.host, url.port, url.protocol)
    println "Set proxy $proxyUrl"

    def proxyCredential
    try {
      proxyCredential = ef.getFullCredential(credentialName: 'proxy_credential')?.credential
    } catch(Throwable e) {
    }

    if (proxyCredential && proxyCredential.userName) {
      http.setProxy(url.host, url.port, 'http')
      http.client.getCredentialsProvider().setCredentials(
        new AuthScope(url.host, url.port),
        new UsernamePasswordCredentials(proxyCredential.userName, proxyCredential.password)
      )
      println "Set proxy auth"
    }
  }
}

// Should be ignored after the proxy is set
http.ignoreSSLIssues()

http.request(GET, TEXT) { req ->
  headers.'User-Agent' = 'FlowPDF Check Connection'
  headers.accept = '*'

  if (checkConnectionMeta.headers) {
    headers.putAll(checkConnectionMeta.headers)
    println "Added headers: $checkConnectionMeta.headers"
  }

  uri.query = [:]

  boolean uriChanged = false
  if (authType == "basic") {
    def meta = checkConnectionMeta?.authSchemes?.basic
    def credentialName = meta?.credentialName ?: "basic_credential"
    def basicAuth = ef.getFullCredential(credentialName: credentialName)?.credential
    def username = basicAuth.userName
    def password = basicAuth.password
    if (!username) {
      handleError(ef, "Username is not provided for the Basic Authorization")
    }
    headers.Authorization = "Basic " + (basicAuth.userName + ':' + basicAuth.password).bytes.encodeBase64()
    println "Setting Basic Auth: username $basicAuth.userName"
    if (meta.checkConnectionUri != null) {
        uri.path = augmentUri(uri.path, meta.checkConnectionUri)
        uri.query = fetchQuery(meta.checkConnectionUri)
        println "Check Connection URI: $uri"
        uriChanged = true
    }
  }

  if (authType == "bearerToken") {
    def meta = checkConnectionMeta?.authSchemes?.bearerToken
    def credentialName = meta?.credentialName ?: 'bearer_credential'
    def bearer = ef.getFullCredential(credentialName: credentialName)?.credential
    def prefix = meta.prefix ?: "Bearer"
    headers.Authorization = prefix + " " + bearer.password
    println "Setting Bearer Auth with prefix $prefix"
    if (meta.checkConnectionUri != null) {
        uri.path = augmentUri(uri.path, meta.checkConnectionUri)
        uri.query = fetchQuery(meta.checkConnectionUri)
        println "Check Connection URI: $uri"
        uriChanged = true
    }
  }

  if (authType == "anonymous") {
    println "Anonymous access"
    def meta = checkConnectionMeta?.authSchemes?.anonymous
    if (meta.checkConnectionUri != null) {
      uri.path = augmentUri(uri.path, meta.checkConnectionUri)
      uri.query = fetchQuery(meta.checkConnectionUri)
      println "Check Connection URI: $uri"
      uriChanged = true
    }
  }
  {% if oauth1 %}
  if (authType == 'oauth1') {
    println "OAuth1"
    def meta = checkConnectionMeta?.authSchemes?.oauth1
    if (meta.checkConnectionUri != null) {
      uri.path = augmentUri(uri.path, meta.checkConnectionUri)
      uriChanged = true
      println "Check Connection URI: $uri"
    }

    // Needs to be here because it participates in the signature
    if (checkConnectionMeta.checkConnectionUri != null && !uriChanged) {
      uri.path = augmentUri(uri.path, checkConnectionMeta.checkConnectionUri)
      println "Check Connection URI: $uri"
      uriChanged = true
    }

    String credentialName = meta?.credentialName ?: 'oauth1_credential'
    def cred = ef.getFullCredential(credentialName: credentialName)?.credential
    def token = cred.userName
    def privateKey = cred.password
    def consumerKey = ef.getProperty(propertyName: 'oauth1ConsumerKey')?.property?.value
    String signatureMethod = meta.signatureMethod
    OAuthParameters params = oauthParams(endpoint, uri.path, privateKey, consumerKey, token, signatureMethod)
    uri.query = params.baseParameters
    println "query: $uri.query"
  }
  {% endif %}

  if (checkConnectionMeta.checkConnectionUri != null && !uriChanged) {
    uri.path = augmentUri(uri.path, checkConnectionMeta.checkConnectionUri)
    uri.query = fetchQuery(checkConnectionMeta.checkConnectionUri)
    println "URI: $uri"
  }

  response.success = { resp, reader ->
    assert resp.status == 200
    println "Status Line: ${resp.statusLine}"
    println "Response length: ${resp.headers.'Content-Length'}"
    System.out << reader // print response reader
  }

  response.failure = { resp, reader ->
    println "$resp.statusLine"
    println "$reader"
    String message = "Check Connection Failed: ${resp.statusLine}, $reader"
    handleError(ef, message)
  }
}

def handleError(def ef, def message) {
  ef.setProperty(propertyName: "/myJobStep/summary", value: message)
  ef.setProperty(propertyName: "/myJob/configError", value: message)
  System.exit(-1)
}

def fetchQuery(String uri) {
  def parts = uri.split(/\?/)
  def query = [:]
  if (parts.size() > 1) {
    def queryString = parts[1]
    queryString.split('&').each {
      def p = it.split('=')
      if (p.size() > 1) {
        query.put(p[0], p[1])
      }
    }
  }
  println "Query: $query"
  return query
}

def augmentUri(path, uri) {
    uri = uri.split(/\?/).getAt(0)
    if (path.endsWith('/') || uri.startsWith('/')) {
        path = path + uri
    }
    else {
        path = path + '/' + uri
    }
    return path
}

{% if oauth1 %}
static PrivateKey getPrivateKey(String pkcs8Lines) {
    java.security.Security.addProvider(
        new org.bouncycastle.jce.provider.BouncyCastleProvider()
    );
    String pkcs8Pem = pkcs8Lines.toString();
    pkcs8Pem = pkcs8Pem.replaceAll(/-----[\w\s]+-----/, "");
    pkcs8Pem = pkcs8Pem.replaceAll(/-----[\w\s]-----/, "");
    pkcs8Pem = pkcs8Pem.replaceAll(/\s+/, "");
    PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(pkcs8Pem.decodeBase64())
    KeyFactory kf = KeyFactory.getInstance("RSA")
    PrivateKey privKey = kf.generatePrivate(keySpec)
    return privKey
}

static def oauthParams(String baseUrl,
  String path,
  String privateKey,
  String consumerKey,
  String token,
  String signatureMethod) {
  OAuthRsaSha1Signer rsaSigner = new OAuthRsaSha1Signer()

  rsaSigner.setPrivateKey(getPrivateKey(privateKey))
  OAuthParameters params = new OAuthParameters()
  params.setOAuthConsumerKey(consumerKey)
  params.setOAuthNonce(OAuthUtil.getNonce())
  params.setOAuthTimestamp(OAuthUtil.getTimestamp())
  params.setOAuthSignatureMethod(signatureMethod)
  params.setOAuthType(OAuthParameters.OAuthType.TWO_LEGGED_OAUTH)
  params.setOAuthToken(token)


  def cleanPath = path.replaceAll(/\?.+$/, '')
  // TODO process query in path
  String paramString = params.getBaseParameters().sort().collect{it}.join('&')

  String baseString = [
      OAuthUtil.encode("GET"),
      OAuthUtil.encode(baseUrl + cleanPath),
      OAuthUtil.encode(paramString)
  ].join('&')

  String signature = rsaSigner.getSignature(baseString, params);
  params.addCustomBaseParameter("oauth_signature", signature);
  return params
}
{% endif %}

// === check_connection template ends ===
