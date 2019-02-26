# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include nginx
class nginx {
  class {nginx::setupnginxrepo:}
  class {nginx::installnginx:}
  class {nginx::servicenginx:}

}
