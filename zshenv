export OFF_USER="mshah"

# Configure and unconfigure proxy variables as required by apps
function proxy () {
    local PROXYADDR="http://webproxy.corp.booking.com:3128"
    local OPTION="$1"
    if [[ $OPTION == "0"  || $OPTION == "off" ||  $OPTION == "no" ]]; then
        unset http_proxy
        unset https_proxy
        unset HTTP_PROXY
        unset HTTPS_PROXY
        unset no_proxy
          
        printf "Proxy off\n"
    elif [[ $OPTION == "1" ||  $OPTION == "on" || $OPTION == "yes" ]]; then
        export http_proxy="$PROXYADDR"
        export https_proxy="$PROXYADDR"
        export HTTP_PROXY="$PROXYADDR"
        export HTTPS_PROXY="$PROXYADDR"
        export no_proxy="localhost,127.0.0.1"
          
        printf "Proxy configured to $PROXYADDR\n"
    else
        printf "http_proxy=$http_proxy\n"
        printf "https_proxy=$https_proxy\n"
        printf "HTTP_PROXY=$HTTP_PROXY\n"
        printf "HTTPS_PROXY=$HTTPS_PROXY\n"
        printf "Please use 0/1, on/off, yes,no\n"
    fi
}
