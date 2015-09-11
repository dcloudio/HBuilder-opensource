require 'ruble'

command t(:insert_missing_requires) do |cmd|
  #cmd.key_binding = 'M1+M2+3'
  cmd.output = :insert_as_snippet
  cmd.input = :selection, :document
  cmd.scope = "source.ruby"
  cmd.invoke do |context|
    requires = { "abbrev"           => [/\babbrev\b/],
                 "base64"           => [/\bBase64\b/],
                 "benchmark"        => [/\bBenchmark\b/],
                 "bigdecimal"       => [/\bBigDecimal\b/],
                 "bigdecimal/math"  => [/\bBigMath\b/],
                 "cgi"              => [/\bCGI\b/],
                 "complex"          => [/\bComplex\b/],
                 "csv"              => [/\bCSV\b/],
                 "curses"           => [/\bCurses\b/],
                 "date"             => [/\bDate(?:Time)?\b/],
                 "dbm"              => [/\bDBM\b/],
                 "delegate"         => [ /\bDelegateClass\b/, /\bDelegator\b/,
                                         /\bSimpleDelegator\b/ ],
                 "digest"           => [/\bMD5\b/, /\bSHA1\b/],
                 "dl"               => [/\bDL\b/],
                 "enumerator"       => [ /\b(?:enum|each)_(?:cons|slice)\b/,
                                         /\benum_(?:for|with_index)\b/,
                                         /\bto_enum\b/ ],
                 "erb"              => [/\bERB\b/],
                 "etc"              => [/\bEtc\b/],
                 "fcntl"            => [/\bFcntl\b/],
                 "fileutils"        => [/\bFileUtils\b/],
                 "find"             => [/\bFind(?:\.|::)find\b/],
                 "forwardable"      => [/\b(?:Single)?Forwardable\b/],
                 "gdbm"             => [/\bGDBM\b/],
                 "generator"        => [/\bGenerator\b/, /\bSyncEnumerator\b/],
                 "getoptlong"       => [/\bGetoptLong\b/],
                 "gserver"          => [/\bGServer\b/],
                 "iconv"            => [/\bIconv\b/],
                 "ipaddr"           => [/\bIpAddr\b/],
                 "logger"           => [/\bLogger\b/],
                 "matrix"           => [/\bMatrix\b/, /\bVector\b/],
                 "monitor"          => [/\bMonitor(?:Mixin)?\b/],
                 "net/ftp"          => [/\bNet::FTP\b/],
                 "net/http"         => [/\bNet::HTTP\b/],
                 "net/imap"         => [/\bNet::IMAP\b/],
                 "net/pop"          => [/\bNet::(?:APOP|POP3)\b/],
                 "net/smtp"         => [/\bNet::SMTP\b/],
                 "net/telnet"       => [/\bNet::Telnet\b/],
                 "nkf"              => [/\bNKF\b/],
                 "observer"         => [/\bObservable\b/],
                 "open3"            => [/\bOpen3\b/],
                 "optparse"         => [/\bOptionParser\b/],
                 "ostruct"          => [/\bOpenStruct\b/],
                 "pathname"         => [/\bPathname\b/],
                 "ping"             => [/\bPing\b/],
                 "pp"               => [/\bpp\b/],
                 "pstore"           => [/\bPStore\b/],
                 "rational"         => [/\bRational\b/],
                 "rdoc/usage"       => [/\bRDoc(?:\.|::)usage\b/],
                 "rdoc/markup/simple_markup" \
                                    => [/\bSM::SimpleMarkup\b/],
                 "rdoc/markup/simple_markup/to_html" \
                                    => [/\bSM::SimpleMarkup\b/],
                 "rdoc/usage"       => [/\bRDoc(?:\.|::)usage\b/],
                 "resolv"           => [/\bResolv\b/],
                 "rexml/document"   => [/\bREXML\b/],
                 "rinda/tuplespace" => [/\bRinda::TupleSpace(?:Proxy)?\b/],
                 "rinda/ring"       => [/\bRinda::Ring(?:Finger|Server)?\b/],
                 "rss"              => [/\bRSS\b/],
                 "scanf"            => [/\bscanf\b/],
                 "sdbm"             => [/\bSDBM\b/],
                 "set"              => [/\b(?:Sorted)?Set\b/],
                 "singleton"        => [/\bSingleton\b/],
                 "soap"             => [/\bSOAP\b/],
                 "socket"           => [ /\b(?:TCP|UNIX)(?:Socket|Server)\b/,
                                         /\b(?:UDP)?Socket\b/ ],
                 "stringio"         => [/\bStringIO\b/],
                 "strscan"          => [/\bStringScanner\b/],
                 "syslog"           => [/\bSyslog\b/],
                 "tempfile"         => [/\bTempfile\b/],
                 "test/unit"        => [/\bTest::Unit\b/],
                 "thread"           => [ /\bConditionVariable\b/, /\bMutex\b/,
                                         /\b(?:Sized)?Queue\b/ ],
                 "time"             => [/\bTime(?:\.|::)parse\b/],
                 "timeout"          => [/\bTimeout(?:\.|::)timeout\b/],
                 "tk"               => [/\bTK\b/],
                 "tmpdir"           => [/\bDir(?:\.|::)tmpdir\b/],
                 "tracer"           => [/\bTracer\b/],
                 "tsort"            => [/\bTSort\b/],
                 "uri"              => [/\bURI\b/],
                 "weakref"          => [/\bWeakRef\b/],
                 "webrick"          => [/\bWEBrick\b/],
                 "Win32API"         => [/\bWin32(?:API)?\b/],
                 "win32ole"         => [/\bWIN32OLE\b/],
                 "wsdl"             => [/\bWSDL\b/],
                 "xmlrpc"           => [/\bXMLRPC\b/],
                 "yaml"             => [/\bYAML\b/],
                 "zlib"             => [/\bZlib\b/] }
    cursor = [0xFFFC].pack("U").freeze
    line, col = ENV["TM_LINE_NUMBER"].to_i - 1, ENV["TM_LINE_INDEX"].to_i
    code = $stdin.read.to_a
    unless ENV.has_key?('TM_SELECTED_TEXT')
      if code[line].nil?  # if cursor was on the last line and it was blank
        code << cursor
      else
        code[line][col...col] = cursor
      end
    end
    code = code.join
    libs = requires.select { |lib, usage| usage.any? { |test| code =~ test } }.map { |kv| kv.first }
    
    require 'ruby_requires'
    
    output = RubyRequires.add_requires(code, libs)
    output.split(cursor).join('${0}')
  end
end
