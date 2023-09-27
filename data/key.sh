function makeSignature() {
	nl=$'\\n'

	TIMESTAMP=$(echo $(($(date +%s%N)/1000000)))
	ACCESSKEY=$GITHUB_JOB
    echo $ACCESSKEY
	SECRETKEY="{secretKey}"				
    
	METHOD="GET"
	URI="/photos/puppy.jpg?query1=&query2"

	SIG="$METHOD"' '"$URI"${nl}
	SIG+="$TIMESTAMP"${nl}
	SIG+="$ACCESSKEY"

	SIGNATURE=$(echo -n -e "$SIG"|iconv -t utf8 |openssl dgst -sha256 -hmac $SECRETKEY -binary|openssl enc -base64)

	echo $SIGNATURE
}

TOKEN=$( makeSignature )