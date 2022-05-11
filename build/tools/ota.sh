RESET='\033[0m'           # Text Reset
BLACK='\033[0;30m'        # Black
RED='\033[0;31m'          # Red
GREEN='\033[0;32m'        # Green
YELLOW='\033[0;33m'       # Yellow
BLUE='\033[0;34m'         # Blue
PURPLE='\033[0;35m'       # Purple
CYAN='\033[0;36m'         # Cyan
WHITE='\033[0;37m'        # White

CODENAME=$1
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
DIR="../../../../"

if [[ ! -f "$SCRIPTDIR/roomservice.py" ]]; then
    echo "Script is only supposed to work with vendor/cipher!"
    exit
fi

if [[ $1 == "" ]]; then
    echo "Provide a device codename!"
    echo "Usage: $0 <codename>"
    exit
fi


echo -e "${GREEN}"
echo "Creating json for $CODENAME"
echo -e "${YELLOW}"
echo "{"
echo '"response": ['
echo "{"
echo ' "datetime":' "\"$(grep ro\.build\.date\.utc "$DIR"/out/target/product/"$CODENAME"/system/build.prop | cut -d= -f2)\","
echo ' "filename":' "\"$(basename $(ls "$DIR"/out/target/product/"$CODENAME"/CipherOS-3*.zip))\","
echo ' "id":' "\"$((cat "$DIR"/out/target/product/"$CODENAME"/CipherOS-3*.zip.md5sum) | cut -d ' ' -f1)\","
echo ' "romtype":'"\"STABLE\","
echo ' "size":' "\"$(stat -c%s "$DIR"/out/target/product/"$CODENAME"/CipherOS-3*.zip)\","
echo ' "url":' "\"https://master.dl.sourceforge.net/project/cipheros/Cipher-3.x/COMET/"$CODENAME"/$(basename $(ls "$DIR"/out/target/product/"$CODENAME"/CipherOS-3*.zip))\","
echo ' "version":' "\"3.4-COMET\""
echo "}"
echo "]"
echo "}"
